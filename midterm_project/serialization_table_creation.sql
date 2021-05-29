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