# Your code to model your objects to handle the data from your database goes here.
from database import Database


class Employee:

  def __init__(self, employee_id):
    self.database = Database()
    self.id = employee_id
    self.name = None
    self.company = None
    self.load()

  def load(self):
    query = """SELECT employee.name, employee.major, employee.employee_level
                    FROM Employee
                    JOIN Person ON employee.id = person.id
                    WHERE Person.identifier = %s;"""
    arguments = (self.id)
    data = self.database.select(query, arguments)
    data = data[0]
    self.name = data['name']
    self.company = data['Company.name']


employee = Employee(1)
