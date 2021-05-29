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


