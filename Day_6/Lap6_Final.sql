use SD

-- depatment 

CREATE TABLE Department
(
	DeptNo NVARCHAR(10) PRIMARY KEY,
	DeptName nvarchar(20) ,
	[Location] nvarchar(20)
)

--Create a new user data type named loc with the following Criteria:
-- ⦁	nchar(2)       ⦁	default:NY        
-- ⦁	create a rule for this Datatype :values in (NY,DS,KW)) and associate it to the location column

SP_ADDTYPE loc , 'nchar(10)'

CREATE DEFAULT def1 as 'NY'
CREATE RULE r1 as @x in ('NY', 'DS','KW')

SP_BINDEFAULT def1 , loc
SP_BINDRULE r1, loc

-- employee 
CREATE table employee
(
EmpNO bigint PRIMARY KEY,
EmpFname NVARCHAR(20) NOT NULL,
EmpLname NVARCHAR(20)NOT NULL,
DeptNo NVARCHAR(10) ,
salary int UNIQUE

FOREIGN KEY (DeptNo) REFERENCES Department (DeptNo)
)

CREATE rule r2 as @y<6000
SP_BINDRULE r2, 'employee.salary'

-- Create project using wizard

--Create Works_on using wizard

-- assigning data:-

INSERT INTO Department
VALUES ('d1','Research','NY'),
		('d2','Accountiong','DS'),
		('d3','Markiting', 'KW')

INSERT INTO employee
VALUES (25348,'Mathew','Smith','d3',2500),
	   (10102,'Ann','Jones','d3',3000),
	   (18316,'John','Barrimore','d1',2400),
	   (29346,'James','James','d2',2800),
	   (9031,'Lisa','Bertoni','d2',4000),
	   (2581,'Elisa','Hansel','d2',3600),
	   (28559,'Sybl','Moser','d1',2900)


INSERT INTO Project
VALUES ('p1','Apollo',120000),
	   ('p2','Gemini',95000),
	   ('p3','Mercury',185600)

INSERT INTO Works_on
VALUES (10102,'p1','Analyst','2006/10/1'),
       (10102,'p3','Manager','2012/1/1'),
	   (25348,'p2','Clerk','2007/2/15'),
	   (18316,'p2',NULL,'2007/6/1'),
	   (29346,'p2',NULL,'2006/12/15'),
	   (2581,'p3','Analyst','2007/10/15'),
	   (9031,'p1','Manager','2007/4/15'),
	   (28559,'p1',NULL,'2007/8/1'),
	   (28559,'p2','Clerk','2012/2/1'),
	   (9031,'p3','Clerk','2006/11/15'),
	   (29346,'p1','Clerk','2007/1/4')


--------
INSERT INTO Works_on
VALUES (1111,'p1','NAME','2003/11/22') -- error because the forgien key is not in the table that have the primary key

---------
UPDATE employee
set
EmpNO =1111
WHERE
EmpNO = 10102  -- error because the update constrain is no action

-----------
update Employee
set EmpNo = 2222
where EmpNo = 10102 -- error as the update rule is no action by default

--------------
DELETE employee
WHERE EmpNO = 10102  -- error as the DELETE rule is no action by default

---------------
ALTER TABLE employee
ADD TelephoneNumber int

----------------
ALTER TABLE employee
DROP COLUMN TelephoneNumber  

-- Create schemas and transfer tables
-- company schema

CREATE SCHEMA company
ALTER SCHEMA company TRANSFER dbo.Department
---- alter project with wizard

CREATE SCHEMA HumanResource
ALTER SCHEMA HumanResource TRANSFER dbo.employee

--display the constraints for the Employee table
select *
from HumanResource.employee

CREATE SYNONYM Emp FOR HumanResource.employee

Select * from employee -- error cuz the schema
Select * from [HumanResource].employee --Dababa
Select * from Emp -- Dababa
Select * from [HumanResource].Emp --error

------------------------------
UPDATE company.Project
SET
Budjet = Budjet + .1*Budjet
WHERE ProjectNo IN (SELECT ProjectNo
						from Works_on
						where EmpNo = 10102)

-----------------------------
UPDATE company.Department
SET
DeptName = 'Sales'
WHERE DeptNo IN (SELECT DeptNo
				  FROM HumanResource.employee
				  WHERE concat(EmpFname, ' ', EmpLname) = 'James works')

------------------------------------------------

update works_on
set Enter_Date = '12.12.2007'
where EmpNo in (
select EmpNo 
from company.Department
WHERE DeptNo = 'p1' AND DeptName = 'Sales')

------------------------------------------------

delete works_on
where EmpNo in ( select EmpNo
				from HumanResource.employee as e inner join company.Department as d
				on e.DeptNo = d.DeptNo
				where d.Location = 'KW')





































