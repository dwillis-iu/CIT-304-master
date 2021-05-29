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