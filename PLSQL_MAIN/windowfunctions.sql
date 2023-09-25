
                        ---------------------WINDOW FUNCTIONS--------------------
--1) OVER():
select empno,ename,sal,sum(sal)over() total_sal from emp order by sal;
--select sum(sal) from emp;

select employee_id,salary,sum(salary) over() total_sal from employees order by salary;

--2) OVER PARTION BY:
select empno,ename,job,sal,round(avg(sal)over(PARTITION by job)) avg_salary from emp order by job;
select empno,ename,job,sal,sum(sal)over(PARTITION by job) total_sal from emp order by job;


select employee_id,last_name,salary,department_id,round(avg(salary) over (partition by department_id)) avg_salary from employees;

select employee_id,last_name,salary,department_id,sum(salary) over (partition by department_id) dept_wise_sum_salary,sum(salary) over() total_salary from employees;


--3) Row_number():
SELECT empno,ename,sal,job, deptno,ROW_NUMBER() OVER(PARTITION by deptno order by empno desc) 
AS rn FROM emp;


-- dept wise row numbers

select employee_id,last_name,salary,department_id,row_number() over(partition by department_id order by employee_id desc) row_num from employees;


SELECT empno,ename,sal, job, ROW_NUMBER() OVER(PARTITION BY job ORDER BY sal DESC) AS 
row_num FROM emp;

--4)RANK():

SELECT department_id, RANK () OVER (order by department_id) rnk FROM employees;
SELECT department_id,salary, RANK () OVER (order by salary) rnk FROM employees;

SELECT employee_id,last_name,salary,  department_id, RANK() OVER(PARTITION BY department_id ORDER BY salary  DESC) AS rk
FROM employees;


--SELECT empno, ename, deptno, sal,job, RANK() OVER(PARTITION by job ORDER BY sal DESC) AS rnk
--FROM emp;
--
--SELECT empno, job, sal, RANK() OVER(PARTITION BY job ORDER BY sal DESC) AS rnk
--FROM emp;

--4)dense_rank():

SELECT department_id, DENSE_RANK () OVER (order by department_id) rnk FROM employees;
SELECT department_id,salary, DENSE_RANK () OVER (order by salary) rnk FROM employees;



--
----5) first_value
--select empno,hiredate,job,ename,FIRST_VALUE(hiredate) OVER(PARTITION BY job ORDER BY hiredate)FIRST
--from emp;
--
----6) last_value
--
--select empno,ename,hiredate,job,deptno,LAST_VALUE(hiredate) OVER(PARTITION BY job ORDER BY job
--RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)HIGHEST_AGE
--from emp;


-- important quries

-- finding top 10 employees
-- using rank()
select * from (
select last_name,salary,rank() over(order by salary desc) rnk
from employees) where rnk=4;


-- using dense_rank()
select * from (
select last_name,salary,dense_rank() over(order by salary desc) rnk
from employees) where rnk<=10;


-- find nth highest salary

select * from (
select last_name,salary,rank() over(order by salary desc) rnk
from employees) where rnk=9;

-- find nth highest in each dept
select * from (
select last_name,salary,department_id,rank() over(partition by department_id order by salary desc) rnk
from employees) where rnk=2;












