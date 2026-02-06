-- ENSEIGNANT TRAVAIL /pages/teachers/assignment
-- Affiche les details d'un travail, si existant, ET le pourcentage restant
--
-- Récupérer le travail @assignment_id s'il appartient à l'enseignant @teacher_id
--      Ajouter la colonne remaining_weight qui calcule 
--      le poids restant à allouer sur 100 pour ce @group, durant la session @semester, du cours @code
--
-- ATTENTION cette requete est utilisée pour afficher le poids restant lors de la CRÉATION d'un travail
-- donc il faut gérer la situation où le @assignment_id est null également
--
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | code       | group | semester | remaining_weight | id   | name | weight | points | date       |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | 420-0Q4-SW |     1 | A2020    |                0 |    1 | TP 1 |     40 |     10 | 2020-10-01 |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
--
--
-- Si en creation, le assignment_id est null, donc les données de l'assignment aussi
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | code       | group | semester | remaining_weight | id   | name | weight | points | date       |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | 420-0Q4-SW |     1 | A2020    |                0 |      |      |        |        |            |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
--
SET @group = 1;
SET @code = '420-0Q4-SW';
SET @semester = 'A2020';
SET @assignment_id = 1;
SET @teacher_id = 1;
SELECT 
    g.course_code AS code,
    g.number AS 'group',
    g.semester,
    100 - COALESCE(SUM(a_all.weight), 0) + COALESCE(a.weight, 0) AS remaining_weight,
    a.id,
    a.name,
    a.weight,
    a.points,
    a.dte AS date
FROM 
    groups g
LEFT JOIN 
    assignments a_all ON g.number = a_all.group_number 
                     AND g.semester = a_all.group_semester 
                     AND g.course_code = a_all.group_course
LEFT JOIN 
    assignments a ON a.id = @assignment_id
WHERE 
    g.teacher_employee_number = @teacher_id
    AND g.number = @group
    AND g.semester = @semester
    AND g.course_code = @code
    AND (a.id = @assignment_id OR @assignment_id IS NULL)
GROUP BY 
    g.course_code, g.number, g.semester, a.id, a.name, a.weight, a.points, a.dte;

