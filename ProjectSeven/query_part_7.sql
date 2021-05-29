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