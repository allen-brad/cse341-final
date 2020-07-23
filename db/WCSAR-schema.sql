--Create tables for member Database
DROP TABLE IF EXISTS member_phone;
DROP TABLE IF EXISTS member_emergency_contact;
DROP TABLE IF EXISTS member_address;
DROP TABLE IF EXISTS member_tenure;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS member_status_type;


-- ************************************** memberStatus enum

CREATE TABLE member_status_type
(
 member_status_id  integer NOT NULL GENERATED ALWAYS AS IDENTITY,
 member_status_name varchar(50) NOT NULL,
 CONSTRAINT PK_member_status_type PRIMARY KEY ( member_status_id )
);

-- ************************************** Phone Type enum

CREATE TABLE phone_type
(
 phone_type_id  integer NOT NULL GENERATED ALWAYS AS IDENTITY,
 phone_type_name varchar(50) NOT NULL,
 CONSTRAINT PK_phone_type PRIMARY KEY ( phone_type_id )
);


-- ************************************** member

CREATE TABLE member
(
 member_id       integer NOT NULL GENERATED ALWAYS AS IDENTITY (start 1000),
 last_name        varchar(50) NOT NULL,
 first_name       varchar(50) NOT NULL,
 middle_name      varchar(50) NULL,
 preferred_name   varchar(25) NOT NULL,
 call_sign        varchar(10) NOT NULL,
 dob              date NOT NULL,
 sar_email        varchar(50) NOT NULL,
 personal_email   varchar(50) NOT NULL,
 dl_num           varchar(20) NOT NULL,
 dl_state         varchar(2) NOT NULL,
 ssn_last_four    integer NOT NULL,
 created_by       integer NOT NULL,
 last_update_by   integer NOT NULL,
 created_date     timestamp with time zone default current_timestamp,
 last_update_date timestamp with time zone default current_timestamp,
 member_status_id integer NOT NULL,
 CONSTRAINT PK_member PRIMARY KEY ( member_id ),
 CONSTRAINT FK_member_member_status_type FOREIGN KEY ( member_status_id ) REFERENCES member_status_type ( member_status_id ),
 CONSTRAINT FK_member_member_1 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_member_2 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON member
(
 member_status_id
);

-- ************************************** memberTenure
CREATE TABLE member_tenure
(
 member_tenure_id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
 member_id        integer NOT NULL,
 start_date       date NOT NULL,
 end_date         date,
 created_by       integer NOT NULL,
 last_update_by   integer NOT NULL,
 created_date     timestamp with time zone default current_timestamp,
 last_update_date timestamp with time zone default current_timestamp,
 CONSTRAINT PK_member_tenure PRIMARY KEY ( member_tenure_id ),
 CONSTRAINT FK_member_tenure_member_1 FOREIGN KEY ( member_id ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_tenure_member_2 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_tenure_member_3 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON member_tenure
(
 member_id
);

CREATE INDEX ON member_tenure
(
 created_by
);

CREATE INDEX ON member_tenure
(
 last_update_by
);

-- ************************************** member_address
CREATE TABLE member_address
(
 member_address_id integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1000
 ),
 member_id        integer NOT NULL,
 street1          varchar(50) NOT NULL,
 street2          varchar(50) NULL,
 street3          varchar(50) NULL,
 city             varchar(50) NOT NULL,
 state            varchar(50) NOT NULL,
 zip              varchar(10) NOT NULL,
 created_by       integer NOT NULL,
 last_update_by   integer NOT NULL,
 created_date     timestamp with time zone default current_timestamp,
 last_update_date timestamp with time zone default current_timestamp,
 CONSTRAINT PK_member_address PRIMARY KEY ( member_address_id ),
 CONSTRAINT FK_member_address_member_1 FOREIGN KEY ( member_id ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_address_member_2 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_address_member_3 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON member_address
(
 member_id
);

CREATE INDEX ON member_address
(
 created_by
);

CREATE INDEX ON member_address
(
 last_update_by
);

-- ************************************** member_emergency_contact
CREATE TABLE member_emergency_contact
(
 member_emergency_contact_id integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1000
 ),
 member_id          integer NOT NULL,
 full_name          varchar(100) NOT NULL,
 cell_phone         varchar(50) NOT NULL,
 home_phone         varchar(50) NOT NULL,
 created_by         integer NOT NULL,
 last_update_by     integer NOT NULL,
 created_date       timestamp with time zone default current_timestamp,
 last_update_date   timestamp with time zone default current_timestamp,
 CONSTRAINT PK_member_emergency_contact PRIMARY KEY ( member_emergency_contact_id ),
 CONSTRAINT FK_member_emergency_contact_member_1 FOREIGN KEY ( member_id ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_emergency_contact_member_2 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_emergency_contact_member_3 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON member_emergency_contact
(
 member_id
);

CREATE INDEX ON member_emergency_contact
(
 created_by
);

CREATE INDEX ON member_emergency_contact
(
 last_update_by
);

-- ************************************** member_phone
CREATE TABLE member_phone
(
 member_phone_id integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1000
 ),
 member_id      integer NOT NULL,
 phone_type_id   integer NOT NULL,
 phone_number   varchar(50) NOT NULL,
 is_primary     boolean NOT NULL,
 created_by     integer NOT NULL,
 last_update_by  integer NOT NULL,
 created_date   timestamp with time zone default current_timestamp,
 last_update_date    timestamp with time zone default current_timestamp,
 CONSTRAINT PK_member_phone PRIMARY KEY ( member_phone_id ),
 CONSTRAINT FK_member_phone_member_1 FOREIGN KEY ( member_id ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_phone_member_2 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_member_phone_member_3 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_phone_type_id FOREIGN KEY ( phone_type_id ) REFERENCES Phone_type ( phone_type_id )
);

CREATE INDEX  ON member_phone
(
 member_id
);

CREATE INDEX  ON member_phone
(
 created_by
);

CREATE INDEX  ON member_phone
(
 last_update_by
);
--this ensures that a member can only have 1 primary phone
CREATE UNIQUE INDEX ON member_phone (member_id) WHERE is_primary = true;


-- ************************************** event_type

CREATE TABLE event_type
(
 event_type_id  integer NOT NULL GENERATED ALWAYS AS IDENTITY,
 event_type_name varchar(50) NOT NULL,
 CONSTRAINT PK_event_type PRIMARY KEY ( event_type_id )
);

-- ************************************** event
CREATE TABLE event
(
 event_id           integer NOT NULL GENERATED ALWAYS AS IDENTITY (start 1000),
 event_type_id      integer NOT NULL,
 event_num          varchar(10),
 event_description     varchar(255) NOT NULL,
 created_by     integer NOT NULL,
 last_update_by  integer NOT NULL,
 created_date   timestamp with time zone default current_timestamp,
 last_update_date    timestamp with time zone default current_timestamp,
 CONSTRAINT PK_event PRIMARY KEY ( event_id ),
 CONSTRAINT FK_event_event_type FOREIGN KEY ( event_type_id ) REFERENCES event_type (event_type_id),
 CONSTRAINT FK_event_member_1 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_event_member_2 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);
CREATE INDEX ON event
(
 event_id
);
CREATE INDEX  ON event
(
 created_by
);

CREATE INDEX  ON event
(
 last_update_by
);

-- ************************************** operational_period
CREATE TABLE operational_period
(
 op_id                 integer NOT NULL GENERATED ALWAYS AS IDENTITY (start 1000),
 event_id              integer NOT NULL,
 op_start_time         timestamp with time zone default current_timestamp,
 op_end_time           timestamp with time zone default current_timestamp,
 op_incident_command   integer,
 created_by            integer NOT NULL,
 last_update_by        integer NOT NULL,
 created_date          timestamp with time zone default current_timestamp,
 last_update_date      timestamp with time zone default current_timestamp,
 CONSTRAINT PK_operational_period PRIMARY KEY ( op_id ),
 CONSTRAINT FK_operational_period_event FOREIGN KEY ( event_id ) REFERENCES event ( event_id ),
 CONSTRAINT FK_operational_period_member_1 FOREIGN KEY ( op_incident_command ) REFERENCES member ( member_id ),
 CONSTRAINT FK_operational_period_member_2 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_operational_period_member_3 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON operational_period
(
    op_id
);

CREATE INDEX ON operational_period
(
    event_id
);

CREATE INDEX  ON operational_period
(
 created_by
);

CREATE INDEX  ON operational_period
(
 last_update_by
);

-- ************************************** volunteer

CREATE TABLE volunteer
(
 volunteer_id     integer NOT NULL GENERATED ALWAYS AS IDENTITY (start 1000),
 last_name        varchar(50) NOT NULL,
 first_name       varchar(50) NOT NULL,
 middle_name      varchar(50) NULL,
 preferred_name   varchar(25) NOT NULL,
 dob              date NOT NULL,
 personal_email   varchar(50) NOT NULL,
 created_by            integer NOT NULL,
 last_update_by        integer NOT NULL,
 created_date     timestamp with time zone default current_timestamp,
 last_update_date timestamp with time zone default current_timestamp,
 CONSTRAINT PK_volunteer PRIMARY KEY ( volunteer_id ),
 CONSTRAINT FK_volunteer_member_1 FOREIGN KEY ( created_by ) REFERENCES member ( member_id ),
 CONSTRAINT FK_volunteer_member_2 FOREIGN KEY ( last_update_by ) REFERENCES member ( member_id )
);

CREATE INDEX ON volunteer
(
    volunteer_id
);

CREATE INDEX  ON volunteer
(
 created_by
);

CREATE INDEX  ON volunteer
(
 last_update_by
);

-- ************************************** participant
CREATE TABLE participant
(
 partcipant_id             integer NOT NULL GENERATED ALWAYS AS IDENTITY (start 1000),
 op_id                     integer NOT NULL,
 member_id                 integer,
 volunteer_id              integer,
 participant_start_time    timestamp with time zone default current_timestamp,
 participant_end_time      timestamp with time zone default current_timestamp,
 created_by                integer NOT NULL,
 last_update_by            integer NOT NULL,
 created_date              timestamp with time zone default current_timestamp,
 last_update_date          timestamp with time zone default current_timestamp,
 CONSTRAINT PK_participant PRIMARY KEY ( partcipant_id ),
 CONSTRAINT FK_participant_operational_period FOREIGN KEY ( op_id ) REFERENCES operational_period ( op_id ),
 CONSTRAINT FK_participant_member FOREIGN KEY ( member_id ) REFERENCES member ( member_id ),
 CONSTRAINT FK_participant_volunteer FOREIGN KEY ( volunteer_id ) REFERENCES volunteer ( volunteer_id )
);

CREATE INDEX ON participant
(
    participant_id
);

CREATE INDEX  ON participant
(
    op_id
);

CREATE INDEX  ON participant
(
    member_id
);

CREATE INDEX  ON participant
(
    volunteer_id
);

CREATE INDEX  ON participant
(
    created_by
);

CREATE INDEX  ON participant
(
    last_update_by
);