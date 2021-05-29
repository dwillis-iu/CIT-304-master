--Item 3

--Create a table to insert values into later on
--The function of this upcoming code block is to find find all anime
--from the RANK_PROJECT table and add a column that rates the anime as 'masterpiece anime' (if score > 9),
--'great anime' (if score > 8 and score < 9), 'good anime' (if score > 7 an d score < 8, or 'bad anime' ( if score < 7 )
--Although, there is only 250 rows of anime, so there will not be any anime with a score of less than 7
--This is a quick way for a person to skim through the list and generally find which anime would be worth watching or not (based on popularity of course)

CREATE TABLE COMPLETED_ANIME (
    comp_anime_id varchar2(10), --create variables and their data types 
    comp_title varchar2(80),
    comp_anime_status varchar2(40),
    comp_main_genre varchar2(40),
    comp_rating varchar2(10),
    comp_manga_id varchar2(10)
    );
    
--Item 4
--Create this table for the trigger to log new inserts into the MASTERPIECE_ANIME table
--by placing these log updates into the MASTERPIECE_ANIME_LOG table
--This would be useful for keeping a log of all the inserts into a particular table
--This could be used to delete information that ought not be in a certain table
--This could be used to track when the update happened and which user made the update happen
CREATE TABLE COMPLETED_ANIME_LOG  (
    log_anime_id varchar2(10), --create variables and their data types 
    log_title varchar2(80),
    log_anime_status varchar2(40),
    log_main_genre varchar2(40),
    log_rating varchar2(10),
    log_manga_id varchar2(10),
    log_user varchar2(40),
    log_sysdate varchar2(40)
    );

--Code block begins here
--Use Declare block to declare variables and their data types to insert values into during the loop later on

DECLARE
    v_anime_id ANIME_PROJECT.anime_id%TYPE; --create variable to insert values from loop into, but referencing RANK_PROJECT table because that is where the data will be pulled from
    v_title ANIME_PROJECT.title%TYPE;
    v_anime_status ANIME_PROJECT.anime_status%TYPE;
    v_main_genre ANIME_PROJECT.main_genre%TYPE;
    v_rating ANIME_PROJECT.rating%TYPE;
    v_manga_id ANIME_PROJECT.manga_id%TYPE;

    --Cursor begins here
    --Cursor allows user to assign a name to a SELECT statement and manipulate the information
    --Create c_anime cursor variable that holds the contents of the RANK_PROJECT table
    CURSOR c_anime_comp IS
    SELECT anime_id, title, anime_status, main_genre, rating, manga_id
    FROM ANIME_PROJECT;
    
    not_completed EXCEPTION;

--BEGIN statement will allow the use of opening cursors and using loops
--The statements that manipulate the variables created above can be done within the begin block
BEGIN
    --Open the c_anime cursor created earlier
    --Allows for the use of the previously created variable
    OPEN c_anime_comp;

    --Begin loop
    --By using the loop, able to fetch each row and put it into the new table
    --Loop goes row by row, traversing through each data variable
    LOOP
        --Fetch statement below grabs the variable created above that references the RANK_PROJECT TABLE and places these variables row by row (as loop occurs) into c_anime cursor
        --Exit statement stops the loop when there are no more rows of data to sift through
        FETCH c_anime_comp INTO v_anime_id, v_title, v_anime_status, v_main_genre, v_rating, v_manga_id;
        EXIT when c_anime_comp%NOTFOUND;
        
        --If the score is greater than 9, then update the word_rating variable to 'masterpiece_anime'
        --Then insert all of the values from the fetch statement and the newly updated word_rating value into the MASTERPIECE_ANIME TABLE
        IF v_anime_status = 'Ongoing' THEN
            RAISE not_completed;
        END IF;
              
    --Must end loop and close c_anime cursor as well 
    END LOOP;
    CLOSE c_anime_comp;
    
        EXCEPTION
            WHEN not_completed THEN
                INSERT INTO COMPLETED_ANIME VALUES(v_anime_id, v_title, 'not completed', v_main_genre, v_rating, v_manga_id);
                

              
    
--Designates the end of the code block
END;

