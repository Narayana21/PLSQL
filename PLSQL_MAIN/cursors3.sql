
------------------------------------------CURSORS---------------------------

/*

Oracle creates a memory area, known as context area, for processing an SQL 
statement, which contains all information needed for processing the statement, for example, 
number of rows processed etc. 

A cursor is a pointer to this context area. PL/SQL controls the context area through a cursor. A 
cursor holds the rows (one or more) returned by a SQL statement. The set of rows the cursor 
holds is referred to as the active set.

You can name a cursor so that it could be referred to in a program to fetch and process the rows 
returned by the SQL statement, one at a time. There are two types of cursors: 

1 Implicit cursors 
2 Explicit cursors

-----------------------------------------------------------------------------------------------------------------------------------------   
*/

-- IMPLICT CURSOR
/* implict cursors are created by the oracle server when executing the DML commands like insert update delete

in PL/SQL we don't know how many rows got inserted through insert command or how many rows got modfied through update and
delete commmands

so with help of impicit cursors we can get status of wether DML operation is successfull and also the info of above mentioned

NOTE: The Impicit Cursor name is "SQL"

and it has 3 attributes


%FOUND     --> TRUE OR FALSE

%NOTFOUND  --> OPP OF %FOUND

%ROWCOUNT   --> RETURNS THE NO.OF ROWS


How to use implicit cursor

cursor_name%attribute_name

SQL%found
SQL%notfound
SQL%rowcount

*/
---------------------------------------------------------------------------------
create table cursor_example(employee varchar2(10),age number(2));

----------------------------------------------------------------------------
set SERVEROUTPUT on;
declare
total_rows cursor_example.age%type;
begin
insert into cursor_example values('abc',24);
insert into cursor_example values('abcd',25);
total_rows:=sql%rowcount;
dbms_output.put_line(total_rows||' rows inserted');
end;
----------------------------------------------------
select * from cursor_example;

------------------------------------------------
set SERVEROUTPUT on;
declare
total_rows cursor_example.age%type;
begin
update cursor_example set age=age+1;
total_rows:=sql%rowcount;
dbms_output.put_line(total_rows||' rows updated');
end;
----------------------------------------------------
set SERVEROUTPUT on;
DECLARE
r number(2);
begin
delete from cursor_example where age=28;
if sql%found then
   dbms_output.put_line(sql%rowcount||' rows are deleted');
   end if;
if sql%notfound then
  dbms_output.put_line(0 ||' rows are deleted');
  end if;
end;

-----------------------------------------------------------------------------------------------------------------------------
--2.EXPLICIT CURSORS

/*

Explicit Cursors are user defined cursors

It is used to acces one row at a time same like implict cursor.

Unlike sql command which give entire data at a time cursor helps us to process each row at a time line by line

Simply row by row execution can be made possible with help of Cursors


Steps:

DECALRE  CURSOR
OPEN     CURSOR 
FETCH    RECORDS
CLOSE    CURSOR
*/


-- declare cursor

-- cursor always declared with a select statement
-- assiging a select statement to c1
-- which table you want to be processed assign a cursor to that table via select stamtement   

--      cursor c1 is select * from plsql;

-- Opening the Cursor


-- here data will be not be loaded at the time of declaration
-- this can be possible through OPEN Cursor

--    open c1;

-- after this statment oracle executes the select statement associated with the 
-- cursor in declaration part and returns the data
-- This data is stored in temparory area called context area
-- this context area formed in PGA(Program Global Area)
-- now cursor c1 points to the context area

-- Fetching records from cursor

-- syntax

--    fetch  cursor_name into variable_1,varaiable_2....;

-- every time fetch statement executes only one record is feteched and assigned to the variables
-- inorder to get the every record use it inside the loops;

-- fetch c1 into x,y,z;

--  Closing cursor

-- close c1;


declare 
    cursor c1 is select name,salary from plsql;
    n plsql.name%type;
    s plsql.salary%type;
begin
    open c1;
loop
    fetch c1 into n,s;
    exit when c1%notfound;
    dbms_output.put_line(n||' '||s);
end loop;
    close c1;
end;
























