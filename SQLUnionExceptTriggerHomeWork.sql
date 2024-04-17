create database CourseTrg

use CourseTrg

create table Students(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int,
	[Email] nvarchar(50),
	[Address] nvarchar(50)
)


insert into Students([Name],[Surname],[Age],[Email],[Address])
values('Nurlan','Musayev',22,'nm@mail.ru','narimanov'),
      ('Gunel','Veliyeva',32,'gv@mail.ru','Baku'),
	  ('Narmin','Memmedova',30,'narm@mail.ru','Kazakh'),
	  ('Fidan','Elekberli',27,'fe@mail.ru','Bilajari')




create table StudentLogs(
	[Id] int primary key identity(1,1),
	[Operation] nvarchar(20),
	[delName] nvarchar(100),
	[delSurname] nvarchar(100),
	[delAge] int,
	[delEmail] nvarchar(100),
	[delAddress] nvarchar(100)
)



create trigger trg_writeStudentInfoAfterDelete on Students
after delete
as 
begin 
	insert into StudentLogs([Operation],[delName],[delSurname],[delAge],[delEmail],[delAddress])
	select 'Delete',Name,Surname,Age,Email,Address from deleted
end




create procedure usp_deleteStudentsById
@id int
as
delete from Students where [Id] = @id


exec usp_deleteStudentsById 4


select * from Students
select * from StudentLogs

