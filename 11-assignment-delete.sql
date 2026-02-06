-- ENSEIGNANT SUPPRESSION TRAVAIL
--
-- Supprimer le travail identifié par @assignment_id et appartenant à l'enseignant @teacher_id
--

SET @assignment_id = 1;
SET @teacher_id =1 ;
DELETE a
FROM assignments a
JOIN groups g ON a.group_number = g.number 
              AND a.group_semester = g.semester 
              AND a.group_course = g.course_code
WHERE a.id = @assignment_id
  AND g.teacher_employee_number = @teacher_id;
