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