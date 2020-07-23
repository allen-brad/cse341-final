--Get General member Directory
SELECT m.member_id , m.preferred_name || ' ' || m.last_name AS full_name, m.call_sign, p.phone_number
FROM member m
LEFT JOIN member_phone p ON m.member_id = p.member_id AND p.is_primary = true
ORDER BY m.last_name, m.first_name DESC;


--Get member Detail
SELECT m.member_id , m.first_name, m.middle_name, m.last_name, m.preferred_name, m.call_sign, m.dob,
        m.sar_email, m.personal_email, p.phone_number, m.dl_num, m.dl_state, m.ssn_last_four, s.member_status_name, e.full_name, e.cell_phone, e.home_phone
FROM member m
JOIN member_status_type s ON m.member_status_id = s.member_status_id
JOIN member_emergency_contact e ON m.member_id = e.member_id
WHERE m.member_id = 1000;

--Get member Phone Numbers
SELECT p.phone_type_id, p.phone_number, p.is_primary
FROM member_phone p
JOIN member m ON p.member_id = m.member_id
WHERE m.member_id = 1001
ORDER BY p.is_primary DESC;

--Get member Addresses
SELECT a.street1, a.street2, a.street3, a.city, a.state, a.zip
FROM member_address a 
JOIN member m ON a.member_id = m.member_id
WHERE m.member_id = 1000;

--Get member Status
SELECT m.member_status_id, m.member_status_name
FROM member_status_type m 
ORDER BY m.member_status_id ASC;

--member
