import Fetch from '/js/fetch.js';

document.getElementById ("btnLogIn").addEventListener ("click", logIn, false);

document.getElementById ("btnAllMembers").addEventListener ("click", getAllMembers, false);

document.getElementById ("btnGetMember").addEventListener ("click", getMember, false);

document.getElementById ("btnAddMemberPhone").addEventListener ("click", addMemberPhone, false);

document.getElementById ("btnUpdateMemberPhone").addEventListener ("click", updateMemberPhone, false);

document.getElementById ("btnDeleteMemberPhone").addEventListener ("click", deleteMemberPhone, false);

function displayResults(results){
    document.getElementById("results").innerText = JSON.stringify(results);
};

function logIn(){
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;

        firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
            document.getElementById("authResult").innerHTML = error.message;
          });
};



async function getAllMembers() {
    console.log("requesting all members");
    const results = await Fetch.get('/members');
    displayResults(results);   
};

async function getMember() {
    var id = document.getElementById("memberID").value;
    if(id!=""){
        console.log("requesting member:"+ id);
        const results = await Fetch.get('/members/'+ id);
        displayResults(results);   
    } 
};

async function addMemberPhone() {
    var memberID = document.getElementById("phone_memberID").value;
    var phone_type_id = document.getElementById("phone_type_id").value;
    var phone_number = document.getElementById("phone_number").value.replace(/\D/g,'');
    var newPhone = {member_id:memberID, phone_type_id:phone_type_id, phone_number:phone_number};

    const results = await Fetch.create('/members/'+memberID+'/phone', newPhone);
    displayResults(results);   
};
async function updateMemberPhone() {
    var phone_number_id = document.getElementById("update_phone_number_id").value;
    var phone_type_id = document.getElementById("update_phone_type_id").value;
    var phone_number = document.getElementById("update_phone_number").value.replace(/\D/g,'');

    var newPhone = {phone_number_id:phone_number_id, phone_type_id:phone_type_id, phone_number:phone_number};

    const results = await Fetch.update('/members/phone/'+phone_number_id, newPhone);
    displayResults(results);   
};

async function deleteMemberPhone() {
    var phone_number_id = document.getElementById("phone_number_id").value;
    var phone = {phone_number_id:phone_number_id};

    const results = await Fetch.remove('/members/phone/'+phone_number_id);
    displayResults(results);   
};