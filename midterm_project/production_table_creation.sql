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