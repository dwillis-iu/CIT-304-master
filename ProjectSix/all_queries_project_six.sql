--Part 1

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

--Part 2
CREATE TABLE EMPLOYEE_BONUS (
    employee_id int,
    employee_first_name VARCHAR(10),
    employee_last_name VARCHAR(10),
    employee_salary NUMBER,
    employee_bonus NUMBER
    );

DECLARE
    v_emp_id EMPLOYEE_INFO.employee_id%TYPE;
    v_emp_first_name EMPLOYEE_INFO.employee_first_name%TYPE;
    v_emp_last_name EMPLOYEE_INFO.employee_last_name%TYPE;
    v_emp_salary EMPLOYEE_INFO.employee_salary%TYPE;
    v_emp_review EMPLOYEE_REVIEW.employee_review_score%TYPE;
    
    CURSOR c_emp IS
    SELECT employee_id, employee_first_name, employee_last_name, employee_salary
    FROM EMPLOYEE_INFO;
    
    CURSOR c_emp_review IS
    SELECT employee_review_score
    FROM EMPLOYEE_REVIEW;
    
    bonus_tot NUMBER;

BEGIN
    OPEN c_emp;
    OPEN c_emp_review;
    LOOP
        FETCH c_emp INTO v_emp_id, v_emp_first_name, v_emp_last_name, v_emp_salary;
        EXIT when c_emp%NOTFOUND;
        
        FETCH c_emp_review INTO v_emp_review;
        EXIT WHEN c_emp_review%NOTFOUND;
        
        IF v_emp_review = 5 THEN
            bonus_tot := v_emp_salary * .10;
            INSERT INTO EMPLOYEE_BONUS VALUES(v_emp_id, v_emp_first_name, v_emp_last_name, v_emp_salary, bonus_tot);
        ELSIF v_emp_review = 4 THEN
            bonus_tot := v_emp_salary * .08;
            INSERT INTO EMPLOYEE_BONUS VALUES(v_emp_id, v_emp_first_name, v_emp_last_name, v_emp_salary, bonus_tot);
        ELSIF v_emp_review = 3 THEN
            bonus_tot := v_emp_salary * .05;
            INSERT INTO EMPLOYEE_BONUS VALUES(v_emp_id, v_emp_first_name, v_emp_last_name, v_emp_salary, bonus_tot);
        ELSE
            INSERT INTO EMPLOYEE_BONUS VALUES(v_emp_id, v_emp_first_name, v_emp_last_name, v_emp_salary, 0);
        END IF;
    END LOOP;
    CLOSE c_emp;
    CLOSE c_emp_review;
END;
