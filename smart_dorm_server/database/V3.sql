-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema smart_dorm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema smart_dorm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smart_dorm` DEFAULT CHARACTER SET utf8mb3 ;
USE `smart_dorm` ;

-- -----------------------------------------------------
-- Table `smart_dorm`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`admins` (
  `wno` CHAR(20) NOT NULL,
  `wname` VARCHAR(55) NOT NULL,
  `wsex` CHAR(10) NOT NULL,
  `wtel` CHAR(20) NOT NULL,
  PRIMARY KEY (`wno`),
  UNIQUE INDEX `wno_UNIQUE` (`wno` ASC) VISIBLE,
  UNIQUE INDEX `wtel_UNIQUE` (`wtel` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`buildings` (
  `bno` CHAR(20) NOT NULL,
  `bname` VARCHAR(55) NOT NULL,
  `baddr` VARCHAR(55) NOT NULL,
  `poweroff` CHAR(20) NOT NULL DEFAULT 'never',
  PRIMARY KEY (`bno`),
  UNIQUE INDEX `bno_UNIQUE` (`bno` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`admins_has_buildings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`admins_has_buildings` (
  `admins_wno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`admins_wno`, `buildings_bno`),
  INDEX `fk_admins_has_buildings_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  INDEX `fk_admins_has_buildings_admins1_idx` (`admins_wno` ASC) VISIBLE,
  CONSTRAINT `fk_admins_has_buildings_admins1`
    FOREIGN KEY (`admins_wno`)
    REFERENCES `smart_dorm`.`admins` (`wno`),
  CONSTRAINT `fk_admins_has_buildings_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`announces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`announces` (
  `announceno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  `admins_wno` CHAR(20) NOT NULL,
  PRIMARY KEY (`announceno`),
  UNIQUE INDEX `announceno_UNIQUE` (`announceno` ASC) VISIBLE,
  INDEX `fk_announce_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  INDEX `fk_announces_admins1_idx` (`admins_wno` ASC) VISIBLE,
  CONSTRAINT `fk_announce_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_announces_admins1`
    FOREIGN KEY (`admins_wno`)
    REFERENCES `smart_dorm`.`admins` (`wno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`dorms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`dorms` (
  `dno` CHAR(20) NOT NULL,
  `dsize` SMALLINT NOT NULL,
  `dcharge` SMALLINT NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`dno`),
  UNIQUE INDEX `dno_UNIQUE` (`dno` ASC) VISIBLE,
  INDEX `fk_dorms_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_dorms_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`students` (
  `sno` CHAR(20) NOT NULL,
  `sname` VARCHAR(55) NOT NULL,
  `stel` CHAR(20) NOT NULL,
  `sdept` CHAR(20) NOT NULL,
  `scol` CHAR(20) NOT NULL,
  `sclass` CHAR(10) NOT NULL,
  `ssex` CHAR(10) NOT NULL,
  `state` CHAR(40) NOT NULL,
  `access` CHAR(20) NOT NULL,
  `dorms_dno` CHAR(20) NULL DEFAULT NULL,
  `buildings_bno` CHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sno`),
  UNIQUE INDEX `stel_UNIQUE` (`stel` ASC) VISIBLE,
  UNIQUE INDEX `sno_UNIQUE` (`sno` ASC) VISIBLE,
  INDEX `fk_students_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_students_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_students_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_students_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`changedorm_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`changedorm_applications` (
  `changedormno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `edate` DATE NULL,
  `changedormdate` DATE NOT NULL,
  `state` VARCHAR(40) NOT NULL,
  `reason` VARCHAR(200) NULL DEFAULT '未填写',
  `students_sno` CHAR(20) NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`changedormno`),
  UNIQUE INDEX `changedormno_UNIQUE` (`changedormno` ASC) VISIBLE,
  INDEX `fk_changedorm_applications_students1_idx` (`students_sno` ASC) VISIBLE,
  INDEX `fk_changedorm_applications_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_changedorm_applications_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_changedorm_applications_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_changedorm_applications_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`),
  CONSTRAINT `fk_changedorm_applications_students1`
    FOREIGN KEY (`students_sno`)
    REFERENCES `smart_dorm`.`students` (`sno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`checkout_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`checkout_applications` (
  `checkoutno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `edate` DATE NULL,
  `checkoutdate` DATE NOT NULL,
  `state` VARCHAR(40) NOT NULL,
  `reason` VARCHAR(200) NULL DEFAULT '未填写',
  `students_sno` CHAR(20) NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`checkoutno`),
  UNIQUE INDEX `checkoutno_UNIQUE` (`checkoutno` ASC) VISIBLE,
  INDEX `fk_checkout_applications_students1_idx` (`students_sno` ASC) VISIBLE,
  INDEX `fk_checkout_applications_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_checkout_applications_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_checkout_applications_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_checkout_applications_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`),
  CONSTRAINT `fk_checkout_applications_students1`
    FOREIGN KEY (`students_sno`)
    REFERENCES `smart_dorm`.`students` (`sno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`hygienes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`hygienes` (
  `hno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `hgrade` SMALLINT NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`hno`),
  UNIQUE INDEX `hno_UNIQUE` (`hno` ASC) VISIBLE,
  INDEX `fk_hygienes_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_hygienes_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_hygienes_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_hygienes_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`leave_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`leave_applications` (
  `leaveno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `edate` DATE NULL,
  `leavedate` DATE NOT NULL,
  `backdate` DATE NOT NULL,
  `state` VARCHAR(40) NOT NULL,
  `reason` VARCHAR(200) NULL DEFAULT '未填写',
  `students_sno` CHAR(20) NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`leaveno`),
  UNIQUE INDEX `leaveno_UNIQUE` (`leaveno` ASC) VISIBLE,
  INDEX `fk_leave_applications_students1_idx` (`students_sno` ASC) VISIBLE,
  INDEX `fk_leave_applications_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_leave_applications_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_leave_applications_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_leave_applications_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`),
  CONSTRAINT `fk_leave_applications_students1`
    FOREIGN KEY (`students_sno`)
    REFERENCES `smart_dorm`.`students` (`sno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`repair_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`repair_applications` (
  `repairno` CHAR(20) NOT NULL,
  `itemname` VARCHAR(40) NOT NULL,
  `sdate` DATE NOT NULL,
  `edate` DATE NULL,
  `repairdate` DATE NOT NULL,
  `reason` VARCHAR(200) NULL DEFAULT '未填写',
  `state` VARCHAR(40) NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`repairno`),
  UNIQUE INDEX `repairno_UNIQUE` (`repairno` ASC) VISIBLE,
  INDEX `fk_repairs_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_repair_applications_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_repair_applications_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_repairs_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`staying_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`staying_applications` (
  `stayingno` CHAR(20) NOT NULL,
  `sdate` DATE NOT NULL,
  `edate` DATE NULL,
  `stayingdate` DATE NOT NULL,
  `state` VARCHAR(40) NOT NULL,
  `reason` VARCHAR(200) NULL DEFAULT '未填写',
  `students_sno` CHAR(20) NOT NULL,
  `dorms_dno` CHAR(20) NOT NULL,
  `buildings_bno` CHAR(20) NOT NULL,
  PRIMARY KEY (`stayingno`),
  UNIQUE INDEX `stayingno_UNIQUE` (`stayingno` ASC) VISIBLE,
  INDEX `fk_staying_applications_students1_idx` (`students_sno` ASC) VISIBLE,
  INDEX `fk_staying_applications_dorms1_idx` (`dorms_dno` ASC) VISIBLE,
  INDEX `fk_staying_applications_buildings1_idx` (`buildings_bno` ASC) VISIBLE,
  CONSTRAINT `fk_staying_applications_buildings1`
    FOREIGN KEY (`buildings_bno`)
    REFERENCES `smart_dorm`.`buildings` (`bno`),
  CONSTRAINT `fk_staying_applications_dorms1`
    FOREIGN KEY (`dorms_dno`)
    REFERENCES `smart_dorm`.`dorms` (`dno`),
  CONSTRAINT `fk_staying_applications_students1`
    FOREIGN KEY (`students_sno`)
    REFERENCES `smart_dorm`.`students` (`sno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`users` (
  `uno` CHAR(20) NOT NULL,
  `upass` VARCHAR(32) NOT NULL,
  `utype` CHAR(20) NOT NULL,
  PRIMARY KEY (`uno`),
  UNIQUE INDEX `uno_UNIQUE` (`uno` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `smart_dorm`.`counselors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`counselors` (
  `fno` CHAR(20) NOT NULL,
  `fname` VARCHAR(55) NOT NULL,
  `ftel` CHAR(20) NOT NULL,
  `fcol` CHAR(20) NOT NULL,
  `fdept` CHAR(20) NOT NULL,
  `fsex` CHAR(10) NOT NULL,
  PRIMARY KEY (`fno`),
  UNIQUE INDEX `fno_UNIQUE` (`fno` ASC) VISIBLE,
  UNIQUE INDEX `ftel_UNIQUE` (`ftel` ASC) VISIBLE)
ENGINE = InnoDB;

USE `smart_dorm` ;

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`admins_has_buildings_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`admins_has_buildings_view` (`admins_wno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`admins_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`admins_view` (`wno` INT, `wname` INT, `wsex` INT, `wtel` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`announces_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`announces_view` (`announceno` INT, `sdate` INT, `title` INT, `text` INT, `buildings_bno` INT, `admins_wno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`buildings_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`buildings_view` (`bno` INT, `bname` INT, `baddr` INT, `poweroff` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`changedorm_applications_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`changedorm_applications_view` (`changedormno` INT, `sdate` INT, `edate` INT, `changedormdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`changedorm_applications_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`changedorm_applications_view_01` (`changedormno` INT, `sdate` INT, `edate` INT, `changedormdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`changedorm_applications_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`changedorm_applications_view_02` (`changedormno` INT, `sdate` INT, `edate` INT, `changedormdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`checkout_applications_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`checkout_applications_view` (`checkoutno` INT, `sdate` INT, `edate` INT, `checkoutdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`checkout_applications_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`checkout_applications_view_01` (`checkoutno` INT, `sdate` INT, `edate` INT, `checkoutdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`checkout_applications_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`checkout_applications_view_02` (`checkoutno` INT, `sdate` INT, `edate` INT, `checkoutdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`dorms_buildings_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`dorms_buildings_view` (`dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`dorms_dcharge_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`dorms_dcharge_view` (`dno` INT, `dcharge` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`dorms_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`dorms_view` (`dno` INT, `dsize` INT, `dcharge` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`hygienes_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`hygienes_view` (`hno` INT, `sdate` INT, `hgrade` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`leave_applications_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`leave_applications_view` (`leaveno` INT, `sdate` INT, `edate` INT, `leavedate` INT, `backdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`leave_applications_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`leave_applications_view_01` (`leaveno` INT, `sdate` INT, `edate` INT, `leavedate` INT, `backdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`leave_applications_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`leave_applications_view_02` (`leaveno` INT, `sdate` INT, `edate` INT, `leavedate` INT, `backdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`repair_applications_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`repair_applications_view` (`repairno` INT, `itemname` INT, `sdate` INT, `edate` INT, `repairdate` INT, `reason` INT, `state` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`repair_applications_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`repair_applications_view_01` (`repairno` INT, `itemname` INT, `sdate` INT, `edate` INT, `repairdate` INT, `reason` INT, `state` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`repair_applications_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`repair_applications_view_02` (`repairno` INT, `itemname` INT, `sdate` INT, `edate` INT, `repairdate` INT, `reason` INT, `state` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`staying_applications_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`staying_applications_view` (`stayingno` INT, `sdate` INT, `edate` INT, `stayingdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`staying_applications_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`staying_applications_view_01` (`stayingno` INT, `sdate` INT, `edate` INT, `stayingdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`staying_applications_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`staying_applications_view_02` (`stayingno` INT, `sdate` INT, `edate` INT, `stayingdate` INT, `state` INT, `reason` INT, `students_sno` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`students_access_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`students_access_view` (`sno` INT, `access` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`students_dorms_view_01`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`students_dorms_view_01` (`sno` INT, `dorms_dno` INT, `buildings_bno` INT, `state` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`students_dorms_view_02`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`students_dorms_view_02` (`sno` INT, `dorms_dno` INT, `buildings_bno` INT, `state` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`students_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`students_view` (`sno` INT, `sname` INT, `stel` INT, `scol` INT, `sdept` INT, `sclass` INT, `ssex` INT, `state` INT, `access` INT, `dorms_dno` INT, `buildings_bno` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`users_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`users_view` (`uno` INT, `upass` INT, `utype` INT);

-- -----------------------------------------------------
-- Placeholder table for view `smart_dorm`.`counselors_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart_dorm`.`counselors_view` (`fno` INT, `fname` INT, `ftel` INT, `fcol` INT, `fdept` INT, `fsex` INT);

-- -----------------------------------------------------
-- View `smart_dorm`.`admins_has_buildings_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`admins_has_buildings_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`admins_has_buildings_view` (`admins_wno`,`buildings_bno`) AS select `smart_dorm`.`admins_has_buildings`.`admins_wno` AS `admins_wno`,`smart_dorm`.`admins_has_buildings`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`admins_has_buildings` order by `smart_dorm`.`admins_has_buildings`.`admins_wno`,`smart_dorm`.`admins_has_buildings`.`buildings_bno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`admins_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`admins_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`admins_view` (`wno`,`wname`,`wsex`,`wtel`) AS select `smart_dorm`.`admins`.`wno` AS `wno`,`smart_dorm`.`admins`.`wname` AS `wname`,`smart_dorm`.`admins`.`wsex` AS `wsex`,`smart_dorm`.`admins`.`wtel` AS `wtel` from `smart_dorm`.`admins` order by `smart_dorm`.`admins`.`wno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`announces_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`announces_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`announces_view` (`announceno`,`sdate`,`title`,`text`,`buildings_bno`,`admins_wno`) AS select `smart_dorm`.`announces`.`announceno` AS `announceno`,`smart_dorm`.`announces`.`sdate` AS `sdate`,`smart_dorm`.`announces`.`title` AS `title`,`smart_dorm`.`announces`.`text` AS `text`,`smart_dorm`.`announces`.`buildings_bno` AS `buildings_bno`,`smart_dorm`.`announces`.`admins_wno` AS `admins_wno` from `smart_dorm`.`announces` order by `smart_dorm`.`announces`.`announceno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`buildings_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`buildings_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`buildings_view` (`bno`,`bname`,`baddr`,`poweroff`) AS select `smart_dorm`.`buildings`.`bno` AS `bno`,`smart_dorm`.`buildings`.`bname` AS `bname`,`smart_dorm`.`buildings`.`baddr` AS `baddr`,`smart_dorm`.`buildings`.`poweroff` AS `poweroff` from `smart_dorm`.`buildings` order by `smart_dorm`.`buildings`.`bno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`changedorm_applications_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`changedorm_applications_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`changedorm_applications_view` (`changedormno`,`sdate`,`edate`,`changedormdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`changedorm_applications`.`changedormno` AS `changedormno`,`smart_dorm`.`changedorm_applications`.`sdate` AS `sdate`,`smart_dorm`.`changedorm_applications`.`edate` AS `edate`,`smart_dorm`.`changedorm_applications`.`changedormdate` AS `changedormdate`,`smart_dorm`.`changedorm_applications`.`state` AS `state`,`smart_dorm`.`changedorm_applications`.`reason` AS `reason`,`smart_dorm`.`changedorm_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`changedorm_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`changedorm_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`changedorm_applications` order by `smart_dorm`.`changedorm_applications`.`changedormno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`changedorm_applications_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`changedorm_applications_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`changedorm_applications_view_01` (`changedormno`,`sdate`,`edate`,`changedormdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`changedorm_applications`.`changedormno` AS `changedormno`,`smart_dorm`.`changedorm_applications`.`sdate` AS `sdate`,`smart_dorm`.`changedorm_applications`.`edate` AS `edate`,`smart_dorm`.`changedorm_applications`.`changedormdate` AS `changedormdate`,`smart_dorm`.`changedorm_applications`.`state` AS `state`,`smart_dorm`.`changedorm_applications`.`reason` AS `reason`,`smart_dorm`.`changedorm_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`changedorm_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`changedorm_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`changedorm_applications` where (`smart_dorm`.`changedorm_applications`.`edate` is null) order by `smart_dorm`.`changedorm_applications`.`changedormno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`changedorm_applications_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`changedorm_applications_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`changedorm_applications_view_02` (`changedormno`,`sdate`,`edate`,`changedormdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`changedorm_applications`.`changedormno` AS `changedormno`,`smart_dorm`.`changedorm_applications`.`sdate` AS `sdate`,`smart_dorm`.`changedorm_applications`.`edate` AS `edate`,`smart_dorm`.`changedorm_applications`.`changedormdate` AS `changedormdate`,`smart_dorm`.`changedorm_applications`.`state` AS `state`,`smart_dorm`.`changedorm_applications`.`reason` AS `reason`,`smart_dorm`.`changedorm_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`changedorm_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`changedorm_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`changedorm_applications` where (`smart_dorm`.`changedorm_applications`.`edate` is not null) order by `smart_dorm`.`changedorm_applications`.`changedormno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`checkout_applications_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`checkout_applications_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`checkout_applications_view` (`checkoutno`,`sdate`,`edate`,`checkoutdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`checkout_applications`.`checkoutno` AS `checkoutno`,`smart_dorm`.`checkout_applications`.`sdate` AS `sdate`,`smart_dorm`.`checkout_applications`.`edate` AS `edate`,`smart_dorm`.`checkout_applications`.`checkoutdate` AS `checkoutdate`,`smart_dorm`.`checkout_applications`.`state` AS `state`,`smart_dorm`.`checkout_applications`.`reason` AS `reason`,`smart_dorm`.`checkout_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`checkout_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`checkout_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`checkout_applications` order by `smart_dorm`.`checkout_applications`.`checkoutno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`checkout_applications_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`checkout_applications_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`checkout_applications_view_01` (`checkoutno`,`sdate`,`edate`,`checkoutdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`checkout_applications`.`checkoutno` AS `checkoutno`,`smart_dorm`.`checkout_applications`.`sdate` AS `sdate`,`smart_dorm`.`checkout_applications`.`edate` AS `edate`,`smart_dorm`.`checkout_applications`.`checkoutdate` AS `checkoutdate`,`smart_dorm`.`checkout_applications`.`state` AS `state`,`smart_dorm`.`checkout_applications`.`reason` AS `reason`,`smart_dorm`.`checkout_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`checkout_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`checkout_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`checkout_applications` where (`smart_dorm`.`checkout_applications`.`edate` is null) order by `smart_dorm`.`checkout_applications`.`checkoutno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`checkout_applications_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`checkout_applications_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`checkout_applications_view_02` (`checkoutno`,`sdate`,`edate`,`checkoutdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`checkout_applications`.`checkoutno` AS `checkoutno`,`smart_dorm`.`checkout_applications`.`sdate` AS `sdate`,`smart_dorm`.`checkout_applications`.`edate` AS `edate`,`smart_dorm`.`checkout_applications`.`checkoutdate` AS `checkoutdate`,`smart_dorm`.`checkout_applications`.`state` AS `state`,`smart_dorm`.`checkout_applications`.`reason` AS `reason`,`smart_dorm`.`checkout_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`checkout_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`checkout_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`checkout_applications` where (`smart_dorm`.`checkout_applications`.`edate` is not null) order by `smart_dorm`.`checkout_applications`.`checkoutno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`dorms_buildings_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`dorms_buildings_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`dorms_buildings_view` (`dno`,`buildings_bno`) AS select `smart_dorm`.`dorms`.`dno` AS `dno`,`smart_dorm`.`dorms`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`dorms` order by `smart_dorm`.`dorms`.`buildings_bno`,`smart_dorm`.`dorms`.`dno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`dorms_dcharge_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`dorms_dcharge_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`dorms_dcharge_view` (`dno`,`dcharge`) AS select `smart_dorm`.`dorms`.`dno` AS `dno`,`smart_dorm`.`dorms`.`dcharge` AS `dcharge` from `smart_dorm`.`dorms` order by `smart_dorm`.`dorms`.`dno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`dorms_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`dorms_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`dorms_view` (`dno`,`dsize`,`dcharge`,`buildings_bno`) AS select `smart_dorm`.`dorms`.`dno` AS `dno`,`smart_dorm`.`dorms`.`dsize` AS `dsize`,`smart_dorm`.`dorms`.`dcharge` AS `dcharge`,`smart_dorm`.`dorms`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`dorms` order by `smart_dorm`.`dorms`.`dno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`hygienes_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`hygienes_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`hygienes_view` (`hno`,`sdate`,`hgrade`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`hygienes`.`hno` AS `hno`,`smart_dorm`.`hygienes`.`sdate` AS `sdate`,`smart_dorm`.`hygienes`.`hgrade` AS `hgrade`,`smart_dorm`.`hygienes`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`hygienes`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`hygienes` order by `smart_dorm`.`hygienes`.`hno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`leave_applications_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`leave_applications_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`leave_applications_view` (`leaveno`,`sdate`,`edate`,`leavedate`,`backdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`leave_applications`.`leaveno` AS `leaveno`,`smart_dorm`.`leave_applications`.`sdate` AS `sdate`,`smart_dorm`.`leave_applications`.`edate` AS `edate`,`smart_dorm`.`leave_applications`.`leavedate` AS `leavedate`,`smart_dorm`.`leave_applications`.`backdate` AS `backdate`,`smart_dorm`.`leave_applications`.`state` AS `state`,`smart_dorm`.`leave_applications`.`reason` AS `reason`,`smart_dorm`.`leave_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`leave_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`leave_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`leave_applications` order by `smart_dorm`.`leave_applications`.`leaveno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`leave_applications_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`leave_applications_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`leave_applications_view_01` (`leaveno`,`sdate`,`edate`,`leavedate`,`backdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`leave_applications`.`leaveno` AS `leaveno`,`smart_dorm`.`leave_applications`.`sdate` AS `sdate`,`smart_dorm`.`leave_applications`.`edate` AS `edate`,`smart_dorm`.`leave_applications`.`leavedate` AS `leavedate`,`smart_dorm`.`leave_applications`.`backdate` AS `backdate`,`smart_dorm`.`leave_applications`.`state` AS `state`,`smart_dorm`.`leave_applications`.`reason` AS `reason`,`smart_dorm`.`leave_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`leave_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`leave_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`leave_applications` where (`smart_dorm`.`leave_applications`.`edate` is null) order by `smart_dorm`.`leave_applications`.`leaveno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`leave_applications_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`leave_applications_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`leave_applications_view_02` (`leaveno`,`sdate`,`edate`,`leavedate`,`backdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`leave_applications`.`leaveno` AS `leaveno`,`smart_dorm`.`leave_applications`.`sdate` AS `sdate`,`smart_dorm`.`leave_applications`.`edate` AS `edate`,`smart_dorm`.`leave_applications`.`leavedate` AS `leavedate`,`smart_dorm`.`leave_applications`.`backdate` AS `backdate`,`smart_dorm`.`leave_applications`.`state` AS `state`,`smart_dorm`.`leave_applications`.`reason` AS `reason`,`smart_dorm`.`leave_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`leave_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`leave_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`leave_applications` where (`smart_dorm`.`leave_applications`.`edate` is not null) order by `smart_dorm`.`leave_applications`.`leaveno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`repair_applications_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`repair_applications_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`repair_applications_view` (`repairno`,`itemname`,`sdate`,`edate`,`repairdate`,`reason`,`state`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`repair_applications`.`repairno` AS `repairno`,`smart_dorm`.`repair_applications`.`itemname` AS `itemname`,`smart_dorm`.`repair_applications`.`sdate` AS `sdate`,`smart_dorm`.`repair_applications`.`edate` AS `edate`,`smart_dorm`.`repair_applications`.`repairdate` AS `repairdate`,`smart_dorm`.`repair_applications`.`reason` AS `reason`,`smart_dorm`.`repair_applications`.`state` AS `state`,`smart_dorm`.`repair_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`repair_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`repair_applications` order by `smart_dorm`.`repair_applications`.`repairno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`repair_applications_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`repair_applications_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`repair_applications_view_01` (`repairno`,`itemname`,`sdate`,`edate`,`repairdate`,`reason`,`state`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`repair_applications`.`repairno` AS `repairno`,`smart_dorm`.`repair_applications`.`itemname` AS `itemname`,`smart_dorm`.`repair_applications`.`sdate` AS `sdate`,`smart_dorm`.`repair_applications`.`edate` AS `edate`,`smart_dorm`.`repair_applications`.`repairdate` AS `repairdate`,`smart_dorm`.`repair_applications`.`reason` AS `reason`,`smart_dorm`.`repair_applications`.`state` AS `state`,`smart_dorm`.`repair_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`repair_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`repair_applications` where (`smart_dorm`.`repair_applications`.`edate` is null) order by `smart_dorm`.`repair_applications`.`repairno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`repair_applications_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`repair_applications_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`repair_applications_view_02` (`repairno`,`itemname`,`sdate`,`edate`,`repairdate`,`reason`,`state`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`repair_applications`.`repairno` AS `repairno`,`smart_dorm`.`repair_applications`.`itemname` AS `itemname`,`smart_dorm`.`repair_applications`.`sdate` AS `sdate`,`smart_dorm`.`repair_applications`.`edate` AS `edate`,`smart_dorm`.`repair_applications`.`repairdate` AS `repairdate`,`smart_dorm`.`repair_applications`.`reason` AS `reason`,`smart_dorm`.`repair_applications`.`state` AS `state`,`smart_dorm`.`repair_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`repair_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`repair_applications` where (`smart_dorm`.`repair_applications`.`edate` is not null) order by `smart_dorm`.`repair_applications`.`repairno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`staying_applications_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`staying_applications_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`staying_applications_view` (`stayingno`,`sdate`,`edate`,`stayingdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`staying_applications`.`stayingno` AS `stayingno`,`smart_dorm`.`staying_applications`.`sdate` AS `sdate`,`smart_dorm`.`staying_applications`.`edate` AS `edate`,`smart_dorm`.`staying_applications`.`stayingdate` AS `stayingdate`,`smart_dorm`.`staying_applications`.`state` AS `state`,`smart_dorm`.`staying_applications`.`reason` AS `reason`,`smart_dorm`.`staying_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`staying_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`staying_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`staying_applications` order by `smart_dorm`.`staying_applications`.`stayingno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`staying_applications_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`staying_applications_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`staying_applications_view_01` (`stayingno`,`sdate`,`edate`,`stayingdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`staying_applications`.`stayingno` AS `stayingno`,`smart_dorm`.`staying_applications`.`sdate` AS `sdate`,`smart_dorm`.`staying_applications`.`edate` AS `edate`,`smart_dorm`.`staying_applications`.`stayingdate` AS `stayingdate`,`smart_dorm`.`staying_applications`.`state` AS `state`,`smart_dorm`.`staying_applications`.`reason` AS `reason`,`smart_dorm`.`staying_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`staying_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`staying_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`staying_applications` where (`smart_dorm`.`staying_applications`.`edate` is null) order by `smart_dorm`.`staying_applications`.`stayingno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`staying_applications_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`staying_applications_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`staying_applications_view_02` (`stayingno`,`sdate`,`edate`,`stayingdate`,`state`,`reason`,`students_sno`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`staying_applications`.`stayingno` AS `stayingno`,`smart_dorm`.`staying_applications`.`sdate` AS `sdate`,`smart_dorm`.`staying_applications`.`edate` AS `edate`,`smart_dorm`.`staying_applications`.`stayingdate` AS `stayingdate`,`smart_dorm`.`staying_applications`.`state` AS `state`,`smart_dorm`.`staying_applications`.`reason` AS `reason`,`smart_dorm`.`staying_applications`.`students_sno` AS `students_sno`,`smart_dorm`.`staying_applications`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`staying_applications`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`staying_applications` where (`smart_dorm`.`staying_applications`.`edate` is not null) order by `smart_dorm`.`staying_applications`.`stayingno`;

-- -----------------------------------------------------
-- View `smart_dorm`.`students_access_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`students_access_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`students_access_view` (`sno`,`access`) AS select `smart_dorm`.`students`.`sno` AS `sno`,`smart_dorm`.`students`.`access` AS `access` from `smart_dorm`.`students` order by `smart_dorm`.`students`.`sno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`students_dorms_view_01`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`students_dorms_view_01`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`students_dorms_view_01` (`sno`,`dorms_dno`,`buildings_bno`,`state`) AS select `smart_dorm`.`students`.`sno` AS `sno`,`smart_dorm`.`students`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`students`.`buildings_bno` AS `buildings_bno`,`smart_dorm`.`students`.`state` AS `state` from `smart_dorm`.`students` where ((`smart_dorm`.`students`.`dorms_dno` is null) and (`smart_dorm`.`students`.`buildings_bno` is null)) order by `smart_dorm`.`students`.`sno`,`smart_dorm`.`students`.`state`;

-- -----------------------------------------------------
-- View `smart_dorm`.`students_dorms_view_02`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`students_dorms_view_02`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`students_dorms_view_02` (`sno`,`dorms_dno`,`buildings_bno`,`state`) AS select `smart_dorm`.`students`.`sno` AS `sno`,`smart_dorm`.`students`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`students`.`buildings_bno` AS `buildings_bno`,`smart_dorm`.`students`.`state` AS `state` from `smart_dorm`.`students` where (`smart_dorm`.`students`.`dorms_dno` is not null) order by `smart_dorm`.`students`.`buildings_bno`,`smart_dorm`.`students`.`dorms_dno`,`smart_dorm`.`students`.`sno`,`smart_dorm`.`students`.`state`;

-- -----------------------------------------------------
-- View `smart_dorm`.`students_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`students_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`students_view` (`sno`,`sname`,`stel`,`scol`,`sdept`,`sclass`,`ssex`,`state`,`access`,`dorms_dno`,`buildings_bno`) AS select `smart_dorm`.`students`.`sno` AS `sno`,`smart_dorm`.`students`.`sname` AS `sname`,`smart_dorm`.`students`.`stel` AS `stel`,`smart_dorm`.`students`.`scol` AS `scol`,`smart_dorm`.`students`.`sdept` AS `sdept`,`smart_dorm`.`students`.`sclass` AS `sclass`,`smart_dorm`.`students`.`ssex` AS `ssex`,`smart_dorm`.`students`.`state` AS `state`,`smart_dorm`.`students`.`access` AS `access`,`smart_dorm`.`students`.`dorms_dno` AS `dorms_dno`,`smart_dorm`.`students`.`buildings_bno` AS `buildings_bno` from `smart_dorm`.`students` order by `smart_dorm`.`students`.`sno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`users_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`users_view`;
USE `smart_dorm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `smart_dorm`.`users_view` (`uno`,`upass`,`utype`) AS select `smart_dorm`.`users`.`uno` AS `uno`,`smart_dorm`.`users`.`upass` AS `upass`,`smart_dorm`.`users`.`utype` AS `utype` from `smart_dorm`.`users` order by `smart_dorm`.`users`.`uno` WITH CASCADED CHECK OPTION;

-- -----------------------------------------------------
-- View `smart_dorm`.`counselors_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smart_dorm`.`counselors_view`;
USE `smart_dorm`;
CREATE  OR REPLACE VIEW `counselors_view`
(fno, fname, ftel, fcol, fdept, fsex)
AS
select fno, fname, ftel, fcol, fdept, fsex
from counselors
order by fno asc
with check option;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `smart_dorm`.`admins`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`admins` (`wno`, `wname`, `wsex`, `wtel`) VALUES ('00000001', '梅咏', '女', '18012345671');
INSERT INTO `smart_dorm`.`admins` (`wno`, `wname`, `wsex`, `wtel`) VALUES ('00000002', '肖骁', '男', '18012345672');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`buildings`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`buildings` (`bno`, `bname`, `baddr`, `poweroff`) VALUES ('F01', '一舍', '浑南校区', 'never');
INSERT INTO `smart_dorm`.`buildings` (`bno`, `bname`, `baddr`, `poweroff`) VALUES ('F05', '五舍', '浑南校区', '23:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`admins_has_buildings`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`admins_has_buildings` (`admins_wno`, `buildings_bno`) VALUES ('00000001', 'F01');
INSERT INTO `smart_dorm`.`admins_has_buildings` (`admins_wno`, `buildings_bno`) VALUES ('00000002', 'F05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`announces`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`announces` (`announceno`, `sdate`, `title`, `text`, `buildings_bno`, `admins_wno`) VALUES ('A20230426001', '2023-04-26', '东北大学关于做好劳动节假期学生安全稳定的工作提示', '安全！安全！安全！', 'F01', '00000001');
INSERT INTO `smart_dorm`.`announces` (`announceno`, `sdate`, `title`, `text`, `buildings_bno`, `admins_wno`) VALUES ('A20230426002', '2023-04-26', '《崩坏：白山黑水》今日正式上线', '东北大学学生张浩霖自主研制的项目《崩坏：白山黑水》今日正式上线，获得国内外高度认可。', 'F05', '00000002');
INSERT INTO `smart_dorm`.`announces` (`announceno`, `sdate`, `title`, `text`, `buildings_bno`, `admins_wno`) VALUES ('A20230204001', '2023-02-04', '中科院院士刘根润到访东北大学发布重要讲话', '刘院士指出：东北大学是一所具有爱国主义优良传统的大学。', 'F05', '00000002');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`dorms`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010201', 4, 0, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010202', 4, 0, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010301', 4, 100, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010302', 4, 200, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010303', 4, -100, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F010304', 4, 0, 'F01');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F051101', 4, -100, 'F05');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F051103', 4, -200, 'F05');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F051105', 4, 0, 'F05');
INSERT INTO `smart_dorm`.`dorms` (`dno`, `dsize`, `dcharge`, `buildings_bno`) VALUES ('F051107', 4, -600, 'F05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`students`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200001', '小麒', '18012345601', '计算机科学与技术', '计算机科学与工程学院', '01', '女', '在校', '001', 'F010201', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200002', '小慎', '18012345602', '计算机科学与技术', '计算机科学与工程学院', '01', '女', '在校', '001', 'F010201', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200003', '小晨', '18012345603', '计算机科学与技术', '计算机科学与工程学院', '01', '女', '在校', '001', 'F010201', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200004', '小璇', '18012345604', '计算机科学与技术', '计算机科学与工程学院', '01', '女', '在校', '001', 'F010201', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200005', '小杨', '18012345605', '计算机科学与技术', '计算机科学与工程学院', '02', '女', '在校', '001', 'F010202', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200006', '小珺', '18012345606', '计算机科学与技术', '计算机科学与工程学院', '02', '女', '在校', '001', 'F010202', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200007', '小然', '18012345607', '计算机科学与技术', '计算机科学与工程学院', '02', '女', '在校', '001', 'F010202', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200008', '小霖', '18012345608', '计算机科学与技术', '计算机科学与工程学院', '02', '女', '在校', '001', 'F010202', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200009', '小齐', '18012345609', '计算机科学与技术', '计算机科学与工程学院', '03', '女', '在校', '001', 'F010301', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200010', '小佳', '18012345610', '计算机科学与技术', '计算机科学与工程学院', '03', '女', '在校', '001', 'F010301', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200011', '小骏', '18012345611', '计算机科学与技术', '计算机科学与工程学院', '03', '女', '在校', '001', 'F010301', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200012', '小和', '18012345612', '计算机科学与技术', '计算机科学与工程学院', '03', '女', '在校', '001', 'F010301', 'F01');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200013', '小卓', '18012345613', '计算机科学与技术', '计算机科学与工程学院', '04', '男', '在校', '001', 'F051101', 'F05');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200014', '小瑜', '18012345614', '计算机科学与技术', '计算机科学与工程学院', '04', '男', '在校', '001', 'F051101', 'F05');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200015', '小凡', '18012345615', '计算机科学与技术', '计算机科学与工程学院', '04', '男', '在校', '001', 'F051101', 'F05');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200016', '小沈', '18012345616', '计算机科学与技术', '计算机科学与工程学院', '04', '男', '请假离校', '001', 'F051101', 'F05');
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200017', '小峥', '18012345617', '物联网工程', '计算机科学与工程学院', '01', '男', '未分配宿舍', '001', NULL, NULL);
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200018', '小阮', '18012345618', '物联网工程', '计算机科学与工程学院', '01', '男', '未分配宿舍', '001', NULL, NULL);
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200019', '小桐', '18012345619', '物联网工程', '计算机科学与工程学院', '01', '男', '未分配宿舍', '001', NULL, NULL);
INSERT INTO `smart_dorm`.`students` (`sno`, `sname`, `stel`, `sdept`, `scol`, `sclass`, `ssex`, `state`, `access`, `dorms_dno`, `buildings_bno`) VALUES ('20200020', '小哲', '18012345620', '物联网工程', '计算机科学与工程学院', '01', '男', '未分配宿舍', '001', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`changedorm_applications`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`changedorm_applications` (`changedormno`, `sdate`, `edate`, `changedormdate`, `state`, `reason`, `students_sno`, `dorms_dno`, `buildings_bno`) VALUES ('D20220203001', '2022-02-03', NULL, '2022-02-06', '未处理', '想换宿舍', '20200003', 'F010201', 'F01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`checkout_applications`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`checkout_applications` (`checkoutno`, `sdate`, `edate`, `checkoutdate`, `state`, `reason`, `students_sno`, `dorms_dno`, `buildings_bno`) VALUES ('C20220203001', '2022-02-03', NULL, '2022-02-05', '未处理', '不想住了', '20200001', 'F010201', 'F01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`hygienes`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`hygienes` (`hno`, `sdate`, `hgrade`, `dorms_dno`, `buildings_bno`) VALUES ('H20220203001', '2022-02-03', 98, 'F010201', 'F01');
INSERT INTO `smart_dorm`.`hygienes` (`hno`, `sdate`, `hgrade`, `dorms_dno`, `buildings_bno`) VALUES ('H20220203002', '2022-02-03', 89, 'F010202', 'F01');
INSERT INTO `smart_dorm`.`hygienes` (`hno`, `sdate`, `hgrade`, `dorms_dno`, `buildings_bno`) VALUES ('H20220204001', '2022-02-04', 30, 'F010201', 'F01');
INSERT INTO `smart_dorm`.`hygienes` (`hno`, `sdate`, `hgrade`, `dorms_dno`, `buildings_bno`) VALUES ('H20220204002', '2022-02-04', 20, 'F010202', 'F01');
INSERT INTO `smart_dorm`.`hygienes` (`hno`, `sdate`, `hgrade`, `dorms_dno`, `buildings_bno`) VALUES ('H20220204003', '2022-02-04', 100, 'F051101', 'F05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`leave_applications`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`leave_applications` (`leaveno`, `sdate`, `edate`, `leavedate`, `backdate`, `state`, `reason`, `students_sno`, `dorms_dno`, `buildings_bno`) VALUES ('L20220203001', '2022-02-03', NULL, '2022-02-05', '2022-06-10', '未处理', '家里有事', '20200004', 'F010201', 'F01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`repair_applications`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`repair_applications` (`repairno`, `itemname`, `sdate`, `edate`, `repairdate`, `reason`, `state`, `dorms_dno`, `buildings_bno`) VALUES ('R20220203001', '空调', '2022-02-03', '2022-02-06', '2022-02-07', '想装空调', '同意', 'F010201', 'F01');
INSERT INTO `smart_dorm`.`repair_applications` (`repairno`, `itemname`, `sdate`, `edate`, `repairdate`, `reason`, `state`, `dorms_dno`, `buildings_bno`) VALUES ('R20220203002', '暖气', '2022-02-03', NULL, '2022-02-07', '暖气不热', '未处理', 'F051101', 'F05');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`staying_applications`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`staying_applications` (`stayingno`, `sdate`, `edate`, `stayingdate`, `state`, `reason`, `students_sno`, `dorms_dno`, `buildings_bno`) VALUES ('T20220203001', '2022-02-03', NULL, '2022-06-01', '未处理', '想留校', '20200002', 'F010201', 'F01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200001', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200002', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200003', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200004', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200005', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200006', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200007', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200008', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200009', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200010', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200011', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200012', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200013', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200014', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200015', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200016', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200017', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200018', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200019', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('20200020', 'e10adc3949ba59abbe56e057f20f883e', '学生');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('00001001', 'e10adc3949ba59abbe56e057f20f883e', '辅导员');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('00001002', 'e10adc3949ba59abbe56e057f20f883e', '辅导员');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('00000001', 'e10adc3949ba59abbe56e057f20f883e', '宿舍管理员');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('00000002', 'e10adc3949ba59abbe56e057f20f883e', '宿舍管理员');
INSERT INTO `smart_dorm`.`users` (`uno`, `upass`, `utype`) VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员');

COMMIT;


-- -----------------------------------------------------
-- Data for table `smart_dorm`.`counselors`
-- -----------------------------------------------------
START TRANSACTION;
USE `smart_dorm`;
INSERT INTO `smart_dorm`.`counselors` (`fno`, `fname`, `ftel`, `fcol`, `fdept`, `fsex`) VALUES ('00001001', '宋宁宁', '18012345681', '计算机科学与工程学院', '计算机科学与技术', '女');
INSERT INTO `smart_dorm`.`counselors` (`fno`, `fname`, `ftel`, `fcol`, `fdept`, `fsex`) VALUES ('00001002', '李东海', '18012345682', '计算机科学与工程学院', '物联网工程', '男');

COMMIT;

