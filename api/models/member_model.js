require('dotenv').config();
const { Pool } = require("pg"); // This is the postgres database connection module.
const connectionString = process.env.DATABASE_URL;
const pool = new Pool({
    connectionString: process.env.DATABASE_URL ,
    ssl: {
      rejectUnauthorized: false
    }
  });
  
exports.getMembersFromDb = function (callback) {
    //Get General Member Directory
    const sql = "SELECT m.member_id , m.preferred_name || ' ' || m.last_name AS full_name, m.call_sign, p.phone_number \
				FROM member m \
				LEFT JOIN member_phone p ON m.member_id = p.member_id AND p.is_primary = true \
                ORDER BY m.last_name, m.first_name DESC;"
	//runs the query, then calls anonymous callback function with results
	pool.query(sql, function(err, result) {
		if (err) {
			console.log("SQL Error: ")
			console.log(err);
			callback(err, null);
		}
		// no errors so null the error variable and send results
		callback(null, result);
    });
}

exports.getMemberDetail = function (id, callback) {
	console.log("getMemberDetail: " + id);
	// use parameter placeholders like PHP's PDO
    const sql = "SELECT m.member_id , m.first_name, m.middle_name, m.last_name, m.preferred_name, m.call_sign, m.dob, \
				 m.sar_email, m.personal_email, m.dl_num, m.dl_state, m.ssn_last_four, s.member_status_name, p.phone_number AS primary_phone, e.full_name AS emergency_contact, e.cell_phone AS e_contact_cell_phone, e.home_phone AS e_contact_home_phone \
                 FROM member m \
                 JOIN member_status_type s ON m.member_status_id = s.member_status_id \
				 LEFT JOIN member_emergency_contact e ON m.member_id = e.member_id \
				 LEFT JOIN member_phone p ON m.member_id = p.member_id AND p.is_primary = true \
                 WHERE m.member_id = $1::int;"

	//array of all the parameters for the placeholders
	const params = [id];
    //run query with callback
	pool.query(sql, params, function(err, result) {
		// If error...
		if (err) {
			console.log("Error in query: ")
			console.log(err);
			callback(err, null);
		}
        // all good so null the error variable and return results
        callback(null, result);
	});

} // end of getMemberDetail

exports.getMemberAddress = function (id, callback) {
	console.log("getMemberAddress: " + id);
    const sql = "SELECT a.street1, a.street2, a.street3, a.city, a.state, a.zip \
				 FROM member_address a \
				 JOIN member m ON a.member_id = m.member_id \
                 WHERE m.member_id = $1::int;"

	//array of all the parameters for the placeholders
	const params = [id];
    //run query with callback
	pool.query(sql, params, function(err, result) {
		// If error...
		if (err) {
			console.log("Error in query: ")
			console.log(err);
			callback(err, null);
		}
        // all good so null the error variable and return results
        callback(null, result);
	});

} // end of getMemberDetail

exports.addMemberPhone = function (id, phone_type_id, phone_number, callback) {

	const sql = "INSERT INTO member_phone (member_id, phone_type_id, phone_number, is_primary, created_by, last_update_by) \
				 VALUES ($1::int, $2::int, $3::text, $4, $5, $6) \
				 RETURNING member_phone_id"

	//array of all the parameters for the placeholders
	const params = [id, phone_type_id, phone_number, false, id, id];
	console.log("addMemberPhone params: " + JSON.stringify(params));

    //run query with callback
	pool.query(sql, params, function(err, result) {
		// If error...
		if (err) {
			console.log("Error in query: ")
			console.log(err);
			callback(err, null);
		}
		// all good so null the error variable and return results
        callback(null, result);
	});
} 
exports.updateMemberPhone = function (id, phone_type_id, phone_number, callback) {

	const sql = "UPDATE member_phone \
				 SET phone_type_id = $1::int, \
				     phone_number = $2::text \
				 WHERE member_phone_id = $3::int \
				 RETURNING member_phone_id, phone_type_id, phone_number "

	//array of all the parameters for the placeholders
	const params = [phone_type_id, phone_number, id];
	
	console.log("updateMemberPhone params: " + JSON.stringify(params));

    //run query with callback
	pool.query(sql, params, function(err, result) {
		// If error...
		if (err) {
			console.log("Error in query: ")
			console.log(err);
			callback(err, null);
		}
		// all good so null the error variable and return results
        callback(null, result);
	});
} 
 
exports.deleteMemberPhone = function (phone_number_id, callback) {

	const sql = "DELETE FROM member_phone \
				 WHERE  member_phone_id = $1::int"

	//array of all the parameters for the placeholders
	const params = [phone_number_id];
    //run query with callback
	pool.query(sql, params, function(err, result) {
		// If error...
		if (err) {
			console.log("Error in query: ")
			console.log(err);
			callback(err, null);
		}
		// all good so null the error variable and return results
        callback(null, result);
	});
}
