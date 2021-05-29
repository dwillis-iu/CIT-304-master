-- Query Parts 1 to 6
CREATE TABLE EMPLOYEE (
    employee_id varchar2(8) not null,
    last_name varchar2(40),
    first_name varchar2(40),
    middle_initial varchar2(1),
    dept_id varchar2(4),
    title varchar2(40),
    supervisor_id varchar2(8),
    
    PRIMARY KEY (employee_id),
    
    CONSTRAINT FK_emp_emp FOREIGN KEY (supervisor_id)
    REFERENCES EMPLOYEE (employee_id),
    
    CONSTRAINT FK_emp_dept FOREIGN KEY (dept_id)
    REFERENCES DEPARTMENT (dept_id)
    
    );
    
CREATE TABLE DEPARTMENT (
    dept_id varchar2(4) not null,
    division_name varchar2(20),
    department_name varchar2(20),
    PRIMARY KEY (dept_id)
    );
    
set define off
    
INSERT INTO DEPARTMENT VALUES('EBX', 'Pharma', 'R&D');
INSERT INTO DEPARTMENT VALUES('CP1', 'Corporate', 'Finance');
INSERT INTO DEPARTMENT VALUES('CP2', 'Corporate', 'Marketing');

set define on

INSERT INTO EMPLOYEE VALUES('EB001', 'Abbott', 'Richard', null, 'EBX', 'Director', null);
INSERT INTO EMPLOYEE VALUES('EB002', 'Johnson', 'Fred', null, 'EBX', 'Manager', 'EB001');
INSERT INTO EMPLOYEE VALUES('EB103', 'Searle', 'Jan', null, 'EBX', 'Technician', 'EB002');
INSERT INTO EMPLOYEE VALUES('EB104', 'Lambert', 'Fred', 'W', null, 'Technician', 'EB002');
INSERT INTO EMPLOYEE VALUES('CP001', 'Roche', 'Judith', 'H', 'CP1', 'Director', null);

INSERT INTO EMPLOYEE VALUES('CP002', 'Glaxo', 'Smithy', 'K', 'CP2', 'Director', null);
INSERT INTO EMPLOYEE VALUES('CP003', 'Product', 'Amerigus', 'H', 'CP1', 'Manager', 'CP001');
INSERT INTO EMPLOYEE VALUES('CP004', 'Bayer', 'Helmut', null, 'CP1', 'Dept. Head', 'CP003');

INSERT INTO EMPLOYEE VALUES('CP005', 'Merck', 'Trent', null, 'CP1', 'Team Leader', 'CP004');
INSERT INTO EMPLOYEE VALUES('CP006', 'Baxter', 'Ted', null, 'CP1', 'clerk', 'CP005');
INSERT INTO EMPLOYEE VALUES('CP007', 'Underling', 'John', null, 'CP1', 'clerk', 'CP005');
INSERT INTO EMPLOYEE VALUES('CP008', 'Helper', 'Susan', 'H', null, 'AA', 'CP003');
INSERT INTO EMPLOYEE VALUES('CP009', 'Dilbert', 'Joe', null, 'CP1', 'clerk', 'CP005');

-- Query Part 7
INSERT INTO EMPLOYEE (employee_id, last_name, first_name, middle_initial, dept_id, title, supervisor_id)

SELECT
    substr(NAME,1,3) || ltrim(to_char(nvl(age,1),'009')) as employee_id,
    initcap(substr(name,instr(name,' ',1)+1)) as last_name,
    initcap(substr(name,1,instr(name,' ',1)-1)) as first_name,
    null,
    'CP2',
    'Salesperson',
    'CP002'
    
FROM WORKER;

-- Query Part 8.a
SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*) FROM DEPARTMENT;

-- Query Part 8.b
DELETE FROM EMPLOYEE;
SELECT COUNT(*) FROM EMPLOYEE;

-- Query Part 8.c
ROLLBACK;
SELECT COUNT(*) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- Query Part 9
UPDATE EMPLOYEE
    SET last_name = 'Beecham'
    WHERE last_name = 'Glaxo';
    
-- Query Part 10
CREATE TABLE EMPLOYEE_LOG (
    employee_id varchar2(8) not null,
    prev_last_name varchar2(40),
    prev_first_name varchar2(40),
    prev_middle_initial varchar2(1),
    prev_dept_id varchar2(4),
    prev_title varchar2(40),
    prev_supervisor_id varchar2(8),
    mod_user varchar2(8),
    mod_timestamp date
    );
    
-- Query Part 11.a
CREATE OR REPLACE TRIGGER EMPLOYEE_TRIGGER_INSERT
AFTER INSERT ON EMPLOYEE
FOR EACH ROW

BEGIN  
    INSERT INTO EMPLOYEE_LOG VALUES (:new.employee_id, :new.last_name, :new.first_name,
    :new.middle_initial, :new.dept_id, :new.title, :new.supervisor_id, user, Sysdate);
END;

-- Query Part 11.b
CREATE OR REPLACE TRIGGER EMPLOYEE_TRIGGER_UPDATE
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW

BEGIN
    INSERT INTO EMPLOYEE_LOG VALUES (:new.employee_id, :old.last_name, :old.first_name,
    :old.middle_initial, :old.dept_id, :old.title, :old.supervisor_id, user, Sysdate);
END;