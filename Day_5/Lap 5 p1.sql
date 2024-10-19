use ITI

------------------------------------------------------1---------------------------------------------------
select count(St_Age) as [number of students who have a value in their age] 
from Student
where St_Age is not null

-----------------------------------------------------2----------------------------------------------------

select distinct Ins_Name
from Instructor

-------------------------------------------------------3----------------------------------------------------

select  St_Id as [Student ID] , St_Fname + ' ' + St_Lname as [Student name] , Dept_Name as [Department name]
from student inner join Department
on student.Dept_Id = Department.Dept_Id 
where  St_Fname + ' ' + St_Lname is not null
-----------------------------------------------------4-------------------------------------------------------

select Ins_Name , Dept_Name
from Instructor left join Department
on Instructor.Dept_Id = Department.Dept_Id
-----------------------------------------------------5--------------------------------------------------------

select St_Fname + ' ' + St_Lname as [Student full name ], Crs_Name
from student inner join Stud_Course 
on Student.St_Id = Stud_Course.St_Id
inner join Course
on Stud_Course.Crs_id = Course.Crs_id
where Grade is not null
---------------------------------------------------6------------------------------------------------------------

select count(*)
from Course
group by Top_Id

--------------------------------------------------7--------------------------------------------------------------

select max(Salary) as [max salary], min(Salary) as[min salary]
from Instructor
-------------------------------------------------8---------------------------------------------------------------

select *
from Instructor
where Salary < ( select avg(salary)
				from Instructor )

-----------------------------------------------9--------------------------------------------------------------------

select Dept_Name
from Department inner join Instructor
on Department.Dept_Id = Instructor.Dept_Id
where Salary in (select min(Salary)
				from Instructor)

-------------------------------------------------10---------------------------------------------------------------------

select top 2 Salary
from Instructor
order by Salary desc

-----------------------------------------------11--------------------------------------------------------------------------

select Ins_Name , COALESCE(Salary,100)
from Instructor

---------------------------------------------12----------------------------------------------------------------------------

select avg(Salary)
from Instructor

-----------------------------------------------13-------------------------------------------------------------------------
select s1.St_Fname as [Student], s2.St_Fname,s2.St_Lname,s2.St_Id
from Student as s1 inner join Student as s2
on s1.St_super = s2.St_Id

-------------------------------------------------14------------------------------------------------------------------------

select distinct Salary
from (select * , DENSE_RANK() over (order by Salary desc) as DR
		from Instructor) as newTable
where DR =1 or DR =2

------------------------------------------------15----------------------------------------------------------------------------




select* from Student
select * from Stud_Course
select * from Course
select * from Topic
select * from Instructor
select * from Department

