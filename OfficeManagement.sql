

create database OfficeManagement

use OfficeManagement
go

create schema Office authorization dbo
go

create table [Office].[Department]
(
	DepId int not null constraint pk_OfficeManagement_Department_DepId primary key (DepId),
	DepName varchar(30) not null
)ON [Primary];
go

create procedure [Office].[Department_Ins]
(
	@DepId int,
	@DepName varchar(30)
)
as
begin
	insert into [Office].[Department] (DepId,DepName)
		values (@DepId,@DepName)
end

go

create table [Office].[SalaryGrade]
(
	Grade int not null constraint pk_Office_SalaryGrade_Grade primary key (Grade),
	MinSalary int not null,
	MaxSalary int not null,
)ON [Primary];

go

create procedure [Office].[SalaryGrade_Ins]
(
	@Grade int,
	@MinSalary int,
	@MaxSalary int
)
as
Begin
	insert into [Office].[SalaryGrade] (Grade,MinSalary,MaxSalary)
		values (@Grade,@MinSalary,@MaxSalary)
End
go

create table [office].[WorkShift]
(
	ShiftName varchar(2) not null constraint pk_Office_WorkShift_ShiftName primary key (ShiftName),
	TimeStart time not null,
	TimeEnd time not null
)ON [Primary];
go

Create procedure [Office].[WorkShift_Ins]
(
	@ShiftName varchar(2),
	@TimeStart time,
	@TimeEnd time
)
as
begin
	insert into [Office].[WorkShift] (ShiftName,TimeStart,TimeEnd)
		Values (@ShiftName,@TimeStart,@TimeEnd)
end
go

create table [Office].[Employees]
(
	EmpId int not null constraint pk_Office_Employee_EmpId primary key (EmpId),
	EmpName varchar(50) not null,
	EmpFatherName varchar(50) not null,
	Designation varchar(20) not null,
	ManagerId int null constraint fk_Office_Employees_ManagerId foreign key (ManagerId) references [Office].[Employees] (EmpId),
	JoiningDate date not null,
	DepId int not null constraint fk_Office_Employees_DepId foreign key (DepId) references [Office].[Department] (DepId),
	ShiftName varchar(2) not null constraint fk_Office_Employees_ShiftName foreign key (ShiftName) references [Office].[WorkShift] (ShiftName),
	Arival time not null,
	Departure time not null,
	Grade int not null constraint fk_Office_Employees_Grade foreign key (Grade) references [Office].[SalaryGrade] (Grade),
	Salary int not null,
	Comission int not null
)ON [Primary];
go

Create procedure [Office].[Employees_Ins]
(
	@EmpId int,
	@EmpName varchar(50),
	@EmpFatherName varchar(50),
	@Designation varchar(20),
	@ManagerId int,
	@JoiningDate date,
	@DepId int,
	@ShiftName Varchar(2),
	@Arival time,
	@Departure time,
	@Grade int,
	@Salary int,
	@Comission int
)
as
begin
	insert into [Office].[Employees] (EmpId,EmpName,EmpFatherName,Designation,ManagerId,JoiningDate,DepId,ShiftName,Arival,Departure,Grade,Salary,Comission)
		values (@EmpId,@EmpId,@EmpFatherName,@Designation,@ManagerId,@JoiningDate,@DepId,@ShiftName,@Arival,@Departure,@Grade,@Salary,@Comission)
end
go

create table [office].[Attendance] 
(
	EmpId int not null constraint fk_office_Attendance_EmpId foreign key (EmpId) references [Office].[Employees] (EmpId),
	WDate date not null,
	DayType varchar(1) not null check(DayType in ('W','H','O','A')), -- [W]orking [H]oliday Weekly [O]ff [A]bsent
	ArivalDateTime DateTime not null,
	DepartureDateTime DateTime not null,
	WorkingHRS decimal(5,2) not null,
	OTHRS decimal(5,2) not null
	constraint pk_office_EmpId_WDate primary key (EmpId,WDate)
)ON [Primary];
go

create procedure [office].[Attendance_Ins]
(
	@EmpId int,
	@WDate date,
	@ArivalDateTime DateTime,
	@DepartureDateTime DateTime,
	@WorkingHRS decimal(5,2),
	@OTHRS decimal(5,2)
)
as
begin
	insert into [Office].[Attendance] (EmpId,WDate,ArivalDateTime,DepartureDateTime,WorkingHRS,OTHRS)
		values (@EmpId,@WDate,@ArivalDateTime,@DepartureDateTime,@WorkingHRS,@OTHRS)
end
go

create table [Office].[Salary]
(
	EmpId int not null constraint fk_office_Salary_EmpId foreign key (EmpId) references [Office].[Employees] (EmpId),
	SalMonth varchar(10) not null,
	SalYear int not null,
	Salary int not null,
	WDay int not null,
	Holiday int not null,
	WeeklyOff int not null,
	GrossSalary int not null
	constraint pk_Office_Salary_EmpId_SalMonth_SalYear primary key (EmpId,SalMonth,SalYear)
)ON [Primary];
go

create procedure [Office].[Salary_Ins]
(
	@EmpId int,
	@SalMonth varchar(10),
	@SalYear int ,
	@Salary int,
	@WDay int,
	@Holiday int,
	@WeeklyOff int,
	@GrossSalary int
)
as
begin
	insert into [Office].[Salary] (EmpId,SalMonth,SalYear,Salary,WDay,Holiday,WeeklyOff,GrossSalary)
		values (@EmpId,@SalMonth,@SalYear,@Salary,@WDay,@Holiday,@WeeklyOff,@GrossSalary)
end
go
