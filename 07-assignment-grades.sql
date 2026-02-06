-- ENSEIGNANT NOTES /pages/teachers/grades
-- Listes des notes des etudiants pour un travail
--
-- Récupérer les notes du travail @assignment_id de l'enseignant @teacher_id
--
-- Trier par nom d'étudiant croissant
-- 
-- +------------+--------------+----------------+
-- | student_id | student_name | student_points |
-- +------------+--------------+----------------+
-- |      20201 | AAA          |           NULL |
-- |      20202 | BBB          |              3 |
-- |      20203 | CCC          |              5 |
-- |      20204 | DDD          |              2 |
-- |      20205 | EEE          |              9 |
-- |      20206 | FFF          |             10 |
-- |      20207 | GGG          |              7 |
-- |      20208 | HHH          |              8 |
-- |      20209 | III          |              2 |
-- |      20200 | JJJ          |              6 |
-- +------------+--------------+----------------+
--

SET @assignment_id = 1;
SET @teacher_id = 1;
SELECT  s.id as student_id, s.name AS student_name, g.points as student_points
FROM grades g
left JOIN students s ON g.student_id = s.id
left JOIN assignments a ON g.assignment_id = a.id
left JOIN groups gr ON a.group_number = gr.number 
                AND a.group_semester = gr.semester 
                AND a.group_course = gr.course_code
WHERE a.id = @assignment_id
  AND gr.teacher_employee_number = @teacher_id
ORDER BY s.name ASC;
