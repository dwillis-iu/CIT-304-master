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