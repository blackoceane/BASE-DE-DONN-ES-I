-- ENSEIGNANT EDITION TRAVAIL
--
-- Mettre à jour le travail @assignment_id enseigné par @teacher_id 
-- avec les données @name, @weight, @points, @date 
--
-- Pour s'assurer que l'enseignant est bien responsable du cours
-- La syntaxe pour plusieurs table du UPDATE peut être utilisée plutôt qu'une sous-requête
--

SET @name = 'EXAMEN_FINAL' ;
SET @weight = 50;
SET @points = 40;
SET @date = '2023-12-16';
SET @assignment_id = 1;
SET @teacher_id = 1;
UPDATE assignments a
 left JOIN groups g on a.group_number = g.number 
              AND a.group_semester = g.semester 
              AND a.group_course = g.course_code
SET 
    a.name = @name,
    a.weight = @weight,
    a.points = @points,
    a.dte = @date
WHERE 
    a.id = @assignment_id
    AND g.teacher_employee_number = @teacher_id;
