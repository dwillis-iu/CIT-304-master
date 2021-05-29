--Item 3, Have at least five tables

--Table 1; Central Table

CREATE TABLE ANIME_PROJECT (
    anime_id varchar2(10) not null,
    title varchar2(300),
    anime_status varchar2(40),
    main_genre varchar2(40),
    rating varchar2(10),
    manga_id varchar2(10) UNIQUE,
    
    PRIMARY KEY (anime_id)
    );
    
INSERT INTO ANIME_PROJECT (anime_id, title, anime_status, main_genre, rating, manga_id)
SELECT ANIMEID, TITLE, ANIMESTATUS, MAINGENRE, RATING, MANGAID FROM ANIME;

-- Table 2, Licensing

CREATE TABLE LICENSING_PROJECT (
    anime_id varchar2(10) not null,
    licensed_by varchar2(80) not null,
    episodes number,
    first_aired date,
    last_aired date,
    
    PRIMARY KEY (anime_id, licensed_by),
    
    CONSTRAINT FK_anime_id_licensing_table FOREIGN KEY (anime_id)
    REFERENCES ANIME_PROJECT (anime_id)
    );
    
INSERT INTO LICENSING_PROJECT (anime_id, licensed_by, episodes, first_aired, last_aired)
SELECT ANIMEID, LICENSEDBY, EPISODES, FIRSTAIRED, LASTAIRED FROM LICENSING;

--Table 3, Manga

CREATE TABLE MANGA_PROJECT (
    manga_id varchar2(10) not null,
    volumes number,
    chapters number,
    manga_status varchar2(40),
    
    PRIMARY KEY (manga_id),
    
    CONSTRAINT FK_manga_id_manga_table FOREIGN KEY (manga_id)
    REFERENCES ANIME_PROJECT (manga_id)
    );
    
INSERT INTO MANGA_PROJECT (manga_id, volumes, chapters, manga_status)
SELECT MANGAID, VOLUMES, CHAPTERS, MANGASTATUS FROM MANGA;

--Table 4, Production

CREATE TABLE PRODUCTION_PROJECT (
    anime_id varchar2(10) not null,
    production_studio varchar2(80) not null,
    anime_director_first_name varchar2(80),
    anime_director_last_name varchar2(80),
    music_composer_first_name varchar2(80),
    music_composer_last_name varchar2(80),
    
    PRIMARY KEY (anime_id, production_studio),
    
    CONSTRAINT FK_anime_id_production_table FOREIGN KEY (anime_id)
    REFERENCES ANIME_PROJECT (anime_id)
    );
    
INSERT INTO PRODUCTION_PROJECT (anime_id, production_studio, anime_director_first_name,
                                anime_director_last_name, music_composer_first_name,
                                music_composer_last_name)
SELECT ANIMEID, PRODUCTIONSTUDIO, ANIMEDIRECTORFIRSTNAME, ANIMEDIRECTORLASTNAME,
       MUSICCOMPOSERFIRSTNAME, MUSICCOMPOSERLASTNAME FROM PRODUCTION;
      
--Table 5, Rank
       
CREATE TABLE RANK_PROJECT (
    anime_id varchar2(10) not null,
    members_voted number not null,
    ranked number,
    score number,
    
    PRIMARY KEY (anime_id, members_voted),
    
    CONSTRAINT FK_anime_id_rank_table FOREIGN KEY (anime_id)
    REFERENCES ANIME_PROJECT (anime_id)
    );

INSERT INTO RANK_PROJECT (anime_id, members_voted, ranked, score)
SELECT ANIMEID, MEMBERSVOTED, RANKED, SCORE FROM RANK;

--Table 6, Serialization

CREATE TABLE SERIALIZATION_PROJECT (
    manga_id varchar2(10) not null,
    serialized_by varchar2(80) not null,
    first_published date,
    last_published date,
    
    PRIMARY KEY (manga_id, serialized_by),
    
    CONSTRAINT FK_manga_id_serialization FOREIGN KEY (manga_id)
    REFERENCES ANIME_PROJECT (manga_id)
    );
    
INSERT INTO SERIALIZATION_PROJECT (manga_id, serialized_by, first_published, last_published)
SELECT MANGAID, SERIALIZEDBY, FIRSTPUBLISHED, LASTPUBLISHED FROM SERIALIZATION;
    
    
    
--Item 15, Demonstrate Save Points
savepoint anime_project_table_creation;
    
    
--Item 5, Have at least one index 

CREATE INDEX anime_table_index 
ON ANIME_PROJECT(anime_id, title, anime_status, main_genre, rating, manga_id);

--Item 8, Use at least two of these functions (substr, lpad)
--Item 10, Use at least two of the date functions (to_date, months_between)

--Item 8, substr, remove year from end of date
SELECT manga_id, serialized_by, SUBSTR(first_published,1,6) "DATE_MOD", SUBSTR(last_published,1,6) "DATE_MOD_2"
FROM SERIALIZATION_PROJECT;

--Item 8, lpad, remove year from end of date
SELECT manga_id, serialized_by, RPAD(first_published, 6) "DATE_MODDED", RPAD(last_published, 6) "DATE_MODDED_2"
FROM SERIALIZATION_PROJECT;

--Item 10, to_char, changing format of date columns
SELECT manga_id, serialized_by, to_char(first_published, 'YYYY-MM-DD') "DATE_MOD", 
                                to_char(last_published, 'YYYY-MM-DD') "DATE_MOD_2"
FROM SERIALIZATION_PROJECT;

--Item 10, next_day, find the second official week of show airing
SELECT anime_id, licensed_by, episodes, next_day(first_aired, 'SUNDAY') "Nxt_Wk_Aired"
FROM LICENSING_PROJECT;

