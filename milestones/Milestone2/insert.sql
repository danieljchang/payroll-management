-- Script name: inserts.sql
-- Author: 		Daniel Chang
-- Purpose: 	insert data to test the integrity of this database system

-- The databased used to insert the data into
USE PayrollManagementDB;
SET FOREIGN_KEY_CHECKS=0;

INSERT INTO user (id, login_time, create_time, username, email, password) VALUES (1, curdate(), curdate(), "test", "email", "passoword"), (2, curdate(), curdate(), "tester", "newemail@agmail", "mypassword"), (3, curdate(), curdate(), "happyness", "happy@ghappy", "happyhappy");

INSERT INTO benefits (amount, employee_id, employee_taxes_id, performance_reviews_id) VALUES (1000, 1,1,1), (1000, 2,2,2), (1000, 3,3,3);

INSERT INTO calendar (id,gregorian,deadlines_id,deadlines_project_id) VALUES (1, 1, 1, 1), (2,0,1,1), (3,1,2,2);

INSERT INTO deadlines (id,deadline,late,project_id) VALUES (1, "2023-05-23 20:59:59", 0, 1), (2, "2023-04-23 23:59:59", 1, 2), (3, "2027-02-23 23:59:59", 0, 3);

INSERT INTO department (id, funding, num_employees, funding_saved, department_name) VALUES (1,1000000,5,10000,"R&D"), (2,200000,10,100000,"architecture"),(3,10,25,10,"databases");

INSERT INTO employee (id, name, major, employee_level, is_wage, last_bonus) VALUES (1, "ryan uls", "CS", 3, 0, "2022-05-23 20:59:59"), (2, "burke titan", "Construction", 3, 1, "2000-05-23 20:59:59"),(3, "josh garcia", "Electrical Engineer", 3, 0, "2022-05-23 20:59:59");

INSERT INTO employee_has_department (employee_id,department_id) VALUES (1, 1), (2,2), (3,3);

INSERT INTO employee_has_insurance (employee_id, insurance_id) VALUES (1,1), (2,2),(3,3);

INSERT INTO employee_has_manager (employee_id, manager_id) VALUES (1,1),(2,2),(3,3);

INSERT INTO employee_has_user (employee_id, user_id) VALUES (1,1),(2,2),(3,3);

INSERT INTO expenses (id,amount,spent_on) VALUES (1, 300, "chairs"), (2, 400,"gas"), (3, 500, "office supplies");

INSERT INTO expenses_has_manager (expenses_id,manager_id) VALUES (1,1),(2,2),(3,3);

INSERT INTO holidays (id, holiday_name, day_off_in_us, day_off_other, calendar_id) VALUES (1,"christmas",1,1,1), (2, "Juneteenth", 1,0,1), (3, "Veterans Day", 1,0,1);

INSERT INTO hourly_worker (id,wage,employee_id) VALUES (1,16.63, 1), (2,0,1),(3,0,1);

INSERT INTO insurance (id, insurance_type, amount_provided) VALUES (1,"health insurance", 2000),(2, "dental insurance", 2000), (3, "life insurance", 4000);

INSERT INTO job_history (company, time_in_industry, job_title, location, employee_id) VALUES ("Tesla", "2000-04-23 23:59:59", "Software Engineer", "Palo Alto", 1),("Google", "1989-03-13 23:59:59", "Electrical Engineer", "Mountain View", 2), ("Genentech", "2005-04-23 23:59:59", "Bioinformatics Researcher", "San Francisco", 3);

INSERT INTO manager (id, name, manager_level) VALUES (1, "mei gou", 4), (2, "why me", 5), (3, "iam tired", 4);

INSERT INTO manager_has_department (manager_id, department_id) VALUES (1,1),(2,2),(3,3);

INSERT INTO manager_has_manager (manager_id, manager_id1) VALUES (1,1),(2,2),(3,3);

INSERT INTO medical_withholdings (amount, time_withheld, insurance_id) VALUES (1000, "2000-04-23 23:59:59",1),(4000,"2000-04-23 23:59:59",2), (600, "2000-04-23 23:59:59", 3);

INSERT INTO paid_time_off (time_off, time_left, sick_leave, employee_id, employee_taxes_id) VALUES (10, 20, 10, 1, 1),(20, 10, 4, 2,2),(5,25,15, 3,3);

INSERT INTO payday (day_to_pay,employee_paid, calendar_id) VALUES ("2023-11-11", 0, 1), ("2022-11-11",1,1),("2024-01-01",0,1);

INSERT INTO payment_method (other, direct_deposit, checks, employee_id) VALUES ("none", 1, 1,1),("cash", 0,0,2), ("none",0,1,3);

INSERT INTO payroll (id, employee_id) VALUES (1,1), (2,2), (3,3);

INSERT INTO performance_goals (start, eta, department_id) VALUES ("2020-11-11", "2023-11-11", 1), ("2022-11-11", "2024-07-34", 2), ("2021-11-11", "2026-03-15",3);

INSERT INTO performance_reviews (id, review,rating) VALUES (1, "REALLY GOOD WORK PERFECT", 4), (2, "really hard worker", 5), (3, "terrible",1);

INSERT INTO performance_reviews_has_employee (performance_reviews_id, employee_id) VALUES (1,1),(2,2), (3,3);

INSERT INTO project (id, name, department_id) VALUES (1, "database build", 1), (2, "filesystem build", 2),(3, "research on AI", 3);

INSERT INTO salary_worker (id, salary, employee_id) VALUES (1, 0, 1), (2, 2000000,2), (3, 40000000, 3);

INSERT INTO taxes (id, amount, paid, employee_id) VALUES (1, 200, 1,1), (2, 30000, 1,2), (3, 300000,0,3);

INSERT INTO time_sheet (id, time_start, time_end, expected_num_hrs_worked, hourly_worker_id, hourly_worker_employee_id, calendar_id, calendar_deadlines_id, calendar_deadlines_project_id, employee_id) VALUES (1, "2000-04-23 11:59:59", "2004-04-23 23:59:59", 12,1,1,1,1,1,1), (2, "2000-04-23 23:59:59", "2004-045-23 23:59:59", 24,2,2,2,2,2,2), (3, "2000-04-23 11:59:59", "2004-04-23 23:59:59", 36,3,3,3,3,3,3);

INSERT INTO time_stayed (start_date, time_on_project, employee_id, calendar_id, calendar_deadlines_id, calendar_deadlines_project_id) VALUES ("2000-04-23 23:59:59", "2003-06-23 23:59:59", 1,1,1,1),("2023-04-23 23:59:59", "20023-05-23 23:59:59", 2,2,2,2), ( "2005-04-23 23:59:59", "2007-06-23 23:59:59", 3,3,3,3);

INSERT INTO time_worked (amt_time, employee_id) VALUES (50, 1), (25,2),(345,3);

INSERT INTO w2 (amount_earned, amount_withheld, taxes_id) VALUES (10000,2000,1),(20000,300,2),(300505,3944,3);