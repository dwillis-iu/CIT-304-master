--Create a table to insert values into later on
--The function of this upcoming code block is to find find all anime
--from the RANK_PROJECT table and add a column that rates the anime as 'masterpiece anime' (if score > 9),
--'great anime' (if score > 8 and score < 9), 'good anime' (if score > 7 an d score < 8, or 'bad anime' ( if score < 7 )
--Although, there is only 250 rows of anime, so there will not be any anime with a score of less than 7
--This is a quick way for a person to skim through the list and generally find which anime would be worth watching or not (based on popularity of course)

CREATE TABLE MASTERPIECE_ANIME (
    mast_anime_id varchar2(10), --create variables and their data types 
    mast_members_voted number,
    mast_ranked number,
    mast_score number,
    mast_word_rating varchar2(40)
    );
    
--Item 4
--Create this table for the trigger to log new inserts into the MASTERPIECE_ANIME table
--by placing these log updates into the MASTERPIECE_ANIME_LOG table
--This would be useful for keeping a log of all the inserts into a particular table
--This could be used to delete information that ought not be in a certain table
--This could be used to track when the update happened and which user made the update happen
CREATE TABLE MASTERPIECE_ANIME_LOG  (
    log_anime_id varchar2(10), --create variables and their data types 
    log_members_voted number,
    log_ranked number,
    log_score number,
    log_word_rating varchar2(40),
    log_user varchar2(40),
    log_sysdate date
    );

--Code block begins here
--Use Declare block to declare variables and their data types to insert values into during the loop later on

DECLARE
    v_anime_id RANK_PROJECT.anime_id%TYPE; --create variable to insert values from loop into, but referencing RANK_PROJECT table because that is where the data will be pulled from
    v_members_voted RANK_PROJECT.members_voted%TYPE;
    v_ranked RANK_PROJECT.ranked%TYPE;
    v_score RANK_PROJECT.score%TYPE;
    
    --Cursor begins here
    --Cursor allows user to assign a name to a SELECT statement and manipulate the information
    --Create c_anime cursor variable that holds the contents of the RANK_PROJECT table
    CURSOR c_anime IS
    SELECT anime_id, members_voted, ranked, score
    FROM RANK_PROJECT;
    
    --create word_rating variable to store strings 'masterpiece anime' and so on
    word_rating varchar2(40);

--BEGIN statement will allow the use of opening cursors and using loops
--The statements that manipulate the variables created above can be done within the begin block
BEGIN
    --Open the c_anime cursor created earlier
    --Allows for the use of the previously created variable
    OPEN c_anime;

    --Begin loop
    --By using the loop, able to fetch each row and put it into the new table
    --Loop goes row by row, traversing through each data variable
    LOOP
        --Fetch statement below grabs the variable created above that references the RANK_PROJECT TABLE and places these variables row by row (as loop occurs) into c_anime cursor
        --Exit statement stops the loop when there are no more rows of data to sift through
        FETCH c_anime INTO v_anime_id, v_members_voted, v_ranked, v_score;
        EXIT when c_anime%NOTFOUND;
        
        --If the score is greater than 9, then update the word_rating variable to 'masterpiece_anime'
        --Then insert all of the values from the fetch statement and the newly updated word_rating value into the MASTERPIECE_ANIME TABLE
        IF v_score > 9 THEN
            word_rating := 'MASTERPIECE ANIME';
            INSERT INTO MASTERPIECE_ANIME VALUES(v_anime_id, v_members_voted, v_ranked, v_score, word_rating);
        --Else if score is greater than 8 and less than 9, then update the word_rating variable to 'masterpiece_anime'
        ELSIF v_score > 8 AND v_score < 9 THEN
            word_rating := 'GREAT ANIME';
            INSERT INTO MASTERPIECE_ANIME VALUES(v_anime_id, v_members_voted, v_ranked, v_score, word_rating);
        --Else if score is greater than 7 and less than 8, then update the word_rating variable to 'great anime'
        ELSIF v_score > 7 AND v_score < 8 THEN
            word_rating := 'GOOD ANIME';
            INSERT INTO MASTERPIECE_ANIME VALUES(v_anime_id, v_members_voted, v_ranked, v_score, word_rating);
        --Else if score is less than 7, then it is just a bad anime and the column will say 'bad anime'
        ELSE
            INSERT INTO MASTERPIECE_ANIME VALUES(v_anime_id, v_members_voted, v_ranked, v_score, 'BAD ANIME');
        --Must end if statements to avoid errors
        END IF;
    --Must end loop and close c_anime cursor as well 
    END LOOP;
    CLOSE c_anime;
--Designates the end of the code block
END;

