--                                                           VIEWS


/*
view is an virtual table.They doesn't exsit in reality

used in selecting fields from one or more tables present in DB

syntax

crrate view name as
select columns,...
from table-name
where 
order by 
group by.....




benfits

1) views can hide complexity (joins)
2) views can be hold as a security mechansim (can restricts the columns that can be visible to user)


Note:

There is no record in the view
It only holds defnitions of table and fetches data from table and shows it
Views are stored as permanent query objects in database


*/
--SINGLE TABLE  VIEW

create view details as
select last_name,salary from employees;

--MULTIPLE TABLES VIEW

create view deatils2 as
select e.last_name,d.department_name from employees e join departments d on
e.department_id=d.department_id;


/*

Now we can perform almost all the DML operations on the above two views

*/
desc details;
desc deatils2;

select * from details;
select * from deatils2;

select e.last_name,e.salary,d.department_name from details e,deatils2 d where e.last_name=d.last_name;

/* delete or update on views will also effect the base table

While INSERT DML is subjected to several restrictions:-

--> A view must contain all the not null columns from the underlying table
--> If there is any column with referential key constraint in the underlying table
   then view must contain that column and a proper value must be provided to that column while performing
   insert on the view.
*/

/*        

Now lets try to reduce the complexity of joins using views

now we will create a view upon joining two tables and that view acts like a virtual table and can be used to join other table or views
*/

create view emp_dept_join as select e.employee_id,e.last_name,e.salary ,d.department_id,d.department_name,l.location_id,l.city
from employees e join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id;

select * from emp_dept_join;












------------------------------------------------------------------------------------------------------------------------------------------------
create or replace view emp_dept_join as select d.deptno,d.dname,e.empno,e.ename,e.sal from emp e, dept d
where e.deptno = d.deptno;


CREATE OR REPLACE TRIGGER insert_emp_dept
INSTEAD OF INSERT ON emp_dept_join
DECLARE
  v_deptno  dept.deptno%TYPE;
BEGIN

  BEGIN
    SELECT deptno INTO v_deptno
    FROM   dept
    WHERE  deptno = :new.deptno;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN

      INSERT INTO dept (deptno, dname)
             VALUES (:new.deptno, :new.dname)
             RETURNING deptno INTO v_deptno;
  END;

  INSERT INTO emp (empno, ename,sal, deptno)
         VALUES(:new.empno, :new.ename,:new.sal, v_deptno);

END insert_emp_dept;
/ 
SHOW ERRORS;

insert into emp_dept_join(deptno,dname,empno,ename,sal) values(50,'Systems',1009,'ABCD',1200);
 select * from emp;
