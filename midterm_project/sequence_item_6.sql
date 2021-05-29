--Items 6, Have at least one sequence

CREATE TABLE SEQUENCE_EXAMPLE (
    id_number int not null,
    anime_id VARCHAR2(10),
    licensed_by VARCHAR2(80),
    episodes NUMBER,
    first_aired DATE,
    last_aired DATE
    );

CREATE SEQUENCE INCREMENT_SEQUENCE_EX
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 250
ORDER
NOCYCLE;

DECLARE

    i int := 1;

BEGIN
    FOR i IN 1 .. 250 LOOP
    
        INSERT INTO SEQUENCE_EXAMPLE(id_number, anime_id, licensed_by, episodes, first_aired, last_aired)
        SELECT INCREMENT_SEQUENCE_EX.nextval, anime_id, licensed_by, episodes, first_aired, last_aired
        FROM (SELECT anime_id, licensed_by, episodes, first_aired, last_aired FROM LICENSING_PROJECT);
        
    END LOOP;
END;

--Item 15, Demonstrate Save Points
savepoint sequence_save_point_example;