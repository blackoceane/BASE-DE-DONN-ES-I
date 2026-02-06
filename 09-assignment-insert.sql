-- ENSEIGNANT NOUVEAU TRAVAIL
--
-- Insérer un travail avec les données @name, @weight, @points, @date 
-- pour le groupe @group, @semester, @code et enseigné par @teacher_id
--
SET @name = 'Projet 55';
SET @weight =10 ;
SET @points =70 ;
SET @date = '2020-12-15';
SET @group = 1;
SET @semester = 'A2020' ;
SET @code = '420-0Q4-SW';
SET @teacher_id = 1 ;

INSERT INTO assignments (name, weight, points, dte, group_semester, group_course, group_number)
VALUES (@name, @weight, @points, @date, @semester, @code, @group);
