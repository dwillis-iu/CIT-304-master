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