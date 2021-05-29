-- Query Part 1
CREATE TABLE BBT_USERS_TEMP
AS (SELECT * FROM EMPLOYEE_INFO
    WHERE employee_id >= 1 AND employee_id <= 10);
    
-- Query Part 2
CREATE TABLE PHONE_USERS(
    telephone_number varchar2(80) not null,
    first_name varchar2(80),
    last_name varchar2(80),
    keymap_lastname char(4),
    password varchar2(80),
    PRIMARY KEY (telephone_number),
    CONSTRAINT constraint_last_name UNIQUE(last_name)
    );
    
-- Query Part 3
create or replace FUNCTION KEYMAP(A_LAST_NAME VARCHAR2)
RETURN VARCHAR2 AS
PHONE_EXT VARCHAR2(40);
BEGIN

    SELECT TRANSLATE(EMPLOYEE_LAST_NAME, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 
    '2223334445556667777888999922233344455566677778889999')
    INTO PHONE_EXT
    FROM BBT_USERS_TEMP
    WHERE EMPLOYEE_LAST_NAME = A_LAST_NAME;
    RETURN (PHONE_EXT);
END;

-- Query Part 4
create or replace PROCEDURE n_iterations (n in number)
AS
    emp_id BBT_USERS_TEMP.EMPLOYEE_ID%TYPE;
    emp_first_name BBT_USERS_TEMP.EMPLOYEE_FIRST_NAME%TYPE;
    emp_last_name BBT_USERS_TEMP.EMPLOYEE_LAST_NAME%TYPE;
    emp_password BBT_USERS_TEMP.EMPLOYEE_PASSWORD%TYPE;
    emp_keymap VARCHAR2(40);
    emp_phone VARCHAR2(40);
    emp_last_name_digits VARCHAR2(40);
    rand_num NUMBER;
    rand_num_insert NUMBER;
    x NUMBER;
    CURSOR c1 IS
    SELECT EMPLOYEE_ID, EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME, EMPLOYEE_PASSWORD
    FROM BBT_USERS_TEMP
    WHERE rownum < n;
BEGIN
  x := 1;
  open c1;    
    LOOP
        FETCH c1 INTO emp_id, emp_first_name, emp_last_name, emp_password;
        EXIT WHEN c1%NOTFOUND;

        emp_keymap := KEYMAP(emp_last_name);
        
        SELECT ROUND(dbms_random.value(0000000000,9999999999)) INTO rand_num from dual;
        rand_num_insert := rand_num;
        emp_phone := '(' || substr(rand_num_insert, 0, 3) || ') ' ||
        substr(rand_num_insert, 4, 3) || '-' || substr(rand_num_insert, 7, 4);
        
        emp_last_name_digits := emp_last_name || '000' || x;
        x := x + 1;

        INSERT INTO PHONE_USERS VALUES
        (emp_phone, emp_first_name, emp_last_name_digits, emp_keymap, emp_password);
    end loop;
  close c1;
end;

-- Query Part 5
CREATE OR REPLACE PACKAGE RUN_FUNCTIONS
AS
    FUNCTION KEYMAP(A_LAST_NAME VARCHAR2) RETURN VARCHAR2;
    PROCEDURE n_iterations (n in number);
END RUN_FUNCTIONS;
/

CREATE OR REPLACE PACKAGE BODY RUN_FUNCTIONS
AS
FUNCTION KEYMAP(A_LAST_NAME VARCHAR2)
RETURN VARCHAR2 AS
PHONE_EXT VARCHAR2(40);
BEGIN

    SELECT SUBSTR(TRANSLATE(EMPLOYEE_LAST_NAME, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 
    '2223334445556667777888999922233344455566677778889999'), 1, 4)
    INTO PHONE_EXT
    FROM BBT_USERS_TEMP
    WHERE EMPLOYEE_LAST_NAME = A_LAST_NAME;
    RETURN (PHONE_EXT);
END keymap;

PROCEDURE n_iterations (n in number)
AS
    emp_id BBT_USERS_TEMP.EMPLOYEE_ID%TYPE;
    emp_first_name BBT_USERS_TEMP.EMPLOYEE_FIRST_NAME%TYPE;
    emp_last_name BBT_USERS_TEMP.EMPLOYEE_LAST_NAME%TYPE;
    emp_password BBT_USERS_TEMP.EMPLOYEE_PASSWORD%TYPE;
    emp_keymap VARCHAR2(40);
    emp_phone VARCHAR2(40);
    emp_last_name_digits VARCHAR2(40);
    rand_num NUMBER;
    rand_num_insert NUMBER;
    x NUMBER;
    CURSOR c1 IS
    SELECT EMPLOYEE_ID, EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME, EMPLOYEE_PASSWORD
    FROM BBT_USERS_TEMP
    WHERE rownum < n;
BEGIN
  x := 1;
  open c1;    
    LOOP
        FETCH c1 INTO emp_id, emp_first_name, emp_last_name, emp_password;
        EXIT WHEN c1%NOTFOUND;

        emp_keymap := KEYMAP(emp_last_name);
        
        SELECT ROUND(dbms_random.value(0000000000,9999999999)) INTO rand_num from dual;
        rand_num_insert := rand_num;
        emp_phone := '(' || substr(rand_num_insert, 0, 3) || ') ' ||
        substr(rand_num_insert, 4, 3) || '-' || substr(rand_num_insert, 7, 4);
        
        emp_last_name_digits := emp_last_name || '000' || x;
        x := x + 1;

        INSERT INTO PHONE_USERS VALUES
        (emp_phone, emp_first_name, emp_last_name_digits, emp_keymap, emp_password);
    end loop;
  close c1;
end n_iterations;

END RUN_FUNCTIONS;
    
