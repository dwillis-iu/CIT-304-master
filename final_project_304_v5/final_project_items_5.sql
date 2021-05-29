--Item 5, Have at least two functions. Explain what they do and when they are used
--1st Function

--Create function named "total_anime"
--This function will return a number to the end user
CREATE OR REPLACE FUNCTION total_anime 
RETURN number IS 
   --initialize the total number variable to be returned at the end of calling function
   total number(3) := 0; 
BEGIN 
   --select a count of all rows from the ANIME_PROJECT table into the total variable
   SELECT count(*) into total 
   FROM ANIME_PROJECT;
    
   RETURN total; 
END; 
 --returns the total number of anime listed in the database

set serveroutput on

--Call the function using a code block, which is part of item 2 in rubric
DECLARE 
   --declare total_anime variable which will hold the returned number from the 1st function
   totals number; 
BEGIN 
   --set total_anime variable equal to the returned number from the 1st function
   totals := total_anime(); 
   --output the total number of anime in database to console log
   dbms_output.put_line('Total no. of anime in database: ' || totals); 
END; 





--2nd function
--Compare two manga series together and find which one has the most chapters of the two 
--Plus the winner's total chapters and how many more chapters it has over the other

--Declare and initialize the variables we will use for the function
DECLARE 
   --holds randomly selected manga with its total chapters thus far
   manga_a number; 
   --holds randomly selected manga with its total chapters thus far
   manga_b number; 
   --will hold the number result from the findMax function (comparing total manga chapters between the two selected manga series
   manga_max number; 
   --the manga that has the most chapters will be stored into this variable
   manga_1 varchar2(80);
   --chapter_diff variable holds the chapter difference between the winner and loser manga (in terms of more chapters)
   chapter_diff number;
   
--Create findMax function that will return a variable with the manga chapter total that is greater than the other manga chapter total
--When calling this function, there will be two parameters, being x and y
FUNCTION findMax(x IN number, y IN number)  
RETURN number 
IS 
    --will return z variable which will be initialized with whichever variable is the winner (greatest total number of chapters)
    z number; 
BEGIN 
   IF x > y THEN 
      z := x; 
   ELSE 
      z := y; 
   END IF;  
   RETURN z; 
END; 

BEGIN 
   --initialize variable / placeholder
   manga_a:= 0;
   --Select the total chapter numbers thus far from the chapters column in the manga_project table
   --with the specific manga id (as to begin the comparison between this and another manga)
   --into the manga_a variable
   select chapters into manga_a from manga_project
   where manga_id = 'ATO';
   
   --initialize variable / placeholder
   manga_b:= 0;  
   --Select the total chapter numbers thus far from the chapters column in the manga_project table
   --with the specific manga id (as to begin the comparison between this and another manga)
   --into the manga_b variable
   select chapters into manga_b from manga_project
   where manga_id = 'BAM';
   
   --This is where we call the previously created findMax function
   manga_max := findMax(manga_a, manga_b); 
   
   --If the manga_max variable equals the manga_a variable then, place the row of information into the manga_1 variable
   --Then select the difference between the chapters into the chapter_diff variable
   --The same goes for the else statement
   --The results will be outputted to the console at the end
   IF manga_max = manga_a then
        select manga_id into manga_1 from manga_project
        where manga_id = 'ATO';
        select (manga_a - manga_b) into chapter_diff from dual;
    ELSE
        select manga_id into manga_1 from manga_project
        where manga_id = 'BAM';
        select (manga_b - manga_a) into chapter_diff from dual;

    END IF;
   
   --output the winner to the console log
   dbms_output.put_line(manga_1 || ' has the most chapters of the two. It has ' || manga_max || ' total chapters and ' || chapter_diff || ' more chapters than the other.'); 
END; 


