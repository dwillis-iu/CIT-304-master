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