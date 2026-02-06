-- ETUDIANT NOTES
-- Tableau recapitulatif des resultats d'une session
--
-- Encapsuler cette requête dans la VUE students_grades
--     Récupérer les notes des étudiants avec les informations adjacentes
--          note: student_id, points AS `grade`
--          travail: semester, name, points, weight, date, percent(résultant en % de l'étudiant)
--          cours: code, course_name
--          enseignant: teacher_name
--          Ajouter la colonne average qui donne la note moyenne du travail en % pour le groupe
--     Trier par code et date croissant
--
-- +------------+----------+-------+-------------------+--------+--------+------------+---------+------------+-----------------------------+--------------+---------+
-- | student_id | semester | grade | name              | points | weight | date       | percent | code       | course_name                 | teacher_name | average |
-- +------------+----------+-------+-------------------+--------+--------+------------+---------+------------+-----------------------------+--------------+---------+
-- |          2 | A2020    |     5 | TP 1              |     10 |     40 | 2020-10-01 | 50.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          4 | A2020    |     0 | TP 1              |     10 |     40 | 2020-10-01 | 0.00    | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          6 | A2020    |    10 | TP 1              |     10 |     40 | 2020-10-01 | 100.00  | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          8 | A2020    |     8 | TP 1              |     10 |     40 | 2020-10-01 | 80.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |         10 | A2020    |     9 | TP 1              |     10 |     40 | 2020-10-01 | 90.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          1 | A2020    |     4 | TP 1              |     10 |     40 | 2020-10-01 | 40.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          3 | A2020    |     3 | TP 1              |     10 |     40 | 2020-10-01 | 30.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          5 | A2020    |     9 | TP 1              |     10 |     40 | 2020-10-01 | 90.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          7 | A2020    |     7 | TP 1              |     10 |     40 | 2020-10-01 | 70.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          9 | A2020    |     2 | TP 1              |     10 |     40 | 2020-10-01 | 20.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 57.00   |
-- |          2 | A2020    |    55 | Final             |    100 |     60 | 2020-12-11 | 55.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 70.40   |
-- ...
-- |          9 | A2020    |    67 | Final             |    100 |     60 | 2020-12-11 | 67.00   | 420-0Q4-SW | Initiation à la profession  | Alice        | 70.40   |
-- |          2 | A2020    |    33 | Projet de session |     40 |    100 | 2020-11-29 | 82.50   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          4 | A2020    |    12 | Projet de session |     40 |    100 | 2020-11-29 | 30.00   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          6 | A2020    |    38 | Projet de session |     40 |    100 | 2020-11-29 | 95.00   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          8 | A2020    |    35 | Projet de session |     40 |    100 | 2020-11-29 | 87.50   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |         10 | A2020    |    32 | Projet de session |     40 |    100 | 2020-11-29 | 80.00   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          1 | A2020    |    35 | Projet de session |     40 |    100 | 2020-11-29 | 87.50   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          3 | A2020    |    24 | Projet de session |     40 |    100 | 2020-11-29 | 60.00   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          5 | A2020    |    21 | Projet de session |     40 |    100 | 2020-11-29 | 52.50   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          7 | A2020    |    40 | Projet de session |     40 |    100 | 2020-11-29 | 100.00  | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- |          9 | A2020    |    19 | Projet de session |     40 |    100 | 2020-11-29 | 47.50   | 420-0SU-SW | Web Client 1                | Bob          | 72.25   |
-- +------------+----------+-------+-------------------+--------+--------+------------+---------+------------+-----------------------------+--------------+---------+
--
-- Utiliser la VUE students_grades et filtrer le résultat en utilisant le @student_id et @semester
--

SET @student_id = 20201;
SET @semester = 'A2020';


CREATE OR REPLACE VIEW students_grades AS
SELECT 
    s.id AS student_id,
    a.group_semester AS semester,
    g.points AS grade,
    a.name,
    a.points,
    a.weight,
    a.dte AS date,
    ROUND((g.points / a.points) * 100, 2) AS percent,
    c.code,
    c.name AS course_name,
    t.name AS teacher_name,
    ROUND(AVG(IFNULL(g2.points / a.points * 100, 0)), 2) AS average
FROM 
    grades g
JOIN 
    assignments a ON g.assignment_id = a.id
JOIN 
    classes cl ON g.student_id = cl.student_id 
                AND cl.group_number = a.group_number 
                AND cl.group_semester = a.group_semester 
                AND cl.group_course = a.group_course
JOIN 
    groups gr ON cl.group_number = gr.number 
              AND cl.group_semester = gr.semester 
              AND cl.group_course = gr.course_code
JOIN 
    courses c ON gr.course_code = c.code
JOIN 
    teachers t ON gr.teacher_employee_number = t.employee_number
JOIN 
    students s ON g.student_id = s.id  -- Ajout de la jointure avec la table students
LEFT JOIN 
    grades g2 ON a.id = g2.assignment_id 
              AND cl.student_id = g2.student_id
WHERE 
    g.student_id IS NOT NULL
GROUP BY 
    s.id, a.id
ORDER BY 
    c.code, a.dte ASC;

SELECT *
FROM students_grades
WHERE student_id = @student_id AND semester = @semester;
