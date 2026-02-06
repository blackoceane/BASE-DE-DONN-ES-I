-- ENSEIGNANT GROUPES /pages/teachers/groups
-- Liste des groupes pour une session de l'enseignant
--
-- Récupérer les groupes de l'enseignant @teacher_id pour la session @semester
--      Ajouter la colonne students qui indique le nombre d'étudiants du groupe
--
-- Trier par code et number croissant
--
-- +--------+------------+-----------------------------+----------+
-- | number | code       | name                        | students |
-- +--------+------------+-----------------------------+----------+
-- |      1 | 420-0Q4-SW | Initiation à la profession  |       11 |
-- |      2 | 420-0SU-SW | Web Client 1                |        0 |
-- +--------+------------+-----------------------------+----------+
--
SET @teacher_id =1 ;
SET @semester = 'A2020';
SELECT g.number, g.course_code, c.name AS course_name, 
       COUNT(cl.student_id) AS students
FROM groups g
JOIN courses c ON g.course_code = c.code
LEFT JOIN classes cl ON g.number = cl.group_number 
                     AND g.semester = cl.group_semester 
                     AND g.course_code = cl.group_course
WHERE g.teacher_employee_number = @teacher_id
  AND g.semester = @semester
GROUP BY g.number, g.course_code, c.name
ORDER BY g.course_code, g.number;