--Item 11, Use Decode Function, Change 'Completed' status to "Finishing Airing' and 'Ongoing' status to 'Still Airing'
SELECT anime_id, title, 
    DECODE (anime_status, 'Completed', 'Finished Airing',
                          'Ongoing', 'Still Airing')
                          "Air Status"
    FROM ANIME_PROJECT;
    
    
--Item 12, Use Group By and Having, show how many repeating manga publishing companies in the top anime database AND show top manga publishing companies 
SELECT serialized_by, COUNT(*) REPEATING_VALUES
FROM SERIALIZATION_PROJECT
GROUP BY serialized_by
HAVING COUNT(*) > 1
ORDER BY REPEATING_VALUES DESC;

--Item 14, Use Join and Outer Join, Join tables ANIME_PROJECT AND LICENSING_PROJECT together for output
SELECT LICENSING_PROJECT.anime_id, LICENSING_PROJECT.licensed_by, LICENSING_PROJECT.episodes, 
       LICENSING_PROJECT.first_aired, LICENSING_PROJECT.last_aired, 
       title, anime_status, main_genre, rating, manga_id
FROM ANIME_PROJECT
LEFT OUTER JOIN LICENSING_PROJECT
ON ANIME_PROJECT.anime_id = LICENSING_PROJECT.anime_id
WHERE ANIME_PROJECT.main_genre IN ('Adventure');

--Item 13, Use Sub Queries, only show anime with amount of episodes greater than the total amount of episodes in database
SELECT * FROM LICENSING_PROJECT
WHERE episodes > (select avg(episodes) from LICENSING_PROJECT);

SELECT ROUND(avg(episodes)) FROM LICENSING_PROJECT;

--Item 15, Demonstrate Save Points
savepoint items_5_8_10_11_12_13_14;


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


--Item 7, have at least five views

--Show masterpiece shows, meaning shows that achieve a score above 9.00
CREATE OR REPLACE VIEW MASTERPIECE_SHOWS AS
SELECT anime_id, members_voted, ranked, ROUND(SCORE) AS ROUNDED_SCORE, TRUNC(SCORE, 1) AS TRUNC_SCORE
FROM RANK_PROJECT
WHERE SCORE > 9;

--List ongoing shows within anime database
CREATE OR REPLACE VIEW ONGOING_SHOWS AS
SELECT anime_id, title, anime_status, main_genre, rating
FROM ANIME_PROJECT
WHERE anime_status = 'Ongoing';


--Manga Ascending Rank with a Score between 8 to 8.99
CREATE OR REPLACE VIEW MANGA_ASC_RANK_SCORE_OF_8 AS
SELECT anime_id, members_voted, ranked, score FROM RANK_PROJECT
WHERE score like '8.%'
ORDER BY score;


--Find out which anime ends between 24 and 26 episodes, a typical preference by anime fans
CREATE OR REPLACE VIEW TOTAL_EPISODES AS
SELECT * FROM LICENSING_PROJECT
WHERE episodes between 24 AND 26
ORDER BY episodes;

--Find out which manga is still ongoing but has more than 30 chapters
CREATE OR REPLACE VIEW ONGOING_MANGA_CHAPTERS AS
SELECT * FROM MANGA_PROJECT
WHERE chapters > 30 AND manga_status = 'Ongoing';

--Item 15, Demonstrate Save Points
savepoint view_save_point_example;


--Item 9, Two number functions

CREATE VIEW MASTERPIECE_SHOWS AS
SELECT anime_id, members_voted, ranked, ROUND(SCORE) AS ROUNDED_SCORE, TRUNC(SCORE, 1) AS TRUNC_SCORE
FROM RANK_PROJECT
WHERE SCORE > 9;

--Item 15, Demonstrate Save Points
savepoint num_func_save_point_example;


--Item 16, Use Insert All

CREATE TABLE INSERT_ALL_EX (
    anime_id VARCHAR2(10),
    members_voted NUMBER,
    ranked NUMBER,
    score NUMBER
    );
    
CREATE TABLE NINE_SCORE AS 
SELECT * FROM INSERT_ALL_EX;

CREATE TABLE EIGHT_SCORE AS
SELECT * FROM INSERT_ALL_EX;

CREATE TABLE SEVEN_SCORE AS
SELECT * FROM INSERT_ALL_EX;
    
INSERT ALL
    WHEN score > 8.99 THEN
        INTO NINE_SCORE
    WHEN score > 7.99 AND score < 9 THEN
        INTO EIGHT_SCORE
    WHEN score < 8 THEN
        INTO SEVEN_SCORE
SELECT anime_id, members_voted, ranked, score
    FROM RANK_PROJECT;
    
--Item 15, Demonstrate Save Points
savepoint insert_all_example;


--Item 17, Use Merge

CREATE TABLE MERGE_EXAMPLE (
    anime_id varchar2(10) not null,
    title varchar2(300),
    anime_status varchar2(40),
    anime_status_merged varchar2(40)
    );
    
INSERT INTO MERGE_EXAMPLE (anime_id, title, anime_status)
SELECT ANIMEID, TITLE, ANIMESTATUS FROM ANIME;
    
MERGE INTO MERGE_EXAMPLE
USING (SELECT 1 FROM DUAL)
ON (anime_status = 'Completed')
WHEN MATCHED THEN UPDATE SET anime_status_merged = 'Finished'
WHEN NOT MATCHED THEN INSERT (anime_status) VALUES ('Completed');

--Item 15, Demonstrate Save Points
savepoint merge_example_save_point;