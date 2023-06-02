-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PayrollManagementDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PayrollManagementDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PayrollManagementDB` DEFAULT CHARACTER SET utf8 ;
USE `PayrollManagementDB` ;

-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`account` (
  `userID` INT NOT NULL,
  `accountID` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`, `accountID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC) VISIBLE,
  UNIQUE INDEX `accountID_UNIQUE` (`accountID` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `account_userID` INT NOT NULL,
  `account_accountID` INT NOT NULL,
  PRIMARY KEY (`userID`, `account_userID`, `account_accountID`),
  UNIQUE INDEX `idUser_UNIQUE` (`userID` ASC) VISIBLE,
  INDEX `fk_User_account1_idx` (`account_userID` ASC, `account_accountID` ASC) VISIBLE,
  CONSTRAINT `fk_User_account1`
    FOREIGN KEY (`account_userID` , `account_accountID`)
    REFERENCES `PayrollManagementDB`.`account` (`userID` , `accountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`JobHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`JobHistory` (
  `userID` INT NOT NULL,
  `location` VARCHAR(45) NULL,
  `company` VARCHAR(45) NULL,
  `jobTitle` VARCHAR(45) NULL,
  `inIndustry` TIME NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Time Sheet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Time Sheet` (
  `employeeID` INT NOT NULL,
  `startHours` TIME NULL,
  `endHours` TIME NULL,
  `ScheduedTime` TIMESTAMP(3) NULL,
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Employee` (
  `employeeID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  `Department` VARCHAR(45) NULL,
  `User_userID` INT NOT NULL,
  `JobHistory_userID` INT NOT NULL,
  `Time Sheet_employeeID` INT NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `fk_Employee_User_idx` (`User_userID` ASC) VISIBLE,
  INDEX `fk_Employee_JobHistory1_idx` (`JobHistory_userID` ASC) VISIBLE,
  INDEX `fk_Employee_Time Sheet1_idx` (`Time Sheet_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_User`
    FOREIGN KEY (`User_userID`)
    REFERENCES `PayrollManagementDB`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_JobHistory1`
    FOREIGN KEY (`JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`JobHistory` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_TimeSheet1`
    FOREIGN KEY (`Time Sheet_employeeID`)
    REFERENCES `PayrollManagementDB`.`Time Sheet` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`PaymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`PaymentMethod` (
  `userID` INT NOT NULL,
  `PaymentMethod` VARCHAR(45) NULL DEFAULT 'Check',
  `BankAccountDepo` INT NOT NULL,
  `PaymentMethodcol` VARCHAR(45) NULL,
  `Employee_EmployeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  UNIQUE INDEX `idUser_UNIQUE` (`userID` ASC) VISIBLE,
  PRIMARY KEY (`BankAccountDepo`, `userID`, `Employee_EmployeeID`, `Employee_userID`),
  UNIQUE INDEX `AccountID_UNIQUE` (`BankAccountDepo` ASC) VISIBLE,
  INDEX `fk_PaymentMethod_Employee1_idx` (`Employee_EmployeeID` ASC, `Employee_userID` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentMethod_Employee1`
    FOREIGN KEY (`Employee_EmployeeID` , `Employee_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Expenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Expenses` (
  `departmentID` VARCHAR(45) NOT NULL,
  `managerID` VARCHAR(45) NOT NULL,
  `Amount` INT ZEROFILL NULL,
  PRIMARY KEY (`departmentID`, `managerID`),
  UNIQUE INDEX `DepartmentID_UNIQUE` (`departmentID` ASC) VISIBLE,
  UNIQUE INDEX `ManagerID_UNIQUE` (`managerID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`TimeWorked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`TimeWorked` (
  `employeeID` INT NOT NULL,
  `amt` INT ZEROFILL NULL,
  `Employee_employeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_JobHistory_userID` INT NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `fk_TimeWorked_Employee1_idx` (`Employee_employeeID` ASC, `Employee_userID` ASC, `Employee_JobHistory_userID` ASC) VISIBLE,
  CONSTRAINT `fk_TimeWorked_Employee1`
    FOREIGN KEY (`Employee_employeeID` , `Employee_userID` , `Employee_JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID` , `JobHistory_userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Calendar` (
  `calendarID` INT NOT NULL,
  `date` DATETIME NULL,
  `TimeSheet_employeeID` INT NOT NULL,
  PRIMARY KEY (`calendarID`),
  INDEX `fk_Calendar_TimeSheet1_idx` (`TimeSheet_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Calendar_TimeSheet1`
    FOREIGN KEY (`TimeSheet_employeeID`)
    REFERENCES `PayrollManagementDB`.`Time Sheet` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Time` (
  `timeID` INT NOT NULL AUTO_INCREMENT,
  `timezone` VARCHAR(45) NOT NULL DEFAULT 'UTC',
  `Calendar_calendarID` INT NOT NULL,
  PRIMARY KEY (`timeID`, `Calendar_calendarID`),
  UNIQUE INDEX `timeID_UNIQUE` (`timeID` ASC) VISIBLE,
  INDEX `fk_Time_Calendar1_idx` (`Calendar_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_Time_Calendar1`
    FOREIGN KEY (`Calendar_calendarID`)
    REFERENCES `PayrollManagementDB`.`Calendar` (`calendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Manager` (
  `userID` INT NOT NULL,
  `managerID` VARCHAR(45) NULL,
  `name` VARCHAR(45) NOT NULL,
  `projectID` INT NOT NULL,
  `Employee_EmployeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `User_userID` INT NOT NULL,
  `User_account_userID` INT NOT NULL,
  `User_account_accountID` INT NOT NULL,
  PRIMARY KEY (`userID`),
  INDEX `fk_Manager_Employee1_idx` (`Employee_EmployeeID` ASC, `Employee_userID` ASC) VISIBLE,
  INDEX `fk_Manager_User1_idx` (`User_userID` ASC, `User_account_userID` ASC, `User_account_accountID` ASC) VISIBLE,
  CONSTRAINT `fk_Manager_Employee1`
    FOREIGN KEY (`Employee_EmployeeID` , `Employee_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manager_User1`
    FOREIGN KEY (`User_userID` , `User_account_userID` , `User_account_accountID`)
    REFERENCES `PayrollManagementDB`.`User` (`userID` , `account_userID` , `account_accountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Department` (
  `departmentID` INT NOT NULL,
  `managerID` INT NOT NULL,
  `projectID` INT NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `timeSpent` INT ZEROFILL NULL,
  `funding` INT ZEROFILL NULL,
  `Expenses_departmentID` VARCHAR(45) NOT NULL,
  `Expenses_managerID` VARCHAR(45) NOT NULL,
  `Manager_userID` INT NOT NULL,
  PRIMARY KEY (`departmentID`),
  UNIQUE INDEX `ManagerID_UNIQUE` (`managerID` ASC) VISIBLE,
  UNIQUE INDEX `ProjectID_UNIQUE` (`projectID` ASC) VISIBLE,
  INDEX `fk_Department_Expenses1_idx` (`Expenses_departmentID` ASC, `Expenses_managerID` ASC) VISIBLE,
  INDEX `fk_Department_Manager1_idx` (`Manager_userID` ASC) VISIBLE,
  UNIQUE INDEX `department_UNIQUE` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_Department_Expenses1`
    FOREIGN KEY (`Expenses_departmentID` , `Expenses_managerID`)
    REFERENCES `PayrollManagementDB`.`Expenses` (`departmentID` , `managerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Department_Manager1`
    FOREIGN KEY (`Manager_userID`)
    REFERENCES `PayrollManagementDB`.`Manager` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`PerformanceGoals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`PerformanceGoals` (
  `departmentID` INT NOT NULL,
  `employeeID` INT NOT NULL,
  `projectID` INT NOT NULL,
  `eta` DATE NULL,
  `Department_departmentID` INT NOT NULL,
  PRIMARY KEY (`departmentID`, `employeeID`, `projectID`),
  INDEX `fk_PerformanceGoals_Department1_idx` (`Department_departmentID` ASC) VISIBLE,
  CONSTRAINT `fk_PerformanceGoals_Department1`
    FOREIGN KEY (`Department_departmentID`)
    REFERENCES `PayrollManagementDB`.`Department` (`departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Benefits` (
  `employeeID` INT NOT NULL,
  `benefitsAmt` INT ZEROFILL NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_JobHistory_userID` INT NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `fk_Benefits_Employee1_idx` (`Employee_userID` ASC, `Employee_JobHistory_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Benefits_Employee1`
    FOREIGN KEY (`Employee_userID` , `Employee_JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`userID` , `JobHistory_userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`medicalWithholdings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`medicalWithholdings` (
  `employeeID` INT NOT NULL,
  `Amount` INT ZEROFILL NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_JobHistory_userID` INT NOT NULL,
  UNIQUE INDEX `EmployeeID_UNIQUE` (`employeeID` ASC) VISIBLE,
  INDEX `fk_MedicalWithholdings_Employee1_idx` (`Employee_userID` ASC, `Employee_JobHistory_userID` ASC) VISIBLE,
  CONSTRAINT `fk_MedicalWithholdings_Employee1`
    FOREIGN KEY (`Employee_userID` , `Employee_JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`userID` , `JobHistory_userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Payroll` (
  `payrollID` INT NOT NULL,
  `Payday` DATE NULL,
  `Employee_employeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_JobHistory_userID` INT NOT NULL,
  PRIMARY KEY (`payrollID`),
  INDEX `fk_Payroll_Employee1_idx` (`Employee_employeeID` ASC, `Employee_userID` ASC, `Employee_JobHistory_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Payroll_Employee1`
    FOREIGN KEY (`Employee_employeeID` , `Employee_userID` , `Employee_JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID` , `JobHistory_userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`PerformanceReviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`PerformanceReviews` (
  `employeeID` INT NOT NULL,
  `review` VARCHAR(128) NULL,
  `score` INT ZEROFILL NULL,
  `Employee_employeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_departmentID` INT NOT NULL,
  `Employee_TimeStayed_employeeID` INT NOT NULL,
  `Employee_TimeStayed_calendarID` INT NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `fk_PerformanceReviews_Employee1_idx` (`Employee_employeeID` ASC, `Employee_userID` ASC, `Employee_departmentID` ASC, `Employee_TimeStayed_employeeID` ASC, `Employee_TimeStayed_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_PerformanceReviews_Employee1`
    FOREIGN KEY (`Employee_employeeID` , `Employee_userID` , `Employee_departmentID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID` , `departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Taxes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Taxes` (
  `taxesID` INT NOT NULL,
  `employeeID` INT NOT NULL,
  `companyTaxes` INT ZEROFILL NULL,
  `taxesVerified` TINYINT NULL DEFAULT 0,
  `Employee_employeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_JobHistory_userID` INT NOT NULL,
  PRIMARY KEY (`taxesID`, `employeeID`),
  INDEX `fk_Taxes_Employee1_idx` (`Employee_employeeID` ASC, `Employee_userID` ASC, `Employee_JobHistory_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Taxes_Employee1`
    FOREIGN KEY (`Employee_employeeID` , `Employee_userID` , `Employee_JobHistory_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID` , `JobHistory_userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`TaxEarningCodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`TaxEarningCodes` (
  `employeeID` INT NOT NULL,
  `income` INT NULL,
  `taxableIncome` INT NULL,
  `TaxEarningCodescol` VARCHAR(45) NULL,
  `Taxes_taxesID` INT NOT NULL,
  `Taxes_employeeID` INT NOT NULL,
  PRIMARY KEY (`employeeID`),
  INDEX `fk_TaxEarningCodes_Taxes1_idx` (`Taxes_taxesID` ASC, `Taxes_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_TaxEarningCodes_Taxes1`
    FOREIGN KEY (`Taxes_taxesID` , `Taxes_employeeID`)
    REFERENCES `PayrollManagementDB`.`Taxes` (`taxesID` , `employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`W2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`W2` (
  `employeeID` INT NOT NULL,
  `amountEarned` INT NULL,
  `amountWithheld` INT NULL,
  `Taxes_taxesID` INT NOT NULL,
  `Taxes_employeeID` INT NOT NULL,
  PRIMARY KEY (`employeeID`, `Taxes_taxesID`, `Taxes_employeeID`),
  INDEX `fk_W2_Taxes1_idx` (`Taxes_taxesID` ASC, `Taxes_employeeID` ASC) VISIBLE,
  CONSTRAINT `fk_W2_Taxes1`
    FOREIGN KEY (`Taxes_taxesID` , `Taxes_employeeID`)
    REFERENCES `PayrollManagementDB`.`Taxes` (`taxesID` , `employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Holidays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Holidays` (
  `calendarID` INT NOT NULL AUTO_INCREMENT,
  `UShoidays` DATE NOT NULL,
  `otherHolidays` DATE NOT NULL,
  `Calendar_calendarID` INT NOT NULL,
  PRIMARY KEY (`calendarID`),
  UNIQUE INDEX `calendarID_UNIQUE` (`calendarID` ASC) VISIBLE,
  INDEX `fk_Holidays_Calendar1_idx` (`Calendar_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_Holidays_Calendar1`
    FOREIGN KEY (`Calendar_calendarID`)
    REFERENCES `PayrollManagementDB`.`Calendar` (`calendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Payday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Payday` (
  `calendarID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  `employeeID` INT NOT NULL,
  `paid` TINYINT NULL DEFAULT 0,
  `Calendar_calendarID` INT NOT NULL,
  PRIMARY KEY (`calendarID`, `departmentID`, `employeeID`),
  INDEX `fk_Payday_Calendar1_idx` (`Calendar_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_Payday_Calendar1`
    FOREIGN KEY (`Calendar_calendarID`)
    REFERENCES `PayrollManagementDB`.`Calendar` (`calendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Deadlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Deadlines` (
  `calendarID` INT NOT NULL,
  `departmentID` INT NOT NULL,
  `projectID` INT NOT NULL,
  `projectDeadline` DATE NULL,
  `Calendar_calendarID` INT NOT NULL,
  PRIMARY KEY (`calendarID`, `departmentID`, `projectID`),
  INDEX `fk_Deadlines_Calendar1_idx` (`Calendar_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_Deadlines_Calendar1`
    FOREIGN KEY (`Calendar_calendarID`)
    REFERENCES `PayrollManagementDB`.`Calendar` (`calendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Paid Time Off`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Paid Time Off` (
  `calendarID` INT NOT NULL,
  `timeOff` INT ZEROFILL NULL,
  `sickTimeOff` INT ZEROFILL NULL,
  `Calendar_calendarID` INT NOT NULL,
  PRIMARY KEY (`calendarID`, `Calendar_calendarID`),
  INDEX `fk_Paid Time Off_Calendar1_idx` (`Calendar_calendarID` ASC) VISIBLE,
  CONSTRAINT `fk_Paid Time Off_Calendar1`
    FOREIGN KEY (`Calendar_calendarID`)
    REFERENCES `PayrollManagementDB`.`Calendar` (`calendarID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`HourlyWorker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`HourlyWorker` (
  `employeeID` INT NOT NULL,
  `wage` INT ZEROFILL NULL,
  `departmentID` INT NOT NULL,
  `hoursWorked` TIME NULL,
  PRIMARY KEY (`employeeID`, `departmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`SalaryWorker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`SalaryWorker` (
  `employeeID` INT NOT NULL,
  `SalaryAmt` INT ZEROFILL NULL,
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`SalaryWorker_has_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`SalaryWorker_has_Employee` (
  `SalaryWorker_EmployeeID` INT NOT NULL,
  `Employee_EmployeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  PRIMARY KEY (`SalaryWorker_EmployeeID`, `Employee_EmployeeID`, `Employee_userID`),
  INDEX `fk_SalaryWorker_has_Employee_Employee1_idx` (`Employee_EmployeeID` ASC, `Employee_userID` ASC) VISIBLE,
  INDEX `fk_SalaryWorker_has_Employee_SalaryWorker1_idx` (`SalaryWorker_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_SalaryWorker_has_Employee_SalaryWorker1`
    FOREIGN KEY (`SalaryWorker_EmployeeID`)
    REFERENCES `PayrollManagementDB`.`SalaryWorker` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalaryWorker_has_Employee_Employee1`
    FOREIGN KEY (`Employee_EmployeeID` , `Employee_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`HourlyWorker_has_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`HourlyWorker_has_Employee` (
  `HourlyWorker_EmployeeID` INT NOT NULL,
  `HourlyWorker_departmentID` INT NOT NULL,
  `Employee_EmployeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  PRIMARY KEY (`HourlyWorker_EmployeeID`, `HourlyWorker_departmentID`, `Employee_EmployeeID`, `Employee_userID`),
  INDEX `fk_HourlyWorker_has_Employee_Employee1_idx` (`Employee_EmployeeID` ASC, `Employee_userID` ASC) VISIBLE,
  INDEX `fk_HourlyWorker_has_Employee_HourlyWorker1_idx` (`HourlyWorker_EmployeeID` ASC, `HourlyWorker_departmentID` ASC) VISIBLE,
  CONSTRAINT `fk_HourlyWorker_has_Employee_HourlyWorker1`
    FOREIGN KEY (`HourlyWorker_EmployeeID` , `HourlyWorker_departmentID`)
    REFERENCES `PayrollManagementDB`.`HourlyWorker` (`employeeID` , `departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HourlyWorker_has_Employee_Employee1`
    FOREIGN KEY (`Employee_EmployeeID` , `Employee_userID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Manager_has_Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Manager_has_Manager` (
  `Manager_userID` INT NOT NULL,
  `Manager_userID1` INT NOT NULL,
  PRIMARY KEY (`Manager_userID`, `Manager_userID1`),
  INDEX `fk_Manager_has_Manager_Manager2_idx` (`Manager_userID1` ASC) VISIBLE,
  INDEX `fk_Manager_has_Manager_Manager1_idx` (`Manager_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Manager_has_Manager_Manager1`
    FOREIGN KEY (`Manager_userID`)
    REFERENCES `PayrollManagementDB`.`Manager` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manager_has_Manager_Manager2`
    FOREIGN KEY (`Manager_userID1`)
    REFERENCES `PayrollManagementDB`.`Manager` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayrollManagementDB`.`Department_has_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PayrollManagementDB`.`Department_has_Employee` (
  `Department_departmentID` INT NOT NULL,
  `Employee_employeeID` INT NOT NULL,
  `Employee_userID` INT NOT NULL,
  `Employee_departmentID` INT NOT NULL,
  `Employee_TimeStayed_employeeID` INT NOT NULL,
  PRIMARY KEY (`Department_departmentID`, `Employee_employeeID`, `Employee_userID`, `Employee_departmentID`, `Employee_TimeStayed_employeeID`),
  INDEX `fk_Department_has_Employee_Employee1_idx` (`Employee_employeeID` ASC, `Employee_userID` ASC, `Employee_departmentID` ASC, `Employee_TimeStayed_employeeID` ASC) VISIBLE,
  INDEX `fk_Department_has_Employee_Department1_idx` (`Department_departmentID` ASC) VISIBLE,
  CONSTRAINT `fk_Department_has_Employee_Department1`
    FOREIGN KEY (`Department_departmentID`)
    REFERENCES `PayrollManagementDB`.`Department` (`departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Department_has_Employee_Employee1`
    FOREIGN KEY (`Employee_employeeID` , `Employee_userID` , `Employee_departmentID`)
    REFERENCES `PayrollManagementDB`.`Employee` (`employeeID` , `userID` , `departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
