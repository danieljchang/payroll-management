import database as db
# Your unit tests implementation goes here.
def test():
    # test = []
    value1 = "+-------------+--------------+\n| Employee ID | Hours Worked |\n+-------------+--------------+\n+-------------+--------------+"
    value2 = "+---------------+--------------+------------------------+\n| Employee Name | Project Name | Number of Hours Worked |\n+---------------+--------------+------------------------+\n|    ryan uls   |   database   |         35076          |\n+---------------+--------------+------------------------+"
    value3 = "+-------------+---------------+\n| Employee ID | Employee Name |\n+-------------+---------------+\n|      1      |    ryan uls   |\n+-------------+---------------+"
    value4 = "+---------------+----------------+--------+\n| Employee Name | Expected Goals | Salary |\n+---------------+----------------+--------+\n+---------------+----------------+--------+"
    value5 = "+-------------+---------------+----------------+\n| Employee ID | Employee Name | Current Salary |\n+-------------+---------------+----------------+\n+-------------+---------------+----------------+"
    value6 = "+---------+---------------------+--------------------+\n| Manager | Number of Employees | Number of Projects |\n+---------+---------------------+--------------------+\n+---------+---------------------+--------------------+"
    value7 = "+----------+--------------+---------------------+\n| Employee | Project Name |       Deadline      |\n+----------+--------------+---------------------+\n| ryan uls |   database   | 2023-05-23 20:59:59 |\n+----------+--------------+---------------------+"
    value8 = "+---------------+----------+--------------------+\n| Employee Name |  Salary  | Number Of Projects |\n+---------------+----------+--------------------+\n|  burke titan  | 2000000  |         1          |\n|  josh garcia  | 40000000 |         1          |\n+---------------+----------+--------------------+"
    value9 = "+---------------+--------+\n| Employee Name | Amount |\n+---------------+--------+\n|    ryan uls   | 831.50 |\n+---------------+--------+"
    value10 = "+---------------+--------+\n| Employee Name | Amount |\n+---------------+--------+\n|    ryan uls   | 16.63  |\n|    ryan uls   |  0.00  |\n|    ryan uls   |  0.00  |\n+---------------+--------+"
    value11 = "+---------------+--------+\n| Employee Name | Amount |\n+---------------+--------+\n+---------------+--------+"
    value12 = "+----------+\n| Benefits |\n+----------+\n|   1000   |\n|   1000   |\n+----------+"
    value13 = "+---------------+----------------+\n| Employee Name | Insurance Type |\n+---------------+----------------+\n+---------------+----------------+"
    value14 = "+--------------+--------------+----------------+------------------+\n| Manager Name | Project Name | Initial Budget | Remaining Budget |\n+--------------+--------------+----------------+------------------+\n+--------------+--------------+----------------+------------------+"
    value15 = "+---------------+---------+------------------+-------------------+\n| Employee Name | Company | Time in Industry |     Job Title     |\n+---------------+---------+------------------+-------------------+\n|       1       |  Tesla  |        23        | Software Engineer |\n+---------------+---------+------------------+-------------------+"
    value16 = "+---------------+-----+-------------+-----------+\n| Employee Name | PTO | Project Due | Sick Days |\n+---------------+-----+-------------+-----------+\n+---------------+-----+-------------+-----------+"
    value17 = "+---------------+-----+-------------+-----------+\n| Employee Name | PTO | Project Due | Sick Days |\n+---------------+-----+-------------+-----------+\n+---------------+-----+-------------+-----------+"
    value18= "+------------+------------+\n| Department |   Payday   |\n+------------+------------+\n|    R&D     | 2023-11-11 |\n|    R&D     | 2022-11-11 |\n|    R&D     | 2024-01-01 |\n+------------+------------+"
    value19 = "+---------+\n| Benefit |\n+---------+\n|   1000  |\n+---------+"  
    value20 = "+----+------------------+----------------+\n| ID |  Insurance Type  | Amount Covered |\n+----+------------------+----------------+\n| 1  | health insurance |      2000      |\n| 2  | dental insurance |      2000      |\n+----+------------------+----------------+"
    value21 = "+---------------+\n| Employee Name |\n+---------------+\n|    ryan uls   |\n+---------------+"
    # test.append(value1)
    # test.append(value2)
    # test.append(value3)
    # test.append(value4)
    # test.append(value5)
    # test.append(value6)
    # test.append(value7)
    # test.append(value8)
    # test.append(value9)
    # test.append(value10)
    # test.append(value11)
    # test.append(value12)
    # test.append(value13)
    # test.append(value14)
    # test.append(value15)
    # test.append(value16)
    # test.append(value17)
    # test.append(value18)
    # test.append(value19)
    # test.append(value20)
    # test.append(value21)

    
    print(1)
    response = db.BotResponse("/hours_more 1 1 1 1")
    print(value1 == response.get_response().get_string())
    

    print(2)
    response = db.BotResponse("/project_hours 1")
    print(value2 == response.get_response().get_string())
  
    print(3)
    response = db.BotResponse("/project_team 1")
    print(value3 == response.get_response().get_string())

    print(4)
    response = db.BotResponse("/not_worked")
    print(value4 == response.get_response().get_string())

    print(5)
    response = db.BotResponse("/completed_by 1 100 11-11-2000 12-11-2000")
    print(value5 == response.get_response().get_string())


    print(6)
    response = db.BotResponse("/manager_stats 1 1 1")
    print(value6 == response.get_response().get_string())

    print(7)
    response = db.BotResponse("/soon_due 1 1")
    print(value7 == response.get_response().get_string())


    print(8)
    response = db.BotResponse("/salary_amount_paid 100")
    print(value8 == response.get_response().get_string())

  
    print(9)
    response = db.BotResponse("/wage_amount_paid 1")
    print(value9 == response.get_response().get_string())

    print(10)
    response = db.BotResponse("/past_wages 1 1")
    print(value10 == response.get_response().get_string())

    print(11)
    response = db.BotResponse("/current_wages 1 1 1")
    print(value11 == response.get_response().get_string())

    print(12)
    response = db.BotResponse("/benefits_available")
    print(value12 == response.get_response().get_string())

    print(13)
    response = db.BotResponse("/insurance 1 1")
    print(value13 == response.get_response().get_string())

    print(14)
    response = db.BotResponse("/budget 1")
    print(value14 == response.get_response().get_string())

    print(15)
    response = db.BotResponse("/job_history 1")
    print(value15 == response.get_response().get_string())

    print(16)
    response = db.BotResponse("/sick_days 1 database 1")
    print(value16 == response.get_response().get_string())

    print(17)
    Response = db.BotResponse("/legacy 1 1 1 1 Software Engineer")
    print(value17 == response.get_response().get_string())

    print(18)
    response = db.BotResponse("/payday 1")
    print(value18 == response.get_response().get_string())

    print(19)
    response = db.BotResponse("/benefits_to_user 1")
    print(value19 == response.get_response().get_string())

    print(20)
    response = db.BotResponse("/get_ins")
    print(value20 == response.get_response().get_string())

    print(21)
    response = db.BotResponse("/work_ethic 1 1 2")
    print(value21 == response.get_response().get_string())

  

  
    
    