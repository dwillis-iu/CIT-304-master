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
    
    