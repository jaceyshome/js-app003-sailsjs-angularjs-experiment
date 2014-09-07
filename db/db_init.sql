SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `palette_dev` ;
CREATE SCHEMA IF NOT EXISTS `palette_dev` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `palette_dev` ;

-- -----------------------------------------------------
-- Table `palette_dev`.`Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Departments` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Departments` (
  `id` INT(4) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` TIMESTAMP NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Users` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `userName` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(256) NOT NULL ,
  `departmentId` INT(4) NULL ,
  `isSuperAdmin` INT(1) NOT NULL COMMENT 'for super admin only' ,
  `avator` VARCHAR(1000) NULL ,
  `nickName` VARCHAR(45) NOT NULL ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) ,
  INDEX `fk_Users_Departments1_idx` (`departmentId` ASC) ,
  UNIQUE INDEX `nickName_UNIQUE` (`nickName` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_Users_Departments1`
  FOREIGN KEY (`departmentId` )
  REFERENCES `palette_dev`.`Departments` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`States`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`States` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`States` (
  `id` INT(2) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `createdAt` DATETIME NULL ,
  `updatedAt` TIMESTAMP NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`Stages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Stages` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Stages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `projectId` INT(11) NOT NULL ,
  `stateId` INT(2) NOT NULL ,
  `name` VARCHAR(100) NULL ,
  `description` TEXT NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Stages_Projects_idx` (`projectId` ASC) ,
  INDEX `fk_Stages_States1_idx` (`stateId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_Stages_Projects`
  FOREIGN KEY (`projectId` )
  REFERENCES `palette_dev`.`Projects` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stages_States1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`States` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`Projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Projects` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Projects` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `stateId` INT(2) NOT NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `priority` INT(1) NOT NULL DEFAULT 0 ,
  `currentStageId` INT(11) NULL ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_Projects_Stages1_idx` (`currentStageId` ASC) ,
  INDEX `fk_Projects_States1_idx` (`stateId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_Projects_Stages1`
  FOREIGN KEY (`currentStageId` )
  REFERENCES `palette_dev`.`Stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projects_States1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`States` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`Types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Types` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Types` (
  `id` INT(4) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL COMMENT 'TEXT, DESIGN, FUNCTIONALITY, QA, ASSETS UPDATE' ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`Tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`Tasks` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`Tasks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `stageId` INT(11) NOT NULL ,
  `stateId` INT(2) NOT NULL ,
  `typeId` INT(4) NULL ,
  `name` VARCHAR(200) NULL ,
  `description` TEXT NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Tasks_Stages1_idx` (`stageId` ASC) ,
  INDEX `fk_Tasks_type1_idx` (`typeId` ASC) ,
  INDEX `fk_Tasks_States1_idx` (`stateId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_Tasks_Stages1`
  FOREIGN KEY (`stageId` )
  REFERENCES `palette_dev`.`Stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_type1`
  FOREIGN KEY (`typeId` )
  REFERENCES `palette_dev`.`Types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_States1`
  FOREIGN KEY (`stateId` )
  REFERENCES `palette_dev`.`States` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`TaskLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`TaskLogs` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`TaskLogs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `taskId` INT(11) NOT NULL ,
  `userId` INT(11) NOT NULL ,
  `comment` TEXT NULL ,
  `estimatedHours` FLOAT NOT NULL DEFAULT 0 ,
  `spentHours` FLOAT NOT NULL DEFAULT 0 ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_TaskUserRescords_Tasks1_idx` (`taskId` ASC) ,
  INDEX `fk_TaskUserRescords_Users1_idx` (`userId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_TaskUserRescords_Tasks1`
  FOREIGN KEY (`taskId` )
  REFERENCES `palette_dev`.`Tasks` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TaskUserRescords_Users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`ProjectUsers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`ProjectUsers` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`ProjectUsers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `projectId` INT(11) NOT NULL ,
  `userId` INT(11) NOT NULL ,
  `autherization` INT(2) NOT NULL DEFAULT 0 ,
  `createdAt` DATETIME NOT NULL ,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_ProjectUsers_Projects1_idx` (`projectId` ASC) ,
  INDEX `fk_ProjectUsers_Users1_idx` (`userId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_ProjectUsers_Projects1`
  FOREIGN KEY (`projectId` )
  REFERENCES `palette_dev`.`Projects` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectUsers_Users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palette_dev`.`StageLogs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palette_dev`.`StageLogs` ;

CREATE  TABLE IF NOT EXISTS `palette_dev`.`StageLogs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `stageId` INT(11) NOT NULL ,
  `userId` INT(11) NOT NULL ,
  `comment` VARCHAR(300) NULL ,
  `budgetedHours` FLOAT NOT NULL DEFAULT 0 ,
  `createdAt` DATETIME NULL ,
  `updatedAt` TIMESTAMP NULL DEFAULT now() ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_StageLogs_Stages1_idx` (`stageId` ASC) ,
  INDEX `fk_StageLogs_Users1_idx` (`userId` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_StageLogs_Stages1`
  FOREIGN KEY (`stageId` )
  REFERENCES `palette_dev`.`Stages` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StageLogs_Users1`
  FOREIGN KEY (`userId` )
  REFERENCES `palette_dev`.`Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


