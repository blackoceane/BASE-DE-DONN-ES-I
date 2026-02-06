-- ENSEIGNANT TRAVAUX /pages/teachers/assignments
-- En-tete affichant le nom du cours et pourcentage restant
--
-- Récupérer le cours identifié par le @group, durant la session @semester, du cours @code par l'enseignant @teacher_id
--      Ajouter la colonne remaining_weight qui calcule le poids restant à allouer sur 100 pour les travaux
--
-- +-----------------------------+------------------+
-- | name                        | remaining_weight |
-- +-----------------------------+------------------+
-- | Initiation à la profession  |                0 |
-- +-----------------------------+------------------+
--
SET @semester = 'A2020';
SET @group = 1;
SET @code = '420-0Q4-SW';
SET @teacher_id = 1;
--
-- NE PAS TOUCHER
--
SELECT courses.name
FROM courses
WHERE code = @code;
