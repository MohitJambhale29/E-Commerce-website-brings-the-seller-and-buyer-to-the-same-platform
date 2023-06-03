-- Q1. Create new schema as alumni

create schema alumni;
use alumni;

-- Q2. Import all .csv files into MySQL
SELECT 
    COUNT(*)
FROM
    college_a_hs,
    college_a_se,
    college_a_sj,
    college_b_hs,
    college_b_se,
    college_b_sj;

-- Q3. Run SQL command to see the structure of six tables
desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

-- Q4. Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.
-- Ans attached in python file.

-- Q5. Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
-- Ans attached in MS Excel file.

-- Q6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
SELECT 
    *
FROM
    college_a_hs;

CREATE VIEW College_A_HS_V AS
    (SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_a_hs_v;

-- Q7.Perform data cleaning on table College_A_SE and store cleaned data in view , Remove null values.
SELECT 
    *
FROM
    college_a_se;

CREATE VIEW College_A_SE_V AS
    (SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_a_se_v;

-- Q8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
SELECT 
    *
FROM
    college_a_sj;

CREATE VIEW College_A_SJ_V AS
    (SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_a_sj_v;

-- Q9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
SELECT 
    *
FROM
    college_b_hs;

CREATE VIEW College_B_HS_V AS
    (SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_b_hs_v;

-- Q10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
SELECT 
    *
FROM
    college_b_se;

CREATE VIEW College_B_SE_V AS
    (SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_b_se_v;

-- Q11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
SELECT 
    *
FROM
    college_b_sj;

CREATE VIEW College_B_SJ_V AS
    (SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL);

SELECT 
    *
FROM
    college_b_sj_v;

-- Q12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
delimiter //
create procedure lowercase()
begin
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_a_hs_v;
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_a_se_v;
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_a_sj_v;
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_b_hs_v;
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_b_se_v;
select lower(Name) name, lower(FatherName) fathername, lower(MotherName) mothername from college_b_sj_v;
end //
delimiter ;

call lowercase();

-- Q13.Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni. 
-- Ans attached in MS Excel file.
-- first 100 rows are used to create the tables.

-- Q14.Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
delimiter $$
create procedure get_name_collegeA(inout Name_A text (50000))
begin 
declare namelist varchar(16000) default "";
declare finished int default 0;
declare namedetail 
	cursor for
    select name from college_a_hs
    union
    select name from college_a_se
    union
    select name from college_a_sj;
declare continue handler for not found set finished = 1;

open namedetail;
get_college_A_name:
loop
fetch namedetail into namelist;
if finished = 1 then leave get_college_A_name;
end if;
set Name_A = concat(namelist,';',Name_A);
end loop get_college_A_name;

select * from college_a_hs;
select * from college_a_se;
select * from college_a_sj;
close namedetail;
end $$

delimiter ;

set @name_A = "";
call get_name_collegeA(@name_A);
SELECT @name_A;

-- Q15.Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
delimiter //
create procedure get_name_collegeB (inout Name_B text (50000))
begin
declare namelist varchar(16000) default "";
declare finished int default 0;
declare namedetail
	cursor for 
		select name from college_b_hs
		union
		select name from college_b_se
		union
		select name from college_b_sj;
declare continue handler for not found set finished = 1;

open namedetail;
get_college_B_name:
loop
fetch namedetail into namelist;
if finished = 1 then leave get_college_B_name;
end if;
set Name_B = concat(namelist,';',Name_B);
end loop get_college_B_name;

select *  from college_b_hs;
select *  from college_b_se;
select *  from college_b_sj;
close namedetail;
end//
delimiter ;

set @Name_B = "";
call get_name_collegeB(@Name_B);
SELECT @Name_B;

/* Q16.Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
Note: Approximate percentages are considered for career choices.
*/

SELECT 
    'Higher Studies',
    (SELECT 
            COUNT(*)
        FROM
            college_a_hs) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100 AS College_A_Percentage,
    (SELECT 
            COUNT(*)
        FROM
            college_b_hs) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100 AS College_B_Percentage

UNION SELECT 
    'Self Employes',
    (SELECT 
            COUNT(*)
        FROM
            college_a_se) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100,
    (SELECT 
            COUNT(*)
        FROM
            college_b_se) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100

UNION SELECT 
    'Service/Job',
    (SELECT 
            COUNT(*)
        FROM
            college_a_sj) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100,
    (SELECT 
            COUNT(*)
        FROM
            college_b_sj) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100;