create database E3;
use E3;

create table student(
student_name varchar(20),
student_number int,
class int,
major varchar(5),
primary key(student_number)
);

create table course(
course_name varchar(30),
course_number varchar(40),
credit_hours int,
department varchar(5),
primary key (course_number)
);

create table section(
section_identifier int,
course_number varchar(40),
semester varchar(10),
years int,
instructor varchar(20),
foreign key(course_number)references course(course_number),
primary key(section_identifier)
);

create table grade_report(
student_number int,
section_identifier int,
grade varchar(5)
);

Alter table grade_report
	add constraint foreign key (student_number) references student(student_number);
Alter table grade_report
add constraint foreign key (section_identifier) references section(section_dentifier);


create table prerequisite(
course_number varchar(40),
prerequisite_number varchar(20),
foreign key(course_number)references course(course_number)
);

insert into student(student_name,student_number,class,major)values('smith',17,1,'cs'),('brown',8,2,'cs');
insert into course(course_name,course_number,credit_hours,department)values('Intro to computer science','CS1310',4,'cs'),('Data structure','CS3320',4,'cs'),('Discrete Mathematics','MATH2410',3,'MATH'),('Database','CS3380',3,'cs');
insert into section(section_identifier,course_number,semester,years,instrutor)values(85,'MATH2410','fall',07,'king'),(92,'CS1310','fall',07,'Anderson'),(102,'CS3320','spring',08,'kruth'),(112,'MATH2410','fall',08,'chang'),(119,'CS1310','fall',08,'Anderson'),(135,'CS3380','fall',08,'stone');
insert into grade_report(student_number,section_identifier,grade)values(17,112,'B'),(17,119,'C'),(8,85,'A'),(8,92,'A'),(8,102,'B'),(8,135,'A');
insert into prerequisite(course_number,prerequisite_number)values('CS3380','CS3320'),('CS3380','MATH2410'),('CS3320','CS1310');

-- 1st question
SELECT grade_report.grade, section.course_number 
FROM grade_report
INNER JOIN section ON section.section_identifier = grade_report.section_identifier
INNER JOIN student ON grade_report.student_number = student.student_number
WHERE student.student_name = "Smith";

-- 2nd question
SELECT student.student_name, grade_report.grade 
FROM course
INNER JOIN section ON course.course_number = section.course_number
INNER JOIN grade_report ON section.section_identifier = grade_report.section_identifier
INNER JOIN student ON grade_report.student_number = student.student_number
WHERE course.course_name = "Database" AND section.semester = "fall";

-- 3rd
SELECT prerequisite.prerequisite_number
FROM course 
INNER JOIN prerequisite on prerequisite.course_number = course.course_number
WHERE course_name = "Database" ;


-- 4th
CREATE VIEW senior_cs_students1 AS
SELECT student.student_name
FROM student
WHERE major = 'cs' AND class >= 4;

SHOW CREATE VIEW senior_cs_students;

-- 5th
SELECT course.course_name  
FROM course
INNER JOIN section on section.course_number = course.course_number
WHERE years=07 and 08 and instructor="king" ;

-- 6th
SELECT section.course_number , section.semester , section.years , count(grade_report.student_number) as student_count 
FROM section 
INNER JOIN grade_report on section.section_identifier = grade_report.section_identifier
WHERE  instructor = "king" 
GROUP BY section.course_number, section.semester, section.years;

-- 7th
SELECT student.student_name,course.course_name,course.course_number,course.credit_hours,section.semester,section.years,grade_report.grade 
FROM student
INNER JOIN grade_report on student.student_number=grade_report.student_number
INNER JOIN section on section.section_identifier=grade_report.section_identifier
INNER JOIN course on course.course_number=section.course_number
WHERE major='cs' and class=2;

-- 8a
INSERT into student(student_name,student_number,class,major) values('Johnson', 25 , 1 ,'Math');

-- 8b
SET SQL_SAFE_UPDATES = 0;

UPDATE student
SET class = 2
WHERE student_name = 'Smith';

-- 8c
insert into course values ( 'Knowledge Engineering', 'CS4390', 3, 'CS');

-- 8d
DELETE FROM grade_report
WHERE student_number = 17;
DELETE FROM student
WHERE student_name = 'Smith' AND student_number = 17;




