-- Script name: inserts.sql
-- Author: 		Daniel Chang
-- Purpose: 	insert data to test the integrity of this database system

-- The databased used to insert the data into
USE parollmanagementdb;

-- User Table inserts
INSERT INTO user (userID, name) VALUES (1, 'Daniel Chang'), (2, 'tyler small'), (3, 'artichoke');

-- account table inserts
INSERT INTO account (userID, accountID, username, password, email) VALUES (1, 1,'danielchang', 'password', 'dchang9@mail.sfsu.edu'),(2, 2,'tylercheese', 'test123', 'tyler@mail.sfsu.edu'),(3, 3,'archie', 'artichokesarethebest', 'artichoke@mail.sfsu.edu');

INSERT INTO benefits (employeeID, benefitsAmt) VALUES (1, 100), (2, 0), (3,0);

-- calendar table insert. I want to change this to something much more advanced to be actual day everyday but it is hard
-- don't have enough time to worry about that for now.
INSERT INTO calendar (calendarID, date) VALUES (1, 2022-04-11),(2, 2022-04-11),(3, 2022-04-11);

-- deadlines table inserts
INSERT INTO deadlines (calendarID, departmentID, projectID, projectDeadline) VALUES (1, 1, 1, 2023-04-11),(1, 1, 2, 2023-04-11),(3, 3, 3, 2023-04-11);

-- department tables inserts
INSERT INTO department (departmentID, managerID, projectID, department, timeSpent, funding) VALUES (1, 1, 1, 'database', 200, 200000), (2, 2, 2, 'research', 800, 1000000),(3,3,3,'building managment', 100, 3000);

-- department hasa relationship insert
INSERT INTO department_has_employee (Department_departmentID, Employee_EmployeeID, Employee_userID, Employee_JobHistory_userID) VALUES (1,1,1,1), (2,2,2,2),(3,3,3,3);

-- employee insert
INSERT INTO employee (employeeID, userID, Department) VALUES (1, 1, 'database'),(2,2, 'research'), (3,3, 'building management');

-- hourly woker insert table
INSERT INTO hourlyworker (EmployeeID, wage, departmentID, hoursWorked) VALUES (1, 16, 2, 100),(2, 35, 1, 600), (3,43,3,20);

-- insert expenses table 
INSERT INTO expenses (departmentID, managerID, Amount) VALUES (1, 1, 400), (2, 2, 500), (3,3,100);

-- holidays table inserts
INSERT INTO holidays (calendarID, UShoidays, otherHolidays) VALUES (1, 1111-11-11, 1111-11-12), (1, 1111-22-22, 1111-22-23),(1,1111-33-13,1111-33-11);

-- jobhistory table inserts
INSERT INTO jobhistory (userID, location, company, jobTitle, inIndustry) VALUES (1, 'Taiwan', 'SFSU', 'SWE', 11-11-11), (2, 'korea', 'samsung', 'dbengineer', 11-11-11), (3, 'LA', 'UCLA', 'intern', 11-11-11);

-- taxearningcodes table inserts
INSERT INTO taxearningcodes (employeeID, income, taxableIncome) VALUES (1, 100000,100000), (2, 20000000, 2000),(3,3000000000,200);

-- manager table inserts
INSERT INTO manager (userID, managerID, name, projectID) VALUES (1, 1, 'ryan', 1), (2, 2, 'bob', 2),(3,3,'mike',3);

-- medicalwithholdisings table inserts
INSERT INTO medicalwithholdings ( employeeID, Amount, medicalWItholdingID) VALUES (1, 100000, 1), (2,2000,2),(3,33333,3);

-- paidtimeoff table inserts
INSERT INTO `paid time off` (calendarID, timeOff, sickTimeOff) VALUES (1, 200, 100), (1,200,100), (1,0,0);

-- payday table inserts
INSERT INTO payday (calendarID, departmentID, employeeID, paid) VALUES (1, 1, 1, 0), (1,2,2,0), (1,3,3,1);

-- paymentmethod inserts
INSERT INTO paymentmethod (userID, PaymentMethod, BankAccountDepo) VALUES (1, 'direct deposit', 11111111111), (2, 'check', 22222222), (3, 'direct deposti', 3333333333);

-- payroll table inserts
INSERT INTO payroll (payrollID, Payday) VALUES (1, 2001-02-11), (2, 2001-02-11), (3, 2001-02-11);

-- performancegoals table inserts
INSERT INTO performancegoals (departmentID, employeeID, projectID, eta) VALUES (1, 1, 1, 2025-01-11), (2, 2, 2, 2025-11-21), (3, 3, 3, 2027-01-11);

-- performancereviews table inserts
INSERT INTO performancereviews (employeeID, review, score) VALUES (1, "sucked",1),(1, "BEST EVER",10),(1, "trash",2);

-- salary worker table inserts
INSERT INTO salaryworker (employeeID, SalaryAmt) VALUES (1, 100000000), (2, 310302013213), (3, 1);

-- taxes table inserts
INSERT INTO taxes (taxesID, employeeID, companyTaxes, taxesVerified) VALUES (1, 1, 10000, 1),(2, 2, 10000, 0),(3, 3, 4440000, 1);

-- timesheet table inserts
INSERT INTO timesheet (employeeID, startHours, endHours, ScheduedTime) VALUES (1, 11-12, 15-50, 11-00), (2, 11-12, 15-50, 11-00), (3, 11-12, 15-50, 11-00);

-- w2 table inserts
INSERT INTO w2 (employeeID, amountEarned, amountWithheld) VALUES (1, 100000, 2000), (2, 3000000000, 200), (3, 40000, 30000);