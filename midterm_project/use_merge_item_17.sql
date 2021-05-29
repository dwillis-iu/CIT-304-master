--Item 17, Use Merge

CREATE TABLE MERGE_EXAMPLE (
    anime_id varchar2(10) not null,
    title varchar2(300),
    anime_status varchar2(40),
    anime_status_merged varchar2(40)
    );
    
INSERT INTO MERGE_EXAMPLE (anime_id, title, anime_status)
SELECT ANIMEID, TITLE, ANIMESTATUS FROM ANIME;
    
MERGE INTO MERGE_EXAMPLE
USING (SELECT 1 FROM DUAL)
ON (anime_status = 'Completed')
WHEN MATCHED THEN UPDATE SET anime_status_merged = 'Finished'
WHEN NOT MATCHED THEN INSERT (anime_status) VALUES ('Completed');

--Item 15, Demonstrate Save Points
savepoint merge_example_save_point;