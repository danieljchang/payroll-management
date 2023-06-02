-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema payrollmanagementdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema payrollmanagementdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `payrollmanagementdb` DEFAULT CHARACTER SET utf8 ;
USE `payrollmanagementdb` ;

-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login_time` TIMESTAMP NULL,
  `create_time` TIMESTAMP NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`manager` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `manager_level` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NOT NULL,
  `major` VARCHAR(45) NOT NULL,
  `employee_level` INT ZEROFILL NOT NULL,
  `is_wage` TINYINT NOT NULL DEFAULT 0,
  `last_bonus` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`time_worked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`time_worked` (
  `amt_time` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_time_worked_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`payment_method` (
  `other` VARCHAR(45) NOT NULL DEFAULT 'none',
  `direct_deposit` TINYINT NOT NULL DEFAULT 0,
  `checks` TINYINT NOT NULL DEFAULT 0,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`other`, `employee_id`),
  INDEX `fk_payment_method_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_method_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`paid_time_off`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`paid_time_off` (
  `time_off` INT ZEROFILL NOT NULL,
  `time_left` INT NOT NULL DEFAULT 100,
  `sick_leave` INT ZEROFILL NOT NULL,
  `employee_id` INT NOT NULL,
  `employee_taxes_id` INT NOT NULL,
  INDEX `fk_paid_time_off_employee1_idx` (`employee_id` ASC, `employee_taxes_id` ASC) VISIBLE,
  CONSTRAINT `fk_paid_time_off_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`payroll` (
  `id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_payroll_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_payroll_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `funding` INT ZEROFILL NOT NULL,
  `num_employees` INT ZEROFILL NOT NULL,
  `funding_saved` INT ZEROFILL NULL,
  `department_name` VARCHAR(45) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`taxes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`taxes` (
  `id` INT NOT NULL,
  `amount` INT NOT NULL,
  `paid` TINYINT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_taxes_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_taxes_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`w2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`w2` (
  `amount_earned` INT ZEROFILL NOT NULL,
  `amount_withheld` INT ZEROFILL NOT NULL,
  `taxes_id` INT NOT NULL,
  PRIMARY KEY (`taxes_id`),
  CONSTRAINT `fk_w2_taxes1`
    FOREIGN KEY (`taxes_id`)
    REFERENCES `payrollmanagementdb`.`taxes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`expenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`expenses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` INT ZEROFILL NOT NULL,
  `spent_on` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`performance_goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`performance_goals` (
  `start` DATE NOT NULL,
  `eta` DATE NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  CONSTRAINT `fk_performance_goals_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `payrollmanagementdb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`salary_worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`salary_worker` (
  `id` INT NOT NULL,
  `salary` INT ZEROFILL NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_salary_worker_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_salary_worker_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`hourly_worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`hourly_worker` (
  `id` INT NOT NULL,
  `wage` DECIMAL(5,2) NOT NULL DEFAULT 16.63,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_hourly_worker_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_hourly_worker_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`project` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`id`, `department_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_project_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `payrollmanagementdb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`deadlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`deadlines` (
  `id` INT NOT NULL,
  `deadline` TIMESTAMP NULL,
  `late` TINYINT NULL DEFAULT 0,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`id`, `project_id`),
  INDEX `fk_deadlines_project1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_deadlines_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `payrollmanagementdb`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`calendar` (
  `id` INT NOT NULL,
  `gregorian` TINYINT UNSIGNED NULL DEFAULT 1,
  `deadlines_id` INT NOT NULL,
  `deadlines_project_id` INT NOT NULL,
  PRIMARY KEY (`id`, `deadlines_id`, `deadlines_project_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_calendar_deadlines1_idx` (`deadlines_id` ASC, `deadlines_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_calendar_deadlines1`
    FOREIGN KEY (`deadlines_id` , `deadlines_project_id`)
    REFERENCES `payrollmanagementdb`.`deadlines` (`id` , `project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`holidays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`holidays` (
  `id` INT NOT NULL,
  `holiday_name` VARCHAR(45) NOT NULL,
  `day_off_in_us` TINYINT NULL DEFAULT 0,
  `day_off_other` TINYINT NULL DEFAULT 0,
  `calendar_id` INT NOT NULL,
  PRIMARY KEY (`id`, `calendar_id`),
  INDEX `fk_holidays_calendar1_idx` (`calendar_id` ASC) VISIBLE,
  CONSTRAINT `fk_holidays_calendar1`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `payrollmanagementdb`.`calendar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`payday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`payday` (
  `day_to_pay` DATE NOT NULL,
  `employee_paid` TINYINT NULL DEFAULT 0,
  `calendar_id` INT NOT NULL,
  CONSTRAINT `fk_payday_calendar1`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `payrollmanagementdb`.`calendar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`performance_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`performance_reviews` (
  `id` INT NOT NULL,
  `review` VARCHAR(200) NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`time_stayed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`time_stayed` (
  `start_date` TIMESTAMP NOT NULL,
  `time_on_project` TIMESTAMP NULL,
  `employee_id` INT NOT NULL,
  `calendar_id` INT NOT NULL,
  `calendar_deadlines_id` INT NOT NULL,
  `calendar_deadlines_project_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `calendar_id`, `calendar_deadlines_id`, `calendar_deadlines_project_id`),
  INDEX `fk_time_stayed_calendar1_idx` (`calendar_id` ASC, `calendar_deadlines_id` ASC, `calendar_deadlines_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_time_stayed_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_stayed_calendar1`
    FOREIGN KEY (`calendar_id` , `calendar_deadlines_id` , `calendar_deadlines_project_id`)
    REFERENCES `payrollmanagementdb`.`calendar` (`id` , `deadlines_id` , `deadlines_project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`job_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`job_history` (
  `company` VARCHAR(100) NOT NULL,
  `time_in_industry` TIMESTAMP NULL,
  `job_title` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_job_history_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`time_sheet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`time_sheet` (
  `id` INT NOT NULL,
  `time_start` TIMESTAMP NOT NULL,
  `time_end` TIMESTAMP NOT NULL,
  `expected_num_hrs_worked` INT ZEROFILL NULL,
  `hourly_worker_id` INT NOT NULL,
  `hourly_worker_employee_id` INT NOT NULL,
  `calendar_id` INT NOT NULL,
  `calendar_deadlines_id` INT NOT NULL,
  `calendar_deadlines_project_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `hourly_worker_id`, `hourly_worker_employee_id`, `employee_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_time_sheet_hourly_worker1_idx` (`hourly_worker_id` ASC, `hourly_worker_employee_id` ASC) VISIBLE,
  INDEX `fk_time_sheet_calendar1_idx` (`calendar_id` ASC, `calendar_deadlines_id` ASC, `calendar_deadlines_project_id` ASC) VISIBLE,
  INDEX `fk_time_sheet_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_time_sheet_hourly_worker1`
    FOREIGN KEY (`hourly_worker_id` , `hourly_worker_employee_id`)
    REFERENCES `payrollmanagementdb`.`hourly_worker` (`id` , `employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_sheet_calendar1`
    FOREIGN KEY (`calendar_id` , `calendar_deadlines_id` , `calendar_deadlines_project_id`)
    REFERENCES `payrollmanagementdb`.`calendar` (`id` , `deadlines_id` , `deadlines_project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_sheet_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`insurance` (
  `id` INT NOT NULL,
  `insurance_type` VARCHAR(45) NULL,
  `amount_provided` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`medical_withholdings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`medical_withholdings` (
  `amount` INT ZEROFILL NOT NULL,
  `time_withheld` TIMESTAMP NULL,
  `insurance_id` INT NOT NULL,
  INDEX `fk_medical_withholdings_insurance1_idx` (`insurance_id` ASC) VISIBLE,
  CONSTRAINT `fk_medical_withholdings_insurance1`
    FOREIGN KEY (`insurance_id`)
    REFERENCES `payrollmanagementdb`.`insurance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`benefits` (
  `amount` INT ZEROFILL NOT NULL,
  `employee_id` INT NOT NULL,
  `employee_taxes_id` INT NOT NULL,
  `performance_reviews_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `employee_taxes_id`, `performance_reviews_id`),
  INDEX `fk_benefits_performance_reviews1_idx` (`performance_reviews_id` ASC) VISIBLE,
  CONSTRAINT `fk_benefits_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benefits_performance_reviews1`
    FOREIGN KEY (`performance_reviews_id`)
    REFERENCES `payrollmanagementdb`.`performance_reviews` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`employee_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`employee_has_user` (
  `employee_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `user_id`),
  INDEX `fk_employee_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_employee_has_user_employee_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_user_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `payrollmanagementdb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`manager_has_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`manager_has_manager` (
  `manager_id` INT NOT NULL,
  `manager_id1` INT NOT NULL,
  PRIMARY KEY (`manager_id`, `manager_id1`),
  INDEX `fk_manager_has_manager_manager2_idx` (`manager_id1` ASC) VISIBLE,
  INDEX `fk_manager_has_manager_manager1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_manager_has_manager_manager1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `payrollmanagementdb`.`manager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_has_manager_manager2`
    FOREIGN KEY (`manager_id1`)
    REFERENCES `payrollmanagementdb`.`manager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`employee_has_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`employee_has_manager` (
  `employee_id` INT NOT NULL,
  `manager_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `manager_id`),
  INDEX `fk_employee_has_manager_manager1_idx` (`manager_id` ASC) VISIBLE,
  INDEX `fk_employee_has_manager_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_manager_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_manager_manager1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `payrollmanagementdb`.`manager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`expenses_has_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`expenses_has_manager` (
  `expenses_id` INT NOT NULL,
  `manager_id` INT NOT NULL,
  PRIMARY KEY (`expenses_id`, `manager_id`),
  INDEX `fk_expenses_has_manager_manager1_idx` (`manager_id` ASC) VISIBLE,
  INDEX `fk_expenses_has_manager_expenses1_idx` (`expenses_id` ASC) VISIBLE,
  CONSTRAINT `fk_expenses_has_manager_expenses1`
    FOREIGN KEY (`expenses_id`)
    REFERENCES `payrollmanagementdb`.`expenses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expenses_has_manager_manager1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `payrollmanagementdb`.`manager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`performance_reviews_has_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`performance_reviews_has_employee` (
  `performance_reviews_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`performance_reviews_id`, `employee_id`),
  INDEX `fk_performance_reviews_has_employee_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_performance_reviews_has_employee_performance_reviews1_idx` (`performance_reviews_id` ASC) VISIBLE,
  CONSTRAINT `fk_performance_reviews_has_employee_performance_reviews1`
    FOREIGN KEY (`performance_reviews_id`)
    REFERENCES `payrollmanagementdb`.`performance_reviews` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_performance_reviews_has_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`employee_has_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`employee_has_department` (
  `employee_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `department_id`),
  INDEX `fk_employee_has_department_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_employee_has_department_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_department_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_department_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `payrollmanagementdb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`manager_has_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`manager_has_department` (
  `manager_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`manager_id`, `department_id`),
  INDEX `fk_manager_has_department_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_manager_has_department_manager1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_manager_has_department_manager1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `payrollmanagementdb`.`manager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_has_department_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `payrollmanagementdb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payrollmanagementdb`.`employee_has_insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payrollmanagementdb`.`employee_has_insurance` (
  `employee_id` INT NOT NULL,
  `insurance_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `insurance_id`),
  INDEX `fk_employee_has_insurance_insurance1_idx` (`insurance_id` ASC) VISIBLE,
  INDEX `fk_employee_has_insurance_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_insurance_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `payrollmanagementdb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_insurance_insurance1`
    FOREIGN KEY (`insurance_id`)
    REFERENCES `payrollmanagementdb`.`insurance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
