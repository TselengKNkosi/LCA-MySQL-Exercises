CREATE DATABASE `edutrack_sa`;

-- CREATING FACILITATORS TABLE
CREATE TABLE `edutrack_sa`.`facilitators` (
  `facilitator_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`facilitator_id`),
  -- UNIQUE EMAIL
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);
  
-- CREATING COURSES TABLE
USE `edutrack_sa`;
CREATE TABLE `courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `duration_weeks` INT NULL,
  `fk_facilitator_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  -- ATTACHING FOREIGN KEY
  CONSTRAINT `fk_facilitator_id`
    FOREIGN KEY (`fk_facilitator_id`)
    REFERENCES `facilitators` (facilitator_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
-- CREATING TRAINEES TABLE
CREATE TABLE `trainees` (
  `trainee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(125) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`trainee_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);
  
-- CREATING ENROLMENT TABLE
CREATE TABLE `enrolments` (
 `enrolment_id` INT NOT NULL AUTO_INCREMENT,
 `fk_trainee_id` INT NOT NULL,
 `fk_course_id` INT NOT NULL,
 `enrolment_date` DATE NOT NULL,
 `status` ENUM('Active', 'Completed', 'Withdrawn') DEFAULT 'Active',
 PRIMARY KEY (`enrolment_id`),
 -- ATTACHING FOREIGN KEYS
 CONSTRAINT `fk_trainee_id`
   FOREIGN KEY (`fk_trainee_id`)
   REFERENCES `trainees` (trainee_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
 CONSTRAINT `fk_course_id`
   FOREIGN KEY (`fk_course_id`)
   REFERENCES `courses` (course_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE);

-- TIMESTAMPS FOR TRAINEE AND ENROLMENT TABLES
ALTER TABLE `trainees`
 ADD `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `enrolments`
 ADD `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
 
-- INSERTING DATA INTO EACH TABLE

-- FACILITATORS TABLE DATA
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Lebo', 'Sithole', 'lebo.sithole@edutrack.com', '+27 82 123-4567');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Michael', 'Nkosi', 'michael.nkosi@edutrack.com', '+27 82 890-1234');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Meagan', 'De Toit', 'meagan.detoit@edutrack.com', '+27 82 567-8901');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Bongani', 'Phatsi', 'bongani.phatsi@edutrack.com', '+27 82 234-5678');
 
-- COURSES TABLE DATA
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Intro to Data Science', '6', '2');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Statistics II', '8', '4');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Intro to Cloud Computing', '5', '1');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Python 101', '3', '4');
 
-- TRAINEE TABLE DATA
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Katleho', 'Setona', 'katleho.setona@gmail.com', 'Free State');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Steven', 'Odendaal', 'steveoden.daal@gmail.com', 'Western Cape');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Mikayla', 'Rose', 'rose.amikayla02@icloud.com', 'Gauteng');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('James', 'Chakane', 'jameschaka@outlook.com', 'Gauteng');

-- ENROLMENT TABLE DATA
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('1', '3', '2026/06/10', 'Active');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('2', '2', '2026/06/15', 'Active');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('3', '1', '2026/05/11', 'Completed');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('4', '2', '2026/05/25', 'Completed');
 
-- VERIFICATION SELECT QUERIES TO ENSURE TABLE DATA WAS INSERTED CORRECTLY
SELECT * FROM facilitators;
SELECT * FROM courses;
SELECT * FROM trainees;
SELECT * FROM enrolments;