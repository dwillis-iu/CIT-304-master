--Item 16, Use Insert All

CREATE TABLE INSERT_ALL_EX (
    anime_id VARCHAR2(10),
    members_voted NUMBER,
    ranked NUMBER,
    score NUMBER
    );
    
CREATE TABLE NINE_SCORE AS 
SELECT * FROM INSERT_ALL_EX;

CREATE TABLE EIGHT_SCORE AS
SELECT * FROM INSERT_ALL_EX;

CREATE TABLE SEVEN_SCORE AS
SELECT * FROM INSERT_ALL_EX;
    
INSERT ALL
    WHEN score > 8.99 THEN
        INTO NINE_SCORE
    WHEN score > 7.99 AND score < 9 THEN
        INTO EIGHT_SCORE
    WHEN score < 8 THEN
        INTO SEVEN_SCORE
SELECT anime_id, members_voted, ranked, score
    FROM RANK_PROJECT;
    
--Item 15, Demonstrate Save Points
savepoint insert_all_example;