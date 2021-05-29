--Item 4, Have at least two trigers in your database to keep track of different
--types of activities
--Trigger #1
--This trigger keeps track of new entries added to the MASTERPIECE_ANIME table
--The new entries will be placed into the MASTERPIECE_ANIME_LOG table

create or replace TRIGGER MASTERPIECE_ANIME_TRIGGER
AFTER INSERT ON MASTERPIECE_ANIME
FOR EACH ROW

BEGIN  
    INSERT INTO MASTERPIECE_ANIME_LOG VALUES (:new.mast_anime_id, :new.mast_members_voted, :new.mast_ranked,
    :new.mast_score, :new.mast_word_rating, user, Sysdate);
END;


--Item 4
--Trigger #2
--This trigger keeps track of the new entries added to the COMPLETED_ANIME table
--The new entries will be placed into the COMPLETED_ANIME_LOG table

create or replace TRIGGER COMPLETED_ANIME_TRIGGER
AFTER INSERT ON COMPLETED_ANIME
FOR EACH ROW

BEGIN  
    INSERT INTO COMPLETED_ANIME_LOG VALUES (:new.comp_anime_id, :new.comp_title, :new.comp_anime_status,
    :new.comp_main_genre, :new.comp_rating, :new.comp_manga_id, user, Sysdate);
END;