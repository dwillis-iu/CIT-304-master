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