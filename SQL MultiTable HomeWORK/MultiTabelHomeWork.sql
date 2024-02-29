
/*Заполняем БАЗУ*/

insert into Curators(Name, Surname)
values
('Peter', 'Wiliams'),
('Nikolay', 'Ivanov'),
('Helena', 'Adams'),
('Jane', 'Stivens')

insert into Departments(Financing, Name, FacultyId) 
values 
(10000, 'Math', 1),
(20000, 'Literature', 2),
(30000, 'Finance', 3 ),
(50000, 'SoftvereDevelopment', 1)

insert into Faculties(Name, Financing) 
values 
('Tehological', 45000),
('Humanitary', 12000),
('Enomic', 30000)

insert into Groups(Name, Year, DepartmentId) 
values
('Octa', 5, 3),
('Delta', 5, 3),
('Alpha', 5, 5),
('Beta', 5, 4),
('Gamma', 5, 6)

insert into GroupsCurators(CuratorId,GroupId)
values
(1,6),
(2,10),
(3,11),
(4,12)

insert into GroupsLectures(GroupId,LectureId)
values
(6,12),
(10,13),
(11,14),
(12,15)

insert into Lectures(LectureRoom, SubjectId, TeacherId ) 
values
('1B',3,1),
('1A',2,2),
('1C',1,3),
('1D',4,4)

insert into Subjects(Name)
values
('Mathematics'),
('literature'),
('History'),
('Programming')

insert into Teachers(EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
values
('2014-09-11', 0, 1, 'Oskar', 'Pr', 1000, 10000, 'Wiliams'),
('2013-09-12', 1, 1, 'Mihail', 'De', 2000, 850, 'Ivanov'),
('2015-11-13', 1, 1, 'Aurora', 'Pr', 3000, 30000, 'Adams'),
('2017-05-14', 0, 0, 'Tom', 'Nk', 4000, 40000, 'Soyr')

/*ЗАПРОСЫ*/
/*Вывести все возможные пары строк преподавателей и групп.*/
select t.Name + Surname as Teacher, g.Name as 'Group' 
from Groups as g, Teachers as t
/*Вывести названия факультетов, фонд финансирования
кафедр которых превышает фонд финансирования факультета.*/
select f.Name as 'Fac_Name_Max_Finance'
from Faculties as f,Departments as d
where f.id = d.FacultyId and f.Financing > d.Financing
/*Вывести фамилии кураторов групп и названия групп, которые они курируют.*/
select c.Surname as 'Curator_Surname', g.Name as 'Group_Name'
from Curators as c,Groups as g, GroupsCurators as gc
where gc.CuratorId = gc.GroupId
/*Вывести имена и фамилии преподавателей, которые читают
лекции у группы “P107”.*/
select t.Name + t.Surname as 'Teachers'
from Teachers as t, Groups as g, Lectures as l, GroupsLectures as gl
where T.Id=l.Id and l.id=gl.Id and g.id=gl.GroupId and g.Name ='P107'
/*Вывести фамилии преподавателей и названия факультетов
на которых они читают лекции.*/
select t.Surname as 'Teachers_Surnames', f.Name as 'Faculti_Name'
from Teachers as t, Faculties as f, Lectures as l, GroupsLectures as gl
where t.Id=l.Id and l.id=gl.Id 
/*Вывести названия кафедр и названия групп, которые к
ним относятся.*/
select d.Name as 'Departments to Groups', g.Name as 'Group to Departments'
from Groups as g, Departments as d
where g.DepartmentId = d.Id
/*Вывести названия дисциплин, которые читает преподаватель “Samantha Adams”*/
select s.name as 'Subjects', t.Surname as 'Teacher_Surname'
from Subjects as s, Teachers as t, Lectures as l 
where l.SubjectId=s.Id and l.Id=t.Id and t.Name='Samantha' and t.Surname='Adams'
/*Вывести названия кафедр, на которых читается дисциплина
“Database Theory”.*/
select d.Name as 'Subjects', f.Name as 'Departments'
from Departments as d, Faculties as f
where d.FacultyId=f.Id and d.Name='Database Theory'
/*Вывести названия групп, которые относятся к факультету
“Computer Science”.*/
select g.Name as 'Groups', d.Name as 'Departments', f.Name as 'Faculties'
from Departments as d, Faculties as f, Groups as g
where f.Name='Computer Science' and g.DepartmentId=d.Id and d.FacultyId=d.Id
/*. Вывести названия групп 5-го курса, а также название факультетов, к которым они относятся.*/
select g.Name as'Groups', f.Name as 'Faculties', g.Year as 'cours'
from Groups as g, Faculties as f, Departments as d
where g.Year=5 and g.DepartmentId= d.id and d.FacultyId=f.Id
/*Вывести полные имена преподавателей и лекции, которые
они читают (названия дисциплин и групп), причем отобрать
только те лекции, которые читаются в аудитории “B103”.*/
select t.Surname+t.Name as 'Full Name', s.Name as 'Subjects', g.Name as 'Grops', l.LectureRoom as 'Room_Number' 
from Teachers as t, Lectures as l, Groups as g, Subjects as s, GroupsLectures as gl
where l.LectureRoom='B103' and gl.GroupId=g.Id and l.TeacherId=t.Id and gl.LectureId=l.Id and l.SubjectId=s.Id

