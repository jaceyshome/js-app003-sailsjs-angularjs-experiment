SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `palette_dev`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`departments` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`departments` (
  `id` INT(4) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`users` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(256) NOT NULL ,
  `isAdmin` INT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'for super admin only' ,
  `avator` VARCHAR(1000) NULL ,
  `online` INT(1) NOT NULL DEFAULT 0 ,
  `shortLink` VARCHAR(24) NOT NULL ,
  `departmentId` INT(4) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `userName_UNIQUE` (`name` ASC) ,
  UNIQUE INDEX `nickName_UNIQUE` (`shortLink` ASC) ,
  INDEX `fk_users_departments1` (`departmentId` ASC) ,
  CONSTRAINT `fk_users_departments1`
  FOREIGN KEY (`departmentId` )
  REFERENCES `palette_dev`.`departments` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`states` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`states` (
  `id` INT(4) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`stages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`stages` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`stages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `projectId` INT(11) NOT NULL ,
  `stateId` INT(2) NOT NULL ,
  `name` VARCHAR(100) NULL ,
  `description` VARCHAR(1000) NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_stages_states1` (`stateId` ASC) ,
  INDEX `fk_stages_projects1_idx` (`projectId` ASC) ,
  CONSTRAINT `fk_stages_states1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`states` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stages_projects1`
  FOREIGN KEY (`projectId` )
  REFERENCES `palette_dev`.`projects` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`projects` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`projects` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(200) NOT NULL ,
  `shortLink` VARCHAR(24) NOT NULL ,
  `description` TEXT NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `priority` INT(1) NOT NULL DEFAULT 0 ,
  `stateId` INT(2) NOT NULL DEFAULT 1 ,
  `currentStageId` INT(11) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_projects_states1` (`stateId` ASC) ,
  INDEX `fk_projects_stages1` (`currentStageId` ASC) ,
  UNIQUE INDEX `shortLink_UNIQUE` (`shortLink` ASC) ,
  CONSTRAINT `fk_projects_states1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`states` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_stages1`
  FOREIGN KEY (`currentStageId` )
  REFERENCES `palette_dev`.`stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`types` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`types` (
  `id` INT(4) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL COMMENT 'TEXT, DESIGN, FUNCTIONALITY, QA, ASSETS UPDATE' ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`tasks` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`tasks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(200) NULL ,
  `description` TEXT NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `stageId` INT(11) NOT NULL ,
  `stateId` INT(2) NOT NULL ,
  `typeId` INT(4) NOT NULL ,
  `updatedAt` DATETIME NULL ,
  `createdAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_tasks_stages1` (`stageId` ASC) ,
  INDEX `fk_tasks_states1` (`stateId` ASC) ,
  INDEX `fk_tasks_types1` (`typeId` ASC) ,
  CONSTRAINT `fk_tasks_stages1`
  FOREIGN KEY (`stageId` )
  REFERENCES `palette_dev`.`stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasks_states1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`states` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasks_types1`
  FOREIGN KEY (`typeId` )
  REFERENCES `palette_dev`.`types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`taskLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`taskLogs` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`taskLogs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `comment` VARCHAR(300) NULL ,
  `estimatedHours` FLOAT NOT NULL DEFAULT 0 ,
  `spentHours` FLOAT NOT NULL DEFAULT 0 ,
  `taskId` INT(11) NOT NULL ,
  `userId` INT(11) NOT NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_taskLogs_tasks1` (`taskId` ASC) ,
  INDEX `fk_taskLogs_users1` (`userId` ASC) ,
  CONSTRAINT `fk_taskLogs_tasks1`
  FOREIGN KEY (`taskId` )
  REFERENCES `palette_dev`.`tasks` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_taskLogs_users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`projectUsers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`projectUsers` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`projectUsers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `autherization` INT(2) NOT NULL DEFAULT 0 ,
  `projectId` INT(11) NOT NULL ,
  `userId` INT(11) NOT NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_projectUsers_projects1` (`projectId` ASC) ,
  INDEX `fk_projectUsers_users1` (`userId` ASC) ,
  CONSTRAINT `fk_projectUsers_projects1`
  FOREIGN KEY (`projectId` )
  REFERENCES `palette_dev`.`projects` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projectUsers_users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`stageLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`stageLogs` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`stageLogs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `comment` VARCHAR(300) NULL ,
  `budgetedHours` FLOAT NOT NULL DEFAULT 0 ,
  `createdAt` DATETIME NULL ,
  `updatedAt` DATETIME NULL ,
  `userId` INT(11) NOT NULL ,
  `stageId` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_stageLogs_users1` (`userId` ASC) ,
  INDEX `fk_stageLogs_stages1` (`stageId` ASC) ,
  CONSTRAINT `fk_stageLogs_users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_stageLogs_stages1`
  FOREIGN KEY (`stageId` )
  REFERENCES `palette_dev`.`stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `palette_dev`.`states`
-- -----------------------------------------------------
START TRANSACTION;
USE `palette_dev`;
INSERT INTO `palette_dev`.`states` (`id`, `name`, `createdAt`, `updatedAt`) VALUES (1, 'new ', NULL, NULL);
INSERT INTO `palette_dev`.`states` (`id`, `name`, `createdAt`, `updatedAt`) VALUES (2, 'open', NULL, NULL);
INSERT INTO `palette_dev`.`states` (`id`, `name`, `createdAt`, `updatedAt`) VALUES (3, 'resolved', NULL, NULL);
INSERT INTO `palette_dev`.`states` (`id`, `name`, `createdAt`, `updatedAt`) VALUES (4, 'closed', NULL, NULL);

COMMIT;
