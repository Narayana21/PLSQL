/*
                                    SYSTEM DEFINED EXCEPTIONS
2 types

exceptions with predefined names
exceptions with no prefined names

some exceptions with predefined names

zero_divide             variable/0 gives zero_divide error
value_error             when size of variable exceeds,datatypes mismatches we get value_error
invalid_number          when trying to add a string with number
no_data_found           when no data is found
too_many_rows           when returning multiple rows
dup_val_on_index        gets when inserting a duplicate value into primary or unique column
cursor_already_open     Without closing cursor if you try to open the cursor then you will get this error
invalid_cursor          when tried to open cursor that not declared we get this error



But also some errors don't have predefined names

so we can give a name to that error

by using pragma exception_init:

takes 2 arguments

user defined exception name,error_code



example 

abc exception;
-- here we declared a user defined exception of name abc
pragma exception_init(abc,-2292);
-- here -2292 is some random error code and we are giving  name to that error code

*/

/*

                                              USER DEFINED EXCEPTIONS


user defined exceptions can be raised in two ways

1. raise statement:-

raised by name
if you want to handle it then use raise statement


syntax:
..............
exception_name exception;
......................
raise exception_name;
....................
when exception_name
then
<message to be displayed>

2. raise_application_error:-

raised by code
it will onle raise error
you cannot handle it



*/
----------------------------------------------------------------------------------------------------------------------------
set serveroutput on
declare
jb varchar2(20);
begin
select job_id into jb from employees;
dbms_output.put_line('The job_id is '||jb);
exception
when too_many_rows then
dbms_output.put_line('exact fetch returns more than requested number of rows');
end;

-------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------
set serveroutput on;
declare
jb varchar2(20);
a number(2):=20;
b number(2):=10;
c number(2);
begin
c:=a/b;
dbms_output.put_line('The  value of c is  '||c);
select job_id into jb from employees where manager_id=100;
dbms_output.put_line('The  job is '||jb);
exception
when zero_divide then
dbms_output.put_line('DIVIDE BY ZERO ERROR');
when too_many_rows then
dbms_output.put_line('WE are retreving multiple records/values of job');
end;
-------------------------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on
declare
jb varchar2(20);
begin
select job_id into jb from employees where employee_id=101;
dbms_output.put_line('The  job is '||jb);
exception
when too_many_rows then
dbms_output.put_line('WE are retreving multiple records/values of job');
end;
---------------------------------------------------------------------------------------------------------------

 declare
 b varchar2(10);
 begin
 select salary into b from employees where employee_id=10;
 dbms_output.put_line('DATA FOUND');
 exception
 when no_data_found then
 dbms_output.put_line('N0 DATA FOUND');
 end;

----------------------------------------------------------------------------------------------------------------------

-- Pragma exception
-- It is the process of giving our own name to handle error

set serveroutput on;
declare
a exception;
pragma exception_init(a,-20001);
jb varchar2(20);
begin
raise a;
select job_id into jb from employees where employee_id=10;
dbms_output.put_line('The data is present/avilable '||jb);
exception
when a then
dbms_output.put_line('The data is not present/avilable');
dbms_output.put_line(sqlerrm);--displays error code also
when no_data_found then
dbms_output.put_line('No data found');
end;

------------------------------------------------------------------------------------------------------------------------------- 
-- raise statement



declare
nu number(2):=4;
de number(2):=1;
res number(4);
e exception;
begin
if de=1 then
raise e;
else
res:=nu/de;
end if;
dbms_output.put_line('The division result is '||res);
exception 
when e then
dbms_output.put_line('division with 1 is not allowed');
end;





----------------------------------------------------------------------------
-- raise_application_error

--NOTE : error code you are using can be any number in range 20001 to 20099


set serveroutput on;
declare
jb varchar2(20);
begin
select job_id into jb  from employees where employee_id=10;
dbms_output.put_line('The data is  present/avilable '||jb);
if sql%found then
dbms_output.put_line('The data is  present/avilable '||jb);
raise_application_error(-20001,'The record is avialble ,  ApplicationError is raised');
end if;
exception
when others then
--dbms_output.put_line('The data is not present/avilable');
--dbms_output.put_line(sqlerrm);
raise_application_error(-20001,'The record is not avialble ,  Application Error is raised');
--dbms_output.put_line(sqlerrm);
end;

--another example:



declare
nu number(2):=2;
de number(2):=0;
res number(4);
begin
if de=0 then
raise_application_error(-20006,'The denominator you choosen is equal to 0 so choose another number my friend');
else
res:=nu/de;
end if;
dbms_output.put_line('The division result is '||res);
end;















