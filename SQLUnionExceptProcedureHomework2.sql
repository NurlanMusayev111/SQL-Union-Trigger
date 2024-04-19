create database CourseCode

use CourseCode



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


create table Teachers(
	[Id] int primary key identity(1,1),
	[Fullname] nvarchar(100),
	[Salary] decimal,
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Groups(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
)

ALTER TABLE Groups
ADD [RoomId] int,
foreign key (RoomId) references Rooms(Id);




create table TeacherGroups(
	[Id] int primary key identity(1,1),
	[TeacherId] int,
	[GroupId] int,
	foreign key (TeacherId) references Teachers(Id),
	foreign key (GroupId) references Groups(Id)
)


create table Students(
	[Id] int primary key identity(1,1),
	[Fullname] nvarchar(100),
	[Age] int,
	[Email] nvarchar(100),
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table StudentGroups(
	[Id] int primary key identity(1,1),
	[GroupId] int,
	[StudentId] int,
	foreign key (GroupId) references Groups(Id),
	foreign key (StudentId) references Students(Id)
)


create table Rooms(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[Capacity] int
)


create table StaffMembers(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Roles(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100),
	[StaffMemberId] int,
	foreign key (StaffMemberId) references StaffMembers(Id)
)