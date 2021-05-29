CREATE TABLE EMPLOYEE_REVIEW (
    employee_id int,
    employee_review_score NUMBER,
    CHECK (employee_review_score BETWEEN 1 AND 5)
    );

DECLARE
    v_emp_id EMPLOYEE_INFO.employee_id%TYPE;
    
    CURSOR c_emp IS
    SELECT employee_id
    FROM EMPLOYEE_INFO;
    
    RAND_NUM NUMBER;
    RAND_NUM_INSERT NUMBER;

BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_emp_id;
        EXIT when c_emp%NOTFOUND;
        
        SELECT ROUND(dbms_random.value(1,5)) INTO RAND_NUM from dual;
        RAND_NUM_INSERT := RAND_NUM;
        
        INSERT INTO EMPLOYEE_REVIEW VALUES(v_emp_id, RAND_NUM_INSERT);
    END LOOP;
    CLOSE c_emp;
END;