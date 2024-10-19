------------------------------Create a view that displays student full name, course name if the student has a grade more than 50. --------

use iti

create view V1
as
select St_Fname+' ' + St_Lname as StudentFullName , Course.Crs_Name 
from Student inner join Stud_Course
on Student.St_Id = Stud_Course.St_Id
inner join Course 
on Stud_Course.Crs_Id = Course.Crs_Id
where Stud_Course.Grade > 50

select * from V1

-----------------------------⦁	 Create an Encrypted view that displays manager names and the topics they teach. -------------

create view V2
with encryption
as
select A.Ins_Name , C.Crs_Name
from Instructor as A inner join Ins_Course AS B
on A.Ins_Id = B.Ins_Id
inner join Course as C
on C.Crs_Id = B.Crs_Id

select * from V2

----------------------------------⦁	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department ---

create view V3
as
select A.Ins_Name , C.Crs_Name
from Instructor as A inner join Ins_Course AS B
on A.Ins_Id = B.Ins_Id
inner join Course as C
on C.Crs_Id = B.Crs_Id
where C.Crs_Name = 'SD' OR C.Crs_Name = 'Java'

select * from V3

-------------------------------⦁	 Create a view “V1” that displays student data for student who lives in Alex or Cairo.-------------

create view V4 
as 
SELECT * from Student
where St_Address = 'Alex' or St_Address = 'Cairo'

select * from V4

Update V4 set St_Address='tanta'
Where St_Address='alex'

select * from V4

---------------------------------------⦁	Create a view that will display the project name and the number of employees work on it. “Use Company DB”----

use Company_SD

create view V5 
as 
select P.Pname , COUNT(E.SSN) as EmpNum
from Project as P inner join Employee as E
on P.Dnum = E.Dno
GROUP BY P.Pname

select * from V5

---------------------------⦁	Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?--

create clustered index I1
on Department (Manager_hiredate) --ERORR Cannot create more than one clustered index on table 'Department'.

--------------------------⦁	Create index that allow u to enter unique ages in student table. What will happen?------------------- 

Create unique index I2
on student (St_Age) -- ERORR The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'I2'. The duplicate key value is (21).

------------------------⦁	Using Merge statement between the following two tables [User ID, Transaction Amount]-------

create table LastTransaction(
id int PRIMARY KEY,
Lvalue int)

insert into LastTransaction 
values (1,4000),(4,2000),(2,10000)

create table DailyTransaction(
Did int PRIMARY KEY,
Dvalue int)

insert into DailyTransaction 
values (1,1000),(2,2000),(3,1000)

merge into LastTransaction as T
using DailyTransaction as S
on T.id = S.Did
when matched then 
update set T.Lvalue = S.Dvalue
When not matched then 
insert values (S.Did,S.Dvalue);

----------------------------------------------------P2----------------------------------------------------------

USE SD

-----------------------⦁	Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.---------

select * from company.Department
select * from company.Project
select * from Works_on

create view V_clerk
as 
select EmpNO , ProjectNo , Enter_Date 
from Works_on
where Jop = 'Clerk'

SELECT * FROM V_clerk

---------------------Create view named  “v_without_budget” that will display all the projects data without budget---------------
create view V_without_budget 
as
select ProjectNo,ProjectName
from company.Project

SELECT * FROM V_without_budget

--------------⦁	Create view named  “v_count “ that will display the project name and the # of jobs in it--------------------------

create view v_count 
as 
select P.ProjectName , COUNT(W.Jop) as JopNo
from company.Project as P inner join Works_on as W
on P.ProjectNo = W.ProjectNo
group by ProjectName

SELECT * FROM v_count

---------------⦁	 Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’-----------------------

create view v_project_p2
as
select ProjectNo , COUNT(EmpNo) as EmpNo
from Works_on
group by ProjectNo
HAVING ProjectNo= 'p2'

SELECT * FROM v_project_p2

--------------⦁	modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 ------------
alter view V_without_budget 
as
select ProjectNo,ProjectName
from company.Project
WHERE ProjectNo = 'p1' OR ProjectNo = 'p2'

SELECT * FROM V_without_budget

-----------⦁	Delete the views  “v_ clerk” and “v_count”--------------------------------------

drop view V_clerk
drop view v_count

--------⦁	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’--------------------------------------

create view V22
as 
SELECT EmpNO , EmpLname
FROM HumanResource.employee
WHERE DeptNo = 'd2'

select * from V22

-------⦁	Create view named “v_dept” that will display the department# and department name----------
create view V23
as 
SELECT DeptNo , DeptName
From company.Department

select * from V23

----------⦁	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development----------

insert into V23
Values ('d4','Development')

select * from V23














