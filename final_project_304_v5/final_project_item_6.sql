--Item 6, Have at least two stored procedures.
--Explain what they do and when they are used.

--1st procedure
--Create procedure named "SHONEN_JUMP", which will loop through SERIALIZATION_PROJECT
--table and find all rows of data in which the manga serialization company is 
--named "Weekly Shonen Jump" and insert it into a cursor then output all of the found data
--to the console

--this command enables text to be outputted to the console
set serveroutput on;

--create procedure SHONEN_JUMP
CREATE OR REPLACE PROCEDURE SHONEN_JUMP
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
/

--2nd procedure
--Create procedure named "FAV_GENRES", which will loop through ANIME_PROJECT
--table and find all rows of data in which the main genre of that particular row is
--either 'Slice of Life' or 'Comedy' or 'Adventure' 
--and insert it into a cursor then output all of the found data to the console

CREATE OR REPLACE PROCEDURE FAV_GENRES
AS
    --references data types and data values from the ANIME_PROJECT table
    fav_anime_id ANIME_PROJECT.anime_id%TYPE;
    fav_title ANIME_PROJECT.title%TYPE;
    fav_anime_status ANIME_PROJECT.anime_status%TYPE;
    fav_main_genre ANIME_PROJECT.main_genre%TYPE;
    fav_rating ANIME_PROJECT.rating%TYPE;
    fav_manga_id ANIME_PROJECT.manga_id%TYPE;

--create cursor which will contain all rows in which the main genre of anime
--is classified as 'slice of life', 'comedy', or 'adventure'
CURSOR cur1 IS
SELECT anime_id, title, anime_status, main_genre, rating, manga_id
FROM ANIME_PROJECT
WHERE main_genre = 'Slice of Life' OR main_genre = 'Comedy' OR main_genre = 'Adventure';

--begin code block
BEGIN
    --begin cursor
    open cur1;
        --begin looping through the ANIME_PROJECT table
        LOOP
            --Fetch command will retrieve all of the columns of data from the rows
            --with main genre as 'slice of life', 'comedy', or 'adventure' and put it into the
            --newly created variables for the cur1 cursor
            --will exit out of fetch statement if one of the three specified values are not found
            FETCH cur1 INTO fav_anime_id, fav_title, fav_anime_status, fav_main_genre, fav_rating, fav_manga_id;
            EXIT WHEN cur1%NOTFOUND;
            
            --Output each data variable for each fetched row unto the console
            DBMS_OUTPUT.PUT_LINE('Anime Id: ' || fav_anime_id);
            DBMS_OUTPUT.PUT_LINE('Title: ' || fav_title);
            DBMS_OUTPUT.PUT_LINE('Anime Status: ' || fav_anime_status);
            DBMS_OUTPUT.PUT_LINE('Main Genre: ' || fav_main_genre);
            DBMS_OUTPUT.PUT_LINE('Rating: ' || fav_rating);
            DBMS_OUTPUT.PUT_LINE('Manga ID: ' || fav_manga_id);
            DBMS_OUTPUT.PUT_LINE(' ');

        --end loop statement
        END LOOP;
    --end cursor statement
    close cur1;
--end code block
END;
/
            