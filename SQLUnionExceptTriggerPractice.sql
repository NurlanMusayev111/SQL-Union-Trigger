create database unionExceptTrigger

use unionExceptTrigger


create table Countries(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)


create table Cities(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[CountryId] int,
	foreign key (CountryId) references Countries(Id)
)


create table Employees(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[Surname] nvarchar(100),
	[Email] nvarchar(100),
	[Age] int
)


create table Teachers(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(100),
	[Salary] int,
	[Age] int,
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Students(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(100),
	[Email] nvarchar(100),
	[Address] nvarchar(100),
	[Age] int,
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Doctors(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)
)



--UNION AND UNION ALL

select [FullName] from Teachers
union
select [FullName] from Students



select [FullName] from Teachers
union all
select [FullName] from Students



--intersect and except

select [FullName] from Teachers
intersect
select [FullName] from Students



select [FullName] from Teachers
except
select [FullName] from Students



--truncate


truncate table Doctors



--trigger


create table StudentLogs(
	[Id] int primary key identity(1,1),
	[StudentId] int,
	[Operation] nvarchar(50),
	[Date] datetime
)


create table EmployeeLogs(
	[Id] int primary key identity(1,1),
	[EmployeeName] nvarchar(100),
	[OldEmail] nvarchar(100),
	[NewEmail] nvarchar(100),
	[Operation] nvarchar(20),
	[Date] datetime
)


select * from StudentLogs


create trigger trg_writeLogAfterCreate on Students
after insert
as
begin
	insert into StudentLogs([StudentId],[Operation],[Date])
	select [Id],'insert',GETDATE() from inserted
end



insert into Students([FullName],[Email],[Address],[Age],[CityId])
values('Tasos Bakasetas','bt@mail.ru','greece',27,4)


select * from Students
select * from StudentLogs



create trigger trg_writeLogAfterEdit on Students
after update
as
begin
	insert into StudentLogs([StudentId],[Operation],[Date])
	select [Id],'Update',GETDATE() from deleted

end



update Students
set [Email] = 'panatinakios@mail.ru'
where [Id] = 5





create trigger trg_writeLogAfterEditEmail on Employees
after update 
as
begin
	declare @oldEmail nvarchar(100) = (select [Email] from deleted)
	declare @fullName nvarchar(100) = (select [Name] from deleted)
	declare @newEmail nvarchar(100) = (select [Email] from inserted)
	insert into EmployeeLogs([EmployeeName],[OldEmail],[NewEmail],[Operation],[Date])
	values(@fullName,@oldEmail,@newEmail,'Update',GETDATE())
end



update Employees
set [Email] = 'baka@mail.ru'
where [Id] = 2

select * from Employees
select * from EmployeeLogs