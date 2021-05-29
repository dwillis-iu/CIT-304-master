CREATE OR REPLACE TRIGGER EMPLOYEE_TRIGGER_UPDATE
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW

BEGIN
    INSERT INTO EMPLOYEE_LOG VALUES (:new.employee_id, :old.last_name, :old.first_name,
    :old.middle_initial, :old.dept_id, :old.title, :old.supervisor_id, user, Sysdate);
END;