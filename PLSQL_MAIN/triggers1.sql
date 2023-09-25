--                                                Triggers

/* Atrigger is a course of action to be taken when any DDL,DML event occurs

It is a named PL/SQL block like a procedure

But it is executed implicitly by Oracle Server

Types

DML Triggers (Table level)

DDL Triggers (Database level)


Why do we create Triggers ?

To control DML
Implement complex business rule
Implement complex validations
Generate values for primary key
For auditing
Maintain replicas


General Syntax for Triggers:

create [or replace ] trigger trigger_name

[before | after | instead of ]

[insert [or] | update [or] | delete] on table_name

[referencing old as 0 new as n]
 
[for each row] [when (condition)]

[declare <declare section>]

begin

[exception]

end;



----------------------------------------------------------------------------------------------
Levels of Triggers

Statement level   (default) executed only once for the statement

Row Level      executed once for each row effected by the DML/DDL

*/
-------------------------------------------------------------------------------------------------
create table students(rno number,name varchar2(10),age number,gender char(2));

select * from students;

----------------------------------------------------------------------------------------------------
/*

            DML Triggers --> statement level  using before keyword

*/
-------------------------------------------------------------------------------------
set serveroutput on;
create or replace trigger plsqltrig1
before insert or update or delete on students
begin
dbms_output.put_line('plsqltrig1');
end;

--DML STATEMENT
update students set age=age-1;
-------------------------------------------------------------------------------------
/*     output after update statement

plsqltrig1

5 rows updated.

*/
------------------------------------------------------------------------------------
/*

              DML TRIGGERS -->ROW LEVEL  using before keyword
*/
--------------------------------------------------------------------------------------
create trigger plsqltrigg2
before insert or update or delete
on students
for each row
begin
dbms_output.put_line('plsqltrigg2');
end;

--DML STATEMENTS
insert into students values(6,'Nobita',14,'M');
insert into students values(7,'Doremon',1,'M');
insert into students values(8,'Suzuki',12,'F');


-----------------------------------------------------------------------------------------------------------
/*
                      OUTPUT

plsqltrigg2

1 row inserted.

plsqltrigg2


1 row inserted.

plsqltrigg2


1 row inserted.


*/
-----------------------------------------------------------------------------------------------------------------
/*

            DML Triggers --> statement level  using after keyword   

*/
------------------------------------------------------------------------------------------
create table example(r number(2));

set serveroutput on;
create or replace trigger triger3
after insert or update or delete on example
begin
dbms_output.put_line('triger3');
end;
/


--insert into example values(1);
--insert into example values(2);

--DML STATEMENT
update example set r=r-1;

select * from example;
--drop TRIGGER PLSQLTRIGER3;
-----------------------------------------------------------------------------------
/*
same output as using the before keyword

triger3

6 rows updated.
*/
----------------------------------------------------------------------------------------
/* 
           DML TRIGGERS -->ROW LEVEL  using after keyword
*/
--------------------------------------------------------------------------------------------

create table example2(r number(2));

insert into example2 values(1);
insert into example2 values(2);


create trigger trigger4
after update on example2
for each row
begin
dbms_output.put_line('trigger4');
end;

--DML STATEMENT

update example2 set r=r+5;

/*
 
                 Output

trigger4
trigger4


2 rows updated.

*/


-- instead of trigger







