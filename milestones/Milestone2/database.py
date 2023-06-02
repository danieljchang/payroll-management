# Handles all the methods interacting with the database that will populate the objects modeled for this application.

import os
import pymysql.cursors
from prettytable import PrettyTable

# note that your remote host where your database is hosted 
# must support user permissions to run stored triggers, procedures and functions.
db_host = os.environ["DB_HOST"] 
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]

def connect():
    """
    This method creates a connection with your database 
    IMPORTANT: all the environment variables must be set correctly 
               before attempting to run this method. Otherwise, it
               will trown an error message stating that the attempt
               to connect to your database failed.
    """
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
      
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here Must comment out while being graded.
def select(self, query, arguments=None):
  conn = self.connect()
  cursor = conn.cursor()
  cursor.execute(query,arguments)
  data = cursor.fetchall()
  conn.close()
  return data

def insert(self, query, arguments):
  try:
    conn = self.connect()
    cursor = conn.cursor()
    cursor.execute(query,arguments)
    conn.close()
  except:
    print("The query failed")

class BotResponse:

    def __init__(self, msg):
        self.msg = msg

    def get_response(self):
        response = None
        data = self.msg.split()
        command = data[0]
        # arguments = data[1]
        error = []
        # example given from professor.
        # if "/get-employee-name" in command:
        #     employee_id = int(arguments)
        #     employee = Employee(employee_id)
        #     response = employee.name
        
        if "/hours_more" in command:
            if not data[1]:
                error.append('missing sick days input')
            elif not data[2]:
                error.append('missing start date')
            elif not data[3]:
                error.append('missing end date')
            else:
                sickDays = int(data[1])
                startDate = int(data[2])
                endDate = int(data[3])
                response = hoursWorkedf(sickDays, startDate, endDate)
        elif "/project_hours" in command:
            if not data[1]:
                error.append('missing project id')
            else:
                project_id = int(data[1])
                response = projectHours(project_id)
        elif "/project_team" in command:
            if not data[1]:
                error.append('missing the project id')
            else:
                project_id = int(data[1])
                response = projectTeam(project_id)
        elif "/not_worked" in command:
            response = notWork()
                
        elif "/completed_by" in command:
            if not data[1]:
                error.append('missing the amount paid')
            elif not data[2]:
                error.append('missing the start time')
            elif not data[3]:
                error.append('missing the end time')
            else:
                paid = int(data[1])
                start = data[2]
                end = data[3]
                response = completedBy(paid,start,end)
        elif "/manager_stats" in command:
            if not data[1]:
                error.append('missing the minimum number of employees')
            elif not data[2]:
                error.append('missing the number of projects completed under the manager')
            elif not data[3]:
                error.append('missing the department id')
            else:
                minEmployees = int(data[1])
                numProjects = int(data[2])
                department_id = int(data[3])
                response = managerStats(minEmployees, numProjects, department_id)
        elif "/soon_due" in command:
            if not data[1]:
                error.append('missing department id ')
            elif not data[2]:
                error.append('missing the number of projects that want to be seen')
            else:
                department_id = int(data[1])
                numProjects = int(data[2])
                response = soonDue(department_id, numProjects)
        elif "/salary_amount_paid" in command:
            if not data[1]:
                error.append('missing the salary')
            else:
                salary = int(data[1])
                response = salaryAmountPaid(salary)
        elif "/wage_amount_paid" in command:
            if not data[1]:
                error.append('missing input for the employee id')
            else:
                employee_id = int(data[1])
                response = wageAmountPaid(employee_id)
        elif "/past_wages" in command:
            if not data[1]:
                error.append('missing input for the department id')
            elif not data[2]:
                error.append('missing the input for the years stayed')
            else:
                department_id = int(data[1])
                yearsStayed = int(data[2])
                response = pastWages(department_id, yearsStayed)
        elif "/current_wages" in command:
            if not data[1]:
                error.append('missing input for the department id')
            elif not data[2]:
                error.append('missing the employee id input')
            elif not data[3]:
                error.append('missing the manager id')
            else:
                department_id = int(data[1])
                employee_id = int(data[2])
                manager_id = int(data[3])
                response = currentWages(department_id,employee_id,manager_id)
        elif "/benefits_available" in command:
            response = benefitsAvailable()
        elif "/insurance" in command:
            if not data[1]:
                error.append('missing insurance type')
            elif not data[2]:
                error.append('missing the input for the number of years stayed at the company')
            else:
                type = data[1]
                yearsStayed = int(data[2])
                response = insurance(type, yearsStayed)
            
        elif "/budget" in command:
            if not data[1]:
                error.append('missing the input for the project name')
            else:
                project = data[1]
                response = budget(project)
        elif "/job_history" in command:
            if not data[1]:
                error.append('missing the input for the employee id')
            else:  
                employee_id = int(data[1])
                response = jobHistory(employee_id)
        elif "/sick_days" in command:
            if not data[1]:
                error.append('missing the input for the paid time off that has been taken')
            elif not data[2]:
                error.append('missing the project name')
            else: 
                pto = int(data[1])
                projectName = data[2]
                response = sickDaysF(pto, projectName)
        elif "/legacy" in command:
            if not data[1]:
                error.append('missing the input for the years worked')
            elif not data[2]:
                error.append('missing the input for the department id')
            elif not data[3]:
                error.append('missing the number of projects')
            elif not data[4]: 
                error.append('missing the field the employee has worked in')
            else:
                yearsWorked = int(data[1])
                department_id = int(data[2])
                numProjects = int(data[3])
                field = int(data[4])
                response = legacy(yearsWorked,department_id, numProjects, field)
        elif "/payday" in command:
            if not data[1]:
                error.append('missing the department id')
            else:
                department_id = int(data[1])
                response = whenPayday(department_id)
        elif "/benefits_to_user" in command:
            if not data[1]:
                error.append('missing the time since the last benefit')
            else:
                timeSince = int(data[1])
                response = benefitsToUser(timeSince)
        elif "/get_ins" in command:
            response = getAllInsurance()
        elif "/work_ethic" in command:
            if not data[1]:
                error.append('missing the number of hours worked')
            elif not data[2]:
                error.append('missing the wage of the individual')
            elif not data[3]:
                error.append('missing the rating of the individual')
            else:
                hoursWorked = int(data[1])
                wage = int(data[2])
                rating = int(data[3])
                response = workEthic(hoursWorked,wage,rating)
        if len(error) > 0:
            return error
        return response
    
    
    # Done
def hoursWorkedf(sickDays, startDate, endDate):
    con = connect()
    rows = []
    headers = ["Employee ID", "Hours Worked"]

    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id AS "Employee ID", COUNT(tw.amt_time) AS "Hours Worked"
                FROM employee e
                JOIN time_worked tw ON e.id = tw.employee_id
                JOIN paid_time_off pto ON e.id = pto.employee_id
                WHERE TIMESTAMPDIFF(DAY, pto.time_left, pto.time_off) BETWEEN %s AND %s
                AND pto.sick_leave > %s
                GROUP BY e.id
        """
    variable = (startDate, endDate, sickDays)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee ID'])
            row.append(item['Hours Worked'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# done
def projectHours(project_id):
    con = connect()
    rows = []
    headers = ["Employee Name", "Project Name", "Number of Hours Worked"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT employee.id, employee.name AS "Employee Name", project.id, project.name AS "Project Name", TIMESTAMPDIFF(HOUR, time_sheet.time_start, time_sheet.time_end) AS "Number of Hours Worked"
                    FROM employee
                    JOIN time_sheet ON employee.id = time_sheet.id
                    JOIN project ON time_sheet.id = project.id
                    WHERE project.id = %s
                    GROUP BY employee.id, project.id
        """
    variable = (project_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Project Name'])
            row.append(item['Number of Hours Worked'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# done
def projectTeam(department_id):
    con = connect()
    rows = []
    headers = ["Employee ID", "Employee Name"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id AS "Employee ID", e.name AS "Employee Name", ehd.department_id
                    FROM employee e
                    JOIN employee_has_department ehd ON ehd.department_id = e.id
                    WHERE ehd.department_id = %s;
        """
    variable = (department_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee ID'])
            row.append(item['Employee Name'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

def notWork():
    con = connect()
    rows = []
    headers = ["Employee Name", "Expected Goals", "Salary"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT employee.name AS "Employee Name", ts.expected_num_hrs_worked AS "Expected Goals", sw.salary AS "Salary"
                    FROM employee 
                    JOIN salary_worker sw ON sw.employee_id = employee.id
                    JOIN time_worked tw ON tw.employee_id = employee.id
                    JOIN time_sheet ts ON ts.employee_id = employee.id
                    WHERE tw.amt_time < ts.expected_num_hrs_worked;
        """
    cursor.execute(query)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Expected Goals'])
            row.append(item['Salary'])
            rows.append(row)
    output = format_data(headers, rows)

    return output
# Done  
def completedBy(salary, start, end):
    con = connect()
    rows = []
    headers = ["Employee ID", "Employee Name", "Current Salary"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT employee.id as "Employee ID", employee.name AS "Employee Name", sw.salary AS "Current Salary"
                        FROM employee
                        JOIN salary_worker sw ON sw.employee_id = employee.id
                        JOIN time_sheet ts ON ts.employee_id = employee.id
                        JOIN calendar cal ON cal.id = ts.calendar_id
                        JOIN deadlines dl ON dl.id = cal.id
                        WHERE dl.deadline BETWEEN %s AND %s 
                        AND sw.salary > %s;
        """
    variable = (start, end, salary)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee ID'])
            row.append(item['Employee Name'])
            row.append(item['Expected'])
            row.append(item['Current Salary'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# Done
def managerStats(minEmployees, numProjects, department_id):
    con = connect()
    rows = []
    headers = ["Manager", "Number of Employees","Number of Projects"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT manager.id, manager.name AS "Manager", COUNT(employee.id) AS "Number of Employees", COUNT(DISTINCT project.id) AS "Number of Projects"
                    FROM manager
                    INNER JOIN employee ON manager.id = employee.id
                    INNER JOIN project ON employee.id = project.id
                    WHERE "Number of Employees" = %s AND project.id = %s
                    GROUP BY manager.id, manager.name
                    HAVING "Number of Projects" = %s;
        """
    variable = (minEmployees, department_id, numProjects)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Manager'])
            row.append(item['Number of Employees'])
            row.append(item['Number of Projects'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# done
def soonDue(department_id, numProjects):
    con = connect()
    rows = []
    headers = ["Employee", "Project Name","Deadline"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name AS "Employee", p.id, p.name AS "Project Name", dl.deadline AS "Deadline"
                FROM employee e
                INNER JOIN project p ON e.id = p.id
                JOIN time_sheet ts ON ts.employee_id = e.id
				JOIN calendar cal ON cal.id = ts.calendar_id
				JOIN deadlines dl ON dl.id = cal.id
                AND dl.deadline = (
                    SELECT MIN(deadline)
                    FROM project
                    WHERE p.id = %s) 
        """
    variable = (department_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee'])
            row.append(item['Project Name'])
            row.append(item['Deadline'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

# done
def salaryAmountPaid(salary):
    con = connect()
    rows = []
    headers = ["Employee Name", "Salary","Number Of Projects"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT employee.id, employee.name AS "Employee Name", sw.salary AS "Salary", department.department_name, COUNT(project.id) AS "Number of Projects"
                    FROM employee
                    JOIN salary_worker sw ON sw.employee_id = employee.id
                    JOIN department ON sw.id = department.id
                    LEFT JOIN project ON employee.id = project.id
                    WHERE sw.salary > %s
                    GROUP BY employee.id, employee.name, sw.salary, department.department_name;
        """
    variable = (salary)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Salary'])
            row.append(item['Number of Projects'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# done
def wageAmountPaid(employee_id):
    con = connect()
    rows = []
    headers = ["Employee Name", "Amount"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT employee.id, employee.name AS "Employee Name", (time_worked.amt_time * hourly_worker.wage) AS "Amount"
                    FROM employee 
                    JOIN hourly_worker ON hourly_worker.employee_id = employee.id
                    JOIN time_worked ON time_worked.employee_id = hourly_worker.employee_id
                    WHERE hourly_worker.id = %s;
        """
    variable = (employee_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Amount'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# done
def pastWages(department_id, yearsStayed):
    con = connect()
    rows = []
    headers = ["Employee Name", "Amount"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name AS "Employee Name", w.wage AS "Amount"
                    FROM employee e
                    INNER JOIN hourly_worker w ON e.id = w.employee_id
                    JOIN employee_has_department ehd ON ehd.department_id = e.id
                    JOIN time_stayed ts ON ts.employee_id = e.id
                    WHERE ehd.department_id = %s
                    AND DATEDIFF(CURDATE(), ts.start_date) >= %s * 365;
        """
    variable = (department_id, yearsStayed)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Amount'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# Done
def currentWages(department_id,employee_id,manager_id):
    con = connect()
    rows = []
    headers = ["Employee Name", "Amount"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name AS "Employee Name", w.wage AS "Amount"
                    FROM employee e
                    INNER JOIN hourly_worker w ON e.id = w.employee_id
					JOIN employee_has_department ehd ON ehd.department_id = e.id
                    JOIN manager m ON m.id = e.id
                    WHERE ehd.department_id = %s
                    AND e.employee_level <= (SELECT id FROM employee WHERE employee.id = %s)
                    AND m.id = %s;
        """
    variable = (department_id,employee_id,manager_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Amount'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# Done
def benefitsAvailable():
    con = connect()
    rows = []
    headers =  ["Benefits"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name, b.amount AS "Benefits"
                    FROM employee e
                    JOIN performance_reviews_has_employee pre ON pre.employee_id = e.id
                    JOIN benefits b ON b.employee_id = e.id
                    INNER JOIN performance_reviews pr ON e.id = pr.id
                    WHERE pr.rating >= 4
        """
        
    cursor.execute(query)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Benefits'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

# Done
def legacy(yearsWorked,department_id, numProjects, field):
    con = connect()
    rows = []
    headers =  ["Employee Name"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT m.id, m.name, e.id, e.name AS "Employee name"
                        FROM manager m
                        INNER JOIN employee e ON m.id = e.id
                        INNER JOIN project p ON e.id = p.id
						JOIN employee_has_department ehd ON ehd.department_id = e.id
                        JOIN job_history jh ON jh.employee_id = e.id
                        WHERE ehd.department_id = %s
                            AND jh.time_in_industry >= %s
                            AND jh.job_title = %s
                        GROUP BY m.id, m.name, e.id, e.name
                        HAVING COUNT(DISTINCT p.id) >= %s;
        """
        variable = (department_id, yearsWorked, field, numProjects)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            rows.append(row)
    output = format_data(headers, rows)
    return output


# Done
def insurance(type, yearsStayed): 
    con = connect()
    rows = []
    headers =  ["Employee Name", "Insurance Type"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name AS "Employee Name", i.insurance_type AS "Insurance Type"
                    FROM employee e
                    JOIN time_stayed ts ON e.id = ts.employee_id
                    JOIN insurance i
                    WHERE i.insurance_type = %s
                    AND ts.start_date >= %s;
        """
        variable = (type, yearsStayed)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Amount'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

# Done
def budget(project):
    con = connect()
    rows = []
    headers =  ["Manager Name", "Project Name", "Initial Budget", "Remaining Budget"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT m.id, m.name AS "Manager Name", p.id, p.name AS "Project Name", dep.funding AS "Initial Budget", dep.funding - COALESCE(SUM(ex.amount), 0) AS "Remaining Budget"
                    FROM manager m
                    INNER JOIN employee e ON m.id = e.id
                    INNER JOIN project p ON m.id = p.id
                    JOIN employee_has_department ehd ON ehd.department_id = m.id
                    JOIN department dep ON dep.id = ehd.department_id
                    LEFT JOIN expenses ex ON p.id = ex.id
                    WHERE p.name = %s
                    GROUP BY m.id, m.name, p.id, p.name, dep.funding;

        """
        variable = (project)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Manager Name'])
            row.append(item['Project Name'])
            row.append(item['Initial Budget'])
            row.append(item['Remaining Budget'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

# Done
def workEthic(hoursWorked,wage,rating): 
    con = connect()
    rows = []
    headers = ["Employee Name"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id, e.name as "Employee Name"
                    FROM employee e
                    INNER JOIN hourly_worker hw ON e.id = hw.id
                    JOIN performance_reviews_has_employee re ON re.employee_id = e.id 
					JOIN performance_reviews pr ON re.performance_reviews_id = pr.id
                    JOIN time_sheet ts ON ts.employee_id = e.id
                    WHERE TIMESTAMPDIFF(HOUR, ts.time_start,time_end) > %s
                    AND hw.wage > %s
                    AND pr.rating > %s;
        """
    variable = (hoursWorked,wage,rating)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            rows.append(row)
    output = format_data(headers, rows)
    return output
# Done
def whenPayday(department_id):
    con = connect()
    rows = []
    headers = ["Department", "Payday"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT d.id, d.department_name AS "Department", pd.day_to_pay AS "Payday"
                    FROM department d
                    JOIN  calendar cal ON cal.id = 1
                    JOIN payday pd ON pd.calendar_id = cal.id
                    WHERE d.id = %s;
        """
    variable = (department_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Department'])
            row.append(item['Payday']) 
            rows.append(row)
    output = format_data(headers, rows)
    return output

# Done
def benefitsToUser(timeSince): 
    con = connect()
    rows = []
    headers = ["Benefit"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT b.employee_id, b.amount AS "Benefit"
                    FROM benefits b
                    INNER JOIN employee e ON b.employee_id = e.id
                    JOIN performance_reviews pr ON pr.id = e.id
					WHERE TIMESTAMPDIFF(YEAR, e.last_bonus, CURDATE())  >= %s
                    AND pr.rating > 3
					GROUP BY b.employee_id, b.amount;
        """
    variable = (timeSince)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Benefit'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

# Done
def jobHistory(employee_id):
    con = connect()
    rows = []
    headers = ["Employee Name", "Company", "Time in Industry", "Job Title"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT e.id AS "Employee Name", jh.company AS "Company", TIMESTAMPDIFF(YEAR, jh.time_in_industry, CURDATE()) AS "Time in Industry", jh.job_title AS "Job Title"
                    FROM employee e
                    JOIN job_history jh ON jh.employee_id = e.id
                    WHERE e.id = %s
        """
    variable = (employee_id)
    cursor.execute(query, variable)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['Company'])
            row.append(item['Time in Industry'])
            row.append(item['Job Title'])

            rows.append(row)
    output = format_data(headers, rows)
    return output
# Done
def getAllInsurance():
    con = connect()
    rows = []
    headers = ["ID", "Insurance Type", "Amount Covered"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """SELECT i.id as "ID", i.insurance_type AS "Insurance Type", i.amount_provided AS "Amount Covered"
                    FROM insurance i
                    JOIN employee_has_insurance ehi ON i.id = ehi.insurance_id
                    JOIN employee e ON ehi.employee_id = e.id
                    JOIN performance_reviews_has_employee pre ON pre.employee_id = e.id
                    JOIN performance_reviews pr ON pr.id = e.id 
                    WHERE pr.rating > 3
                    ORDER BY i.id, i.insurance_type, i.amount_provided
        """
    cursor.execute(query)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['ID'])
            row.append(item['Insurance Type'])
            row.append(item['Amount Covered'])
            rows.append(row)
    output = format_data(headers, rows)
    return output

def sickDaysF(pto, projectName):
    con = connect()
    rows = []
    headers = ["Employee Name", "PTO", "Project Due", "Sick Days"]
    if con:
        # connection alive
        cursor = con.cursor()
        query = """
        SELECT e.id, e.name AS "Employee Name", pto.time_off, dl.deadline AS "Project Deadline", pto.sick_leave AS "Sick Days"
	FROM employee e
    JOIN paid_time_off pto ON pto.employee_id = e.id 
    JOIN employee_has_department ehd ON ehd.department_id = e.id
    JOIN department d ON d.id = ehd.department_id
    JOIN project p ON p.department_id = d.id
    JOIN deadlines dl ON dl.project_id = p.id
    WHERE pto.time_off < %s
    AND p.name = %s
        """
        variables = (pto, projectName)
    cursor.execute(query, variables)
    data = cursor.fetchall()
    if data:
        for item in data:
            row = []
            row.append(item['Employee Name'])
            row.append(item['PTO'])
            row.append(item['Project Due'])
            row.append(item['Sick Days'])
            rows.append(row)
    output = format_data(headers, rows)
    return output


def format_data(headers, rows):
    table = PrettyTable()
    table.field_names = headers
    for row in rows:
        table.add_row(row)
    return table