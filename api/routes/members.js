const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const router = express.Router();
const memberModle = require('../models/member_model.js');

app.use(bodyParser.urlencoded({extended: false}));

// create application/json parser
var jsonParser = bodyParser.json()


router.get('/', (req, res, next) =>{
    // res.status(200).json({
    //     message: 'Handling GET requets to /members'
    // });

    memberModle.getMembersFromDb(function(error, result) {
        // check for rows then send JSON
        if (error || result == null || result.length == 0) {
            res.status(500).json({
                success: false,
                data: error});
        } else {
            console.log("getMembers result: " + JSON.stringify(result.rows));
            res.status(200).json(result.rows);
        }   
    });
});

//add phone to member
router.post('/:memberId/phone/', jsonParser, (req, res, next) =>{
    const memberId = req.body.member_id;
    const phoneTypeId = req.body.phone_type_id.replace(/\D/g,'');;
    const phoneNumber = req.body.phone_number;

    memberModle.addMemberPhone(memberId, phoneTypeId, phoneNumber, function(error, result) {
		// check for rows then send JSON
		if (error || result == null || result.length == 0) {
			res.status(500).json({success: false, data: error});
		} else {
            console.log("addMemberPhone result: " + JSON.stringify(result.rows));
            res.status(200).json(result.rows);
        }   
    });
});

//updtate member phone
router.patch('/phone/:phoneId', jsonParser, (req, res, next) =>{
    const phoneId = req.body.phone_number_id;
    const phoneTypeId = req.body.phone_type_id;
    const phoneNumber = req.body.phone_number;

    memberModle.updateMemberPhone(phoneId, phoneTypeId, phoneNumber, function(error, result) {
		// check for rows then send JSON
		if (error || result == null || result.length == 0) {
			res.status(500).json({success: false, data: error});
		} else {
            console.log("addMemberPhone result: " + JSON.stringify(result.rows));
            res.status(200).json(result.rows);
        }   
    });
});

router.delete('/phone/:phoneId', (req, res, next) =>{
    const phone_number_id = parseInt(req.params.phoneId);
    console.log("phoneId:"+ phone_number_id);
	memberModle.deleteMemberPhone(phone_number_id, function(error, result) {
		// check for rows then send JSON
		if (error) {
			res.status(500).json({success: false, data: error});
		} else {
            console.log("Phone deleted result: " + JSON.stringify(result.rows));
            res.status(200).json({
                message : "Phone ID " + phone_number_id + ' Deleted' 
            });
        }   
    });

});

router.get('/:memberId', (req, res, next) =>{
    const memberId = req.params.memberId;

	memberModle.getMemberDetail(memberId, function(error, result) {
		// check for rows then send JSON
		if (error || result == null || result.length == 0) {
			res.status(500).json({success: false, data: error});
		} else {
            console.log("getMember result: " + JSON.stringify(result.rows));
            res.status(200).json(result.rows);
        }   
    });

});

router.get('/:memberId/address', (req, res, next) =>{
    const memberId = req.params.memberId;

	memberModle.getMemberAddress(memberId, function(error, result) {
		// check for rows then send JSON
		if (error || result == null || result.length == 0) {
			res.status(500).json({success: false, data: error});
		} else {
            console.log("getMemberAddress result: " + JSON.stringify(result.rows));
            res.status(200).json(result.rows);
        }   
    });

});

router.patch('/:memberId', (req, res, next) =>{
    const memberId = req.params.memberId;
    res.status(200).json({
        message: 'Handling PATCH requets to /members/' + memberId
    });
});
 
module.exports = router;