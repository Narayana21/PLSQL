-- Basic procedures in pl/sql

create or replace procedure narayana1(x in number,y in number ,z out number)
as
begin 
z:=x*y;
end;

set SERVEROUTPUT on
declare
a number(2);
b number(2);
c number(4);
begin
a:=&a;
b:=&b;
narayana1(a,b,c);
dbms_output.put_line('Multiplication value from procedure is '||c);
end;

--=========================================================================================

CREATE OR REPLACE PROCEDURE greetings 
AS 
BEGIN 
   dbms_output.put_line('Hello World!'); 
END; 
/
EXECUTE greetings;
--=========================================================================
-- FUNCTIONS
create or replace function narayana4(a in number,b in number) 
return number
is c number;
begin
c:=a+b;
return c;
end;
-- function call
declare
s number:=4;
q number:=4;
d number;
begin
d:=narayana4(s,q);
dbms_output.put_line(d);
end;

----------------------

create or replace function totalCust 
return number
is
total number(4):=0;
begin
select count(*) into total
from employees;
return total;
end;

declare
c number(4);
begin
c:=totalCust();
dbms_output.put_line('total employees ' ||c);
end;
------------------------------------

/*

%type
%rowtype
*/

declare 
eid employees%rowtype;
maxi number;
mini number;
i number;
begin
select max(employee_id),min(employee_id) into maxi,mini from employees ;
for i in mini..maxi loop
  SELECT * into eid from employees where employee_id=i;
  dbms_output.put_line('last name is '||eid.last_name||' having employee id '||eid.employee_id);
  end loop;
end;

-----------------------------------------------

declare
n employees.last_name%type;
i employees.employee_id%type;
maxi number;
mini number;
begin
select max(employee_id),min(employee_id) into maxi,mini from employees ;
for i in mini..maxi loop
  SELECT last_name into n from employees where employee_id=i;
  dbms_output.put_line('last name is '||n||' having employee id '||i);
  end loop;
end;



--- joins in pl/sql

declare
e employees%rowtype;
d departments%rowtype;
l locations%rowtype;
i number;
maxi number;
mini number;
begin
select max(employee_id),min(employee_id) into maxi,mini from employees ;
for i in mini..maxi loop
   select * into e from employees where employee_id=i;
   select * into d from departments where department_id=e.department_id;
   select * into l from locations where location_id=d.location_id;
   
   dbms_output.put_line('The employee '||e.first_name||' '||e.last_name  ||' who works in '||d.department_name||' department at '||l.city||' earns '||e.salary);
end loop;
EXCEPTION
 WHEN no_data_found THEN
 dbms_output.put_line('   ');
end;


-- inserting multiple rows at the same time

create table plsql(name varchar2(20),salary number(6),age number(2));

declare
 type namesarray IS VARRAY(5) OF VARCHAR2(10);
 type salaries IS VARRAY(5) OF number;
 type ages is VARRAY(5) of number;
 
 names namesarray;
 salary salaries;
 age ages;
 i number;
begin
names:=namesarray('Kavita', 'Priti', 'Priya', 'Rashmika', 'Iliyana');
salary:=salaries(20000,30000,400000,500000,60000);
age:=ages(23,24,25,26,26);
for i in 1..names.count loop
  insert into plsql values(names(i),salary(i),age(i));
end loop;
end;

select * from plsql;

------------------------------------
