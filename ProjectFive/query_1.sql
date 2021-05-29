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