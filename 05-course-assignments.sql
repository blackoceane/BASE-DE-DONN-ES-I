-- ENSEIGNANT TRAVAUX /pages/teachers/assignments
-- Liste des travaux et statistiques
--
-- Récupérer les travaux du groupe @group pour le cours @code durant la session @semester
-- de l'enseignant @teacher_id
-- Ajouter les colonnes pour chaque travail
--      average calcule les moyenne des notes en % 
--      failed indique le nombre de notes en échec(< 60%)
--      filled indique le nombre de notes saisies(pas NULL) 
--      total indique le nombre total de notes saisies ou non
--
-- Trier par date croissante
--
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
-- | id | name      | weight | points | date       | average | failed | filled | total |
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
-- |  1 | TP 1      |     40 |     10 | 2020-10-01 | 57.78   |      4 |      9 |    10 |
-- |  3 | Formatif  |      0 |      0 | 2020-11-03 | NULL    |      0 |      0 |     0 |
-- |  2 | Final     |     60 |    100 | 2020-12-11 | 70.40   |      3 |     10 |    10 |
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
--
SET @semester = 'A2020';
SET @group = 1;
SET @code = '420-0Q4-SW';
SET @teacher_id = 1;


SELECT 
    a.id,
    a.name,
    a.weight,
    a.points,
    a.dte,
     ROUND( AVG (IFNULL(g.points / a.points * 100, 0)),2) AS average,
    SUM(CASE WHEN g.points / a.points * 100 < 60 THEN 1 ELSE 0 END) AS failed,
    SUM(CASE WHEN g.points IS NOT NULL THEN 1 ELSE 0 END) AS filled,
    COUNT(g.student_id) AS total
FROM 
    assignments a
LEFT JOIN 
    grades g ON a.id = g.assignment_id
WHERE 
    a.group_number = @group
    AND a.group_semester = @semester
    AND a.group_course = @code
    AND a.group_number IN (
        SELECT number 
        FROM groups 
        WHERE teacher_employee_number = @teacher_id
        AND semester = @semester
        AND course_code = @code
    )
GROUP BY 
    a.id
ORDER BY 
    a.dte ASC;

