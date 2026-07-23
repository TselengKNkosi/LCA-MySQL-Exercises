-- SPECIFYING DATABASE 
USE edutrack_sa;

-- INNER JOIN :
-- ENROLMENT LIST (TRAINEES, ENROLMENTS, COURSES)
SELECT t.trainee_id, CONCAT(t.first_name, ' ', t.last_name) AS trainee_name,
  e.enrolment_date,
  e.status,
  c.course_name,
  c.duration_weeks
FROM trainees t
INNER JOIN enrolments e ON t.trainee_id = e.fk_trainee_id
INNER JOIN courses c ON e.fk_course_id = c.course_id
ORDER BY t.trainee_id, e.enrolment_date;

-- COURSE AND FACILITATOR NAME PAIRING 
SELECT c.course_id, c.course_name, c.duration_weeks, CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name,
  f.email,
  f.phone
FROM courses c
INNER JOIN facilitators f ON c.fk_facilitator_id = f.facilitator_id
ORDER BY c.course_id;

-- LEFT JOIN :
-- FULL TRAINEE LIST WITH COURSES
SELECT t.trainee_id, CONCAT(t.first_name, ' ', t.last_name) AS trainee_name,
  t.email,
  t.province,
  c.course_name,
  e.enrolment_date,
  e.status
FROM trainees t
LEFT JOIN enrolments e ON t.trainee_id = e.fk_trainee_id
LEFT JOIN courses c ON e.fk_course_id = c.course_id
ORDER BY t.trainee_id, e.enrolment_date;

-- RIGHT JOIN :
-- FULL COURSE LIST WITH TRAINEES
SELECT c.course_id, c.course_name, c.duration_weeks, CONCAT(t.first_name, ' ', t.last_name) AS trainee_name,
  e.enrolment_date,
  e.status
FROM trainees t
RIGHT JOIN enrolments e ON t.trainee_id = e.fk_trainee_id
RIGHT JOIN courses c ON e.fk_course_id = c.course_id
ORDER BY c.course_id, e.enrolment_date;

-- DATA MANIPULATION : 
-- UPDATE - CHANGING TRAINEE PROVINCE
-- Updating Michael White's province from 'Gauteng' to 'Western Cape'
UPDATE trainees
SET province = 'Western Cape'
WHERE trainee_id = 12 AND first_name = 'Michael';

-- UPDATE - CHANGING ENROLMENT STATUS
-- Updating Susan De Wil's enrolment status from 'Active' to 'Completed'
UPDATE enrolments
SET status = 'Completed'
WHERE fk_trainee_id = 9 AND status = 'Active';

-- DELETE - REMOVING A SPECIFIC ENROLMENT RECORD
DELETE FROM enrolments
WHERE status = 'Withdrawn'
ORDER BY enrolment_date ASC
LIMIT 1; 

-- MINI CHALLENGE:
-- QUERY COMBINING JOIN, WHERE, GROUP BY, HAVING, ORDER BY
-- Finding facilitators who have more than one course, showing course count and total trainee enrollment
SELECT f.facilitator_id, CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name, 
  COUNT(DISTINCT c.course_id) AS course_count,
  COUNT(DISTINCT e.fk_trainee_id) AS total_trainees
FROM facilitators f
INNER JOIN courses c ON f.facilitator_id = c.fk_facilitator_id
LEFT JOIN enrolments e ON c.course_id = e.fk_course_id
WHERE c.duration_weeks > 0
GROUP BY f.facilitator_id, f.first_name, f.last_name
HAVING COUNT(DISTINCT c.course_id) > 1
ORDER BY course_count DESC, total_trainees DESC;

-- FINDING THE FACILITATOR WITH THE MOST TRAINEES ACROSS ALL THEIR COURSES
SELECT f.facilitator_id, CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name,
  COUNT(DISTINCT c.course_id) AS total_courses,
  COUNT(DISTINCT e.fk_trainee_id) AS total_trainees_enrolled,
  f.email,
  f.phone
FROM facilitators f
INNER JOIN courses c ON f.facilitator_id = c.fk_facilitator_id
LEFT JOIN enrolments e ON c.course_id = e.fk_course_id
GROUP BY f.facilitator_id, f.first_name, f.last_name, f.email, f.phone
ORDER BY total_trainees_enrolled DESC
LIMIT 1;

-- ADDING A NEW FACILITATOR
INSERT INTO `facilitators` 
 (`first_name`, `last_name`, `email`, `phone`) 
 VALUES ('James', 'Thompson', 'james.thompson@edutrack.com', '+27 71 555-6789');

-- CREATING A NEW COURSE ATTACHED TO THE NEW FACILITATOR
INSERT INTO `courses` 
 (`course_name`, `duration_weeks`, `fk_facilitator_id`) 
 VALUES ('Advanced Web Development', '10', 10);

-- ENROLLING EXISTING TRAINEES TO NEW COURSE 
INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES (9, 10, '2026-07-23', 'Active');

INSERT INTO `enrolments` 
 (`fk_trainee_id`, `fk_course_id`, `enrolment_date`, `status`) 
 VALUES (12, 10, '2026-07-23', 'Active');

-- VERIFICATION SELECT QUERY
SELECT f.facilitator_id, CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name,
  c.course_name, CONCAT(t.first_name, ' ', t.last_name) AS trainee_name,
  e.status
FROM facilitators f
INNER JOIN courses c ON f.facilitator_id = c.fk_facilitator_id
LEFT JOIN enrolments e ON c.course_id = e.fk_course_id
LEFT JOIN trainees t ON e.fk_trainee_id = t.trainee_id
WHERE f.facilitator_id = 10
ORDER BY c.course_id, t.trainee_id;