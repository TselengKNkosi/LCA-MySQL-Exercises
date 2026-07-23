-- SPECIFYING DATABASE WE'RE WORKING WITH
USE edutrack_sa;

-- ADDING ADDITIONAL RECORDS IN TABLES FOR LOGIC TESTING 
-- TRAINEES TABLE DATA
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Susan', 'De Wil', 'susan.devil@unisa.co.za', 'Free State');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Tumelo', 'Rasethaba', 'tumeloRasethaba@icloud.com', 'North West');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Lathitha', 'Dima', 'dima.lathi@sanlam.co.za', 'Western Cape');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Michael', 'White', 'michaelwhite03@gmail.com', 'Gauteng');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Kgomotso', 'Padi', 'padi.kgomotso@sabc.co.za', 'Gauteng');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Devin', 'Boos', 'devinboos@outlook.co.za', 'North West');
INSERT INTO `trainees` 
 (`first_name`, `last_name`, `email`, `province`) 
 VALUES ('Gabriella', 'Oosthuisen', 'g.ootshuisen@icloud.com', 'Free State');

-- FACILITATORS TABLE DATA 
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Olivia', 'Morgan', 'olivia.morgan@edutrack.com', '+27 82 901-2345');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Caroline', 'Nkosi', 'caroline.nkosi@edutrack.com', '+27 82 678-9012');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Blessing', 'Gumede', 'blessing.gumede@edutrack.com', '+27 60 345-6789');
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('Dumisane', 'Duma', 'dumisane.duma@edutrack.com', '+27 60 012-3456');
 
-- COURSES TABLE DATA 
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Introduction to Psychology', '8', '6');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Research in Psychology', '7', '9');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Statistic I', '6', '7');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Database Fundamentals', '8', '2');
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Research in Organisational Psychology', '7', '6');
 
-- ENROLMENTS TABLE DATA 

INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('9', '6', '2026-07-05', 'Active');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('10', '7', '2026-05-18', 'Withdrawn');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('10', '2', '2026-06-02', 'Active');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('13', '9', '2026-07-20', 'Active');
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES ('15', '5', '2026-04-15', 'Completed');

-- SORTING
-- ALL TRAINEES ORDERED BY SURNAME
SELECT * FROM trainees ORDER BY last_name;

-- ALL COURSES ORDERED BY DURATION 
SELECT * FROM courses ORDER BY duration_weeks;

-- 3 MOST RECENT ENROLMENTS
SELECT * FROM enrolments ORDER BY enrolment_date DESC LIMIT 3;

-- 2ND AND 3RD MOST RECENTLY ENROLLED RECORDS 
SELECT * FROM enrolments 
ORDER BY enrolment_date DESC 
LIMIT 2 OFFSET 1;

-- FILTERING 
-- ALL TRAINEES FROM GAUTENG
SELECT * FROM trainees 
WHERE province = 'Gauteng';

-- EVERYONE WHOSE FIRST NAME STARTS WITH A 'M' (BOTH FACILITATORS AND TRAINEES - ONE LIST)
SELECT first_name, last_name, email, 'Trainee' AS role 
FROM trainees
WHERE first_name LIKE 'M%'

UNION 

SELECT first_name, last_name, email, 'Facilitator' AS role
FROM facilitators 
WHERE first_name LIKE 'M%';

-- COURSES THAT ARE LESS THAN 7 WEEKS LONG 
SELECT * FROM courses
WHERE duration_weeks < 7;

-- EVERYONE WITH AN ACTIVE ENROLMENT STATUS 
SELECT * 
FROM enrolments e
JOIN trainees t ON e.fk_trainee_id = t.trainee_id
WHERE status = 'Active';

-- ALL TRAINEES WHOSE EMAILS END IN '.co.za'
SELECT * FROM trainees
WHERE email LIKE '%.co.za';

-- FACILITATORS AND THE NUMBER OF COURSES THEY FACILITATE ( > 1 )
SELECT f.facilitator_id, CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name,
 COUNT(c.course_id) AS course_count
FROM facilitators f
JOIN courses c ON f.facilitator_id = c.fk_facilitator_id
GROUP BY f.facilitator_id, f.first_name, f.last_name
HAVING COUNT(c.course_id) > 1
ORDER BY course_count DESC;

-- AGGREGATES
-- TOTAL TRAINEE COUNT
SELECT COUNT(*) AS total_trainees FROM trainees;

-- AVERAGE COURSE DURATION 
SELECT ROUND(AVG(duration_weeks), 2) AS average_course_duration FROM courses;
-- LONGEST COURSE DURATION 
SELECT MAX(duration_weeks) AS longest_course_duration FROM courses;

-- ENROLMENT COUNT PER COURSE 
SELECT c.course_id, c.course_name, COUNT(e.enrolment_id) AS enrolment_count
FROM courses c
LEFT JOIN enrolments e ON c.course_id = e.fk_course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrolment_count DESC;

-- GROUPING 
-- TRAINEE COUNT PER PROVINCE 
SELECT province, COUNT(*) AS trainee_count
FROM trainees
GROUP BY province
ORDER BY trainee_count DESC;

-- PROVINCES THAT HAVE MORE THAN ONE TRAINEE 
SELECT province, COUNT(*) AS trainee_count
FROM trainees
GROUP BY province
HAVING COUNT(*) > 1
ORDER BY trainee_count DESC;
