--Item 9, Two number functions

CREATE VIEW MASTERPIECE_SHOWS AS
SELECT anime_id, members_voted, ranked, ROUND(SCORE) AS ROUNDED_SCORE, TRUNC(SCORE, 1) AS TRUNC_SCORE
FROM RANK_PROJECT
WHERE SCORE > 9;

--Item 15, Demonstrate Save Points
savepoint num_func_save_point_example;