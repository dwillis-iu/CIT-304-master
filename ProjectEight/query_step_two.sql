CREATE TABLE PHONE_USERS(
    telephone_number varchar2(80) not null,
    first_name varchar2(80),
    last_name varchar2(80),
    keymap_lastname char(4),
    password varchar2(80),
    PRIMARY KEY (telephone_number),
    CONSTRAINT constraint_last_name UNIQUE(last_name)
    );