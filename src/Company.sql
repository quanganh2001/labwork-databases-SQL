-- 1. Write SQL Statement to create a new database
CREATE TABLE Company;
-- 2. Write a SQL statement to create to set the default working database to “Company”
USE Company;
-- Right click schemas and click Set as Default Schemas
-- 3. Write SQL statements to define tables of “Company” databases with contraints andcolumns illustrated by igures below. You should determine appropriate datatype for each column
CREATE TABLE Employee (
	Fname varchar(20),
    Minit varchar(10),
    Lname varchar(20),
    Ssn char(10),
    Bdate Date,
    Address varchar(100),
    Sex varchar(10),
    Salary decimal(10,2),
    Super_ssn char(10),
    Dno int
);

CREATE TABLE Department (
	Dname varchar(20),
    Dnumber int,
    Mgr_ssn varchar(10),
    Mgr_start_date datetime
);

CREATE TABLE Dept_locations (
	Dnumber int,
    Dlocation varchar(50)
);

CREATE TABLE Project (
	Pname varchar(100),
    Pnumber int,
    Plocation varchar(100),
    Dnum int
);

CREATE TABLE Works_on (
	Essn varchar (100),
    Pno int,
    Hours decimal(3,1)
);

CREATE TABLE Dependent (
	Essn char (10),
    Dependent_name varchar(50),
    Sex varchar(10),
    Bdate date,
    Relationship varchar(100)
);

-- 4. Add column Partner_ssn to the table EMPLOYEE. This column indicates the SSN of spouse of each employee. For those who are now single, the value should be NULL.
ALTER TABLE Employee ADD Partner_ssn char(10);
DESCRIBE Employee;

-- 5. Write SQL statements to insert sample rows to these tables.
INSERT INTO Employee
	VALUES ('Linh', 'C', 'Nguyen', '0123456789', '2001-10-27', 'Cau Giay - Hanoi', 'F', '10000000', '123456789', 1, '13456789');
SELECT * FROM Employee;

-- 6. Write SQL statements to delete the tables you created.
 DROP TABLE Company;