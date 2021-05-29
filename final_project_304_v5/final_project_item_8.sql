--Item 8, Create at least one type of objects
--Explain what it is and why it is needed

--Create object type named "new_anime_entry"
--The point of this object is to contain values for the anime_status, main_genre, rating, and manga_id
--variables which will be used to place new entries into the anime_entry table created below the object
--instead of listing 6 separate values to insert into a table, the object can be one data type to hold all
--of the data to be inputted
create or replace type new_anime_entry
as object
(
   anime_status varchar2(40),
   main_genre varchar2(40),
   rating varchar2(10),
   manga_id varchar2(10)
);
/

--Create table "anime_entry" to test the newly created object
--Initialize table with the anime_id, title, and the newly created object named "new_anime_entry"
--The variable name of the object will be called "new_entry"
create table anime_entry (
   anime_id varchar2(10),
   title varchar2(80),
   new_entry new_anime_entry
); 

desc anime_entry;

--For starters, we will insert the anime id and title of the anime along with the object that will 
--contain the rest of the values to complete the table without any null columns
--to use the newly created object, all that is necessary is to use its object name and fill in the parantheses
--with the four bits of information needed to complete the entry
insert into anime_entry
values ('A001', 'Toradora', new_anime_entry('Completed', 'Slice of Life', 'PG-13', 'TDORA')
); 

--add a second entry for the sake of proving this object works
insert into anime_entry
values ('A002', 'Darker Than Black', new_anime_entry('Completed', 'Action', 'R', 'DTB')
); 

--begin code block created to prove that the above object and entries actually worked
DECLARE
    --references data types and data values from the anime_entry table
    v_anime_id anime_entry.anime_id%TYPE;
    v_title anime_entry.title%TYPE;
    v_new_entry new_anime_entry;
BEGIN
    v_anime_id := 'A003';
    v_title := 'K-On!';
    --this newly created variable will be assigned the value of the object plus the data to be inputted via the object
    v_new_entry := new_anime_entry ('Completed', 'Slice of Life', 'PG', 'KON'
);

--insert into the anime_entry table the newly created and assigned variables
insert into anime_entry (anime_id, title, new_entry) values (v_anime_id, v_title, v_new_entry); 
--commit information to the database
commit;
--end code block
end; 
/

--select all rows from anime_entry to output to console for proof all of the above statements worked
select * from anime_entry;