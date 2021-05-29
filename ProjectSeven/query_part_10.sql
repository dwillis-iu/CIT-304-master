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