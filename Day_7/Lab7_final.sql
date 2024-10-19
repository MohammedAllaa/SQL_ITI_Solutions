use ITI
-----------------------------Create a scalar function that takes date and returns Month name of that date.------------------------
create function getMonths(@D date)
returns int
begin
declare @M int
set @M = month(@D)
return @M
end

SELECT dbo.getMonths('2003/11/22')

create function getMonthsName(@D date)
returns varchar(20)
begin
declare @M varchar(20)
set @M =  DATENAME(month, @D)
return @M
end 

SELECT dbo.getMonthsName('2003/11/22')

---------------------------------- Create a multi-statements table-valued function that takes 2 integers and returns the values between them.------------

create function getBetween(@frist int , @second int)
returns @value table ([value] int)
as begin 
	--declare @values table ([values] int)
	if (@frist > @second)
	begin
		while(@frist > @second+1)
		begin
			insert into @value values (@second+1)
			set @second = @second+1
		end
	end
	if (@second > @frist)
	begin
		while(@second > @frist+1)
		begin
			insert into @value values (@frist+1)
			set @frist = @frist+1
		end
	end
	return
	end

SELECT * FROM dbo.getBetween(3, 7)
SELECT * FROM dbo.getBetween(7, 3)

------------------------------- Create inline function that takes Student No and returns Department Name with Student full name.-----------

create function DFstudent (@id int)
returns table 
as 
return ( SELECT Department.Dept_Name, Student.St_Fname + ' ' + Student.St_Lname as FullName
		 FROM Student  inner join department
		 ON Student.Dept_Id = Department.Dept_Id
		 where Student.St_Id = @id)

select * from DFstudent(10)

--------------------------------Create a scalar function that takes Student ID and returns a message to user ------------------------------

create function Rmessage (@id int )
returns varchar(50)
begin
	DECLARE @O varchar(50)
	DECLARE @frist VARCHAR(20)
	SET @frist = (SELECT St_Fname FROM Student WHERE St_Id = @id);

	DECLARE @second VARCHAR(20)
	SET @second = (SELECT St_Lname FROM Student WHERE St_Id = @id);

	if (@frist IS NULL AND @second IS NULL)
	BEGIN
		 SET @O = 'First name & last name are null'
	END
	ELSE IF (@frist IS NULL AND @second IS NOT NULL)
	BEGIN
		 SET @O = 'first name is null'
	END
	ELSE IF (@frist IS NOT NULL AND @second IS NULL)
	BEGIN
		 SET @O = 'last name is null'
	END
	ELSE 
	BEGIN
		 SET @O = 'First name & last name are not null'
	END
	return @O
	end

select * from Student
select dbo.Rmessage (1)
select dbo.Rmessage (13)
select dbo.Rmessage (14)

-------------------------------Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date ------------

select * from Department
select * from Instructor

create function MDdata(@id int)
returns table
as
return ( select Department.Dept_Name , Instructor.Ins_Name , Department.Manager_hiredate
		  from Department inner join Instructor
		  on Department.Dept_Id = Instructor.Dept_Id
		  where Ins_Id = @id)

select * from MDdata(1)

----------------------------------Create multi-statements table-valued function that takes a string--------------------

create function KnowName (@name varchar(20))
returns @t table (TheName varchar(20))
as begin 

	if @name = 'fristname'
	begin
		insert into @t select isnull (St_Fname , 'Not Found') from Student
	end
	if @name = 'lastname'
	begin
		insert into @t select isnull (St_Lname , 'Not Found') from Student
	end
	if @name = 'fullname'
	begin
		insert into @t select isnull (CONCAT_WS(' ',St_Fname,St_Lname) , 'Not Found') from Student
	end
	return 
end

select * from KnowName ('fristname')
select * from KnowName ('lastname')
select * from KnowName ('fullname')

-------------------------------Write a query that returns the Student No and Student first name without the last char---------------

select St_Id , LEFT (St_Fname,LEN(St_Fname)-1)
from Student

------------------------------Wirte query to delete all grades for the students Located in SD Department --------------------
update stud_course
set Grade = NULL
where St_id in (select Student.St_Id 
				 from Student inner join Department
				  on Student.Dept_Id = Department.Dept_Id
				  where Department.Dept_Name = 'SD' )


select * from stud_course
select * from Department
select * from Student
--------------------------------------------------------------------------------------------------------------------------------------



