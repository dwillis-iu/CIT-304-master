CREATE OR REPLACE TRIGGER EMPLOYEE_TRIGGER_INSERT
AFTER INSERT ON EMPLOYEE
FOR EACH ROW

BEGIN  
    INSERT INTO EMPLOYEE_LOG VALUES (:new.employee_id, :new.last_name, :new.first_name,
    :new.middle_initial, :new.dept_id, :new.title, :new.supervisor_id, user, Sysdate);
END;