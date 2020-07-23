--Set up status types enum
--INSERT INTO member_status_type (member_status_name) VALUES ('Active'),('Probation'),('Retired'),('Retired');

--Set up phone types enum
--INSERT INTO phone_type (phone_type_name) VALUES ('Mobile'),('Home'),('Work');

--Set up event_type enum
--INSERT INTO event_type (event_type_name) VALUES ('Incident'),('Training'),('Special');


--Seed member
INSERT INTO member (last_name, first_name, middle_name, preferred_name, call_sign, dob, sar_email, personal_email, dl_num, dl_state, ssn_last_four, created_by, last_update_by, created_date, last_update_date, member_status_id )
VALUES ('Allen', 'Brad', 'R', 'Brad', 'L86', '1971-08-24', 'brad.allen@wasatchsar.org','bradrallen@gmaill.com','123456789', 'UT', 1234,1000,1000, current_timestamp, current_timestamp,1);

INSERT INTO member_tenure (start_date, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES ('2010-11-01', current_timestamp, current_timestamp,1000, 1000, 1000);

INSERT INTO member_address (street1, street2, city, "state", zip, created_date, last_update_date, member_id, created_by, last_update_by )
VALUES ('791 S 200 W', NULL, 'Heber City', 'UT', '84032', current_timestamp,current_timestamp, 1000, 1000, 1000);

INSERT INTO member_emergency_contact (full_name, cell_phone, home_phone, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES ('Nina Allen', '4356541234', '4356570320', current_timestamp, current_timestamp, 1000, 1000, 1000);

INSERT INTO member_phone (phone_type_id, phone_number, is_primary, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES (1, '4355031887', true, current_timestamp, current_timestamp,1000, 1000, 1000);

INSERT INTO member_phone (phone_type_id, phone_number, is_primary, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES (2, '4356570320', false, current_timestamp, current_timestamp,1000, 1000, 1000);

--Seed member
INSERT INTO member (last_name, first_name, middle_name, preferred_name, call_sign, dob, sar_email, personal_email, dl_num, dl_state, ssn_last_four, created_by, last_update_by, created_date, last_update_date, member_status_id )
VALUES ('Potter', 'Sherman', 'T', 'Colonel', 'L99', '1901-07-04', 'sherman.potter@wasatchsar.org','colonel.potter@mash.com','123456789', 'MO', 1234,1000,1000, current_timestamp, current_timestamp,3);

INSERT INTO member_tenure (start_date, end_date, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES ('1930-01-01', '1960-01-01',current_timestamp, current_timestamp,1001, 1000, 1000);

INSERT INTO member_address (street1, street2, city, "state", zip, created_date, last_update_date, member_id, created_by, last_update_by )
VALUES ('1234 Main St.', NULL, 'Hannibal', 'MO', '63401', current_timestamp,current_timestamp, 1001, 1000, 1000);

INSERT INTO member_emergency_contact (full_name, cell_phone, home_phone, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES ('Mildred Potter', '4356549876', '4356579876', current_timestamp, current_timestamp, 1001, 1000, 1000);

INSERT INTO member_phone (phone_type_id, phone_number, is_primary, created_date, last_update_date, member_id, created_by, last_update_by)
VALUES (1, '4355039876', true, current_timestamp, current_timestamp,1001, 1000, 1000);