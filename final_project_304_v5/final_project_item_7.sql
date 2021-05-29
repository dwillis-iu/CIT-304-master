--Item 7, Have at least one package
--Explain what it does and when it is used

--this command enables text to be outputted to the console
SET SERVEROUTPUT ON;

--create package named "OVER_TWENTY_EPS", which will include the procedure "SHONEN_JUMP",
--which was used in item 6 to retrieve and output to the console all rows of data
--from the SERIALIZATION_PROJECT table in which the particular manga series was published
--by the 'Weekly Shonen Jump' publication
CREATE OR REPLACE PACKAGE OVER_TWENTY_EPS AS
    PROCEDURE SHONEN_JUMP;
END OVER_TWENTY_EPS;
/

--this is the body of the previously created package containing the code to implement
CREATE OR REPLACE PACKAGE BODY OVER_TWENTY_EPS AS
    PROCEDURE SHONEN_JUMP
    AS
        --references data types and data values from the SERIALIZATION_PROJECT table
        shon_manga_id SERIALIZATION_PROJECT.manga_id%TYPE;
        shon_serialized_by SERIALIZATION_PROJECT.serialized_by%TYPE;
        shon_first_published SERIALIZATION_PROJECT.first_published%TYPE;
        shon_last_published SERIALIZATION_PROJECT.last_published%TYPE;
    
    --create cursor which will contain all rows in which the manga serialization company
    --is named "Weekly Shonen Jump"
    CURSOR c1 IS
    SELECT manga_id, serialized_by, first_published, last_published
    FROM SERIALIZATION_PROJECT
    WHERE serialized_by = 'Weekly Shonen Jump';
    
    --begin code block
    BEGIN
        --begin cursor
        open c1;
            --begin looping through the SERIALIZATION_PROJECT table
            LOOP
                --Fetch command will retrieve all of the columns of data from the rows
                --with "Weekly Shonen Jump" as the serialized_by value and put it into the
                --newly created variables for the c1 cursor
                --will exit out of fetch statement if the "Weekly Shonen Jump" value is not found
                FETCH c1 INTO shon_manga_id, shon_serialized_by, shon_first_published, shon_last_published;
                EXIT WHEN c1%NOTFOUND;
                
                --Output each data variable for each fetched row unto the console
                DBMS_OUTPUT.PUT_LINE('Manga Id: ' || shon_manga_id);
                DBMS_OUTPUT.PUT_LINE('Serialized By: ' || shon_serialized_by);
                DBMS_OUTPUT.PUT_LINE('First Published: ' || shon_first_published);
                DBMS_OUTPUT.PUT_LINE('Last Published: ' || shon_last_published);
                DBMS_OUTPUT.PUT_LINE(' ');
    
            --end loop statement
            END LOOP;
        --end cursor
        close c1;
    --end code block
    END;
    
--end package body
END OVER_TWENTY_EPS;