-- ENSEIGNANT NOTES /pages/teachers/grades
-- Liste deroulante des autres travaux du groupe-cours
--
-- Récupérer les travaux de l'enseignant @teacher_id 
-- dans le même groupe-cours-session que le travail @assignment_id
-- Ajouter les colonnes
--      average qui calcule la moyenne des resultats pour ce travail en %
--      course est le nom du cours(sera toujours le même car on ne récupère que les travaux d'un seul cours)
--
-- Trier par date croissante
--
-- +----+-----------+--------+--------+---------+-----------------------------+
-- | id | name      | points | weight | average | course                      |
-- +----+-----------+--------+--------+---------+-----------------------------+
-- |  1 | TP 1      |     10 |     40 | 57.78   | Initiation à la profession  |
-- |  2 | Final     |    100 |     60 | 70.40   | Initiation à la profession  |
-- +----+-----------+--------+--------+---------+-----------------------------+
--

SET @assignment_id = 1;
SET @teacher_id = 1;


SELECT 
    a.id,
    a.name,
    a.weight,
    a.points,
    a.dte,
    ROUND(AVG(IFNULL(g.points / a.points * 100, 0)), 2) AS average,
    c.name AS course
FROM 
    assignments a
LEFT JOIN 
    grades g ON a.id = g.assignment_id
JOIN 
    courses c ON a.group_course = c.code
JOIN 
    groups gr ON a.group_number = gr.number 
              AND a.group_semester = gr.semester 
              AND a.group_course = gr.course_code
WHERE 
    gr.teacher_employee_number = @teacher_id
    AND (a.group_number ,  a.group_semester, a.group_course) = (
        SELECT group_number, group_semester, group_course
        FROM assignments
        WHERE id = @assignment_id)
    
GROUP BY 
    a.id, a.name, a.weight, a.points, a.dte, c.name
ORDER BY 
    a.dte ASC;

