--1

set serveroutput on;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

CREATE TABLE TABLE_SUMMARY(
    TABLE_SUM NUMBER,
    VIEW_SUM NUMBER,
    INDEX_SUM NUMBER,
    USER_SUM NUMBER,
    DATE_ROW_CREATED DATE
    );
    
DECLARE
    TABLE_SUM NUMBER;
    NUM_TABLES NUMBER;
    
    VIEW_SUM NUMBER;
    NUM_VIEWS NUMBER;
    
    INDEX_SUM NUMBER;
    NUM_INDEXES NUMBER;
    
    USER_SUM NUMBER;
    NUM_USERS NUMBER;
    
BEGIN
    SELECT COUNT(*) INTO TABLE_SUM
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'TABLE';
    NUM_TABLES := TABLE_SUM;
    DBMS_Output.Put_Line('There are a total of ' || NUM_TABLES
    || ' tables in the database.');
    
    SELECT COUNT(*) INTO VIEW_SUM
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'VIEW';
    NUM_VIEWS := VIEW_SUM;
    DBMS_Output.Put_Line('There are a total of ' || NUM_VIEWS
    || ' views in the database.');
    
    SELECT COUNT(*) INTO INDEX_SUM
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'INDEX';
    NUM_INDEXES := INDEX_SUM;
    DBMS_Output.Put_Line('There are a total of ' || NUM_INDEXES
    || ' indexes in the database.');
    
    SELECT COUNT(*) INTO USER_SUM
    FROM ALL_USERS;
    NUM_USERS := USER_SUM;
    DBMS_Output.Put_Line('There are a total of ' || NUM_USERS
    || ' users in the database.');
    
    INSERT INTO TABLE_SUMMARY VALUES(NUM_TABLES, NUM_VIEWS, NUM_INDEXES, NUM_USERS, CURRENT_TIMESTAMP);

END;

--2

CREATE TABLE EMPLOYEE_INFO (
    employee_id int NOT NULL,
    employee_first_name VARCHAR(10) NOT NULL,
    employee_last_name VARCHAR(10) NOT NULL,
    employee_email VARCHAR(19),
    employee_password VARCHAR(255),
    employee_salary NUMBER,
    CHECK (REGEXP_LIKE (employee_email, '^(\S+)\@(\S+)\.(\S+)$')),
    CHECK (REGEXP_LIKE (employee_password, '[^0-9]+') AND
    LENGTH(employee_password) > 8),
    CHECK (employee_salary BETWEEN 0 AND 100000)
    );
    
CREATE SEQUENCE INCREMENT_BY_ONE
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;

DECLARE
    i int := 1;
    
    RAND_NAME VARCHAR(10);
    RAND_NAME_INSERT VARCHAR(10);
    
    RAND_EMAIL VARCHAR(19);
    RAND_EMAIL_INSERT VARCHAR(19);
    
    RAND_PASSWORD VARCHAR (255);
    RAND_PASSWORD_INSERT VARCHAR(255);
    
    RAND_NUM NUMBER;
    RAND_NUM_INSERT NUMBER;

BEGIN
    FOR i IN 1 .. 500 LOOP
        SELECT dbms_random.string('U', 10) INTO RAND_NAME from dual;
        RAND_NAME_INSERT := RAND_NAME;
        
        SELECT ROUND(dbms_random.value(1,100000)) INTO RAND_NUM from dual;
        RAND_NUM_INSERT := RAND_NUM;
        
        SELECT dbms_random.string('X', 10) INTO RAND_PASSWORD from dual;
        RAND_PASSWORD_INSERT := RAND_PASSWORD;
        
        SELECT dbms_random.string('l', 5) || '@' || dbms_random.string('l', 5) || '.com' INTO RAND_EMAIL from dual;
        RAND_EMAIL_INSERT := RAND_EMAIL;

    
        INSERT INTO EMPLOYEE_INFO VALUES(INCREMENT_BY_ONE.nextval, RAND_NAME_INSERT, RAND_NAME_INSERT, RAND_EMAIL_INSERT, RAND_PASSWORD_INSERT, RAND_NUM_INSERT);
    END LOOP;
END;

