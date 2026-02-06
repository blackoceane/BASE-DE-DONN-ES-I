--
-- VOTRE NOM: tiedjom litchap joyce
--
CREATE TABLE assignments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Identifiant unique pour chaque travail
    name VARCHAR(100) NOT NULL,                 -- Nom du travail (obligatoire)
    weight TINYINT UNSIGNED NOT NULL,           -- Poids du travail (0-100%)
    points TINYINT UNSIGNED NOT NULL,           -- Nombre de points possibles (>0)
     dte DATE NOT NULL,                         -- Date d'échéance (>= aujourd'hui)
    group_semester CHAR(5) NOT NULL,            -- Clé étrangère vers le groupe (session)
    group_course CHAR(10) NOT NULL,             -- Clé étrangère vers le cours
    group_number TINYINT UNSIGNED NOT NULL,     -- Clé étrangère vers le numéro de groupe
    CONSTRAINT chk_weight CHECK (weight >= 0 AND weight <= 100), -- Contrainte poids (0-100%)
    CONSTRAINT chk_points CHECK (points > 0),                   -- Contrainte points (>0)
  -- CONSTRAINT chk_date CHECK (dte >= curdate()),             -- Contrainte date (>= aujourd'hui)
    -- CONSTRAINT fk_group 
  FOREIGN KEY(group_number, group_semester, group_course) 
  		REFERENCES groups(number, semester, course_code)
       -- Référence à la table `groups`
        ON DELETE CASCADE                                       -- Supprime les travaux si le groupe est supprimé
);
create  trigger date_assignments
    before insert on assignments
    for each row
    begin 
    if NEW.dte>=CURDATE() then
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La date de l''événement ne doit pas doit être dans le futur';
    END IF;
    END;
    
    create trigger sum_points
  before insert on assignments
  for each row
  begin
  declare total_points int unsigned;
  select sum(points)+new.points into total_points
  from assignments
  where group_semester=new.group_semester;
  if total_points<99 then
  SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La somme de points pour ce groupe  doit  dépasser 100';
    END IF;
END;

INSERT INTO assignments (name, weight, points, dte, group_semester, group_course, group_number)
VALUES 
('Projet 1', 10, 70, '2020-12-15', 'A2020', '420-0Q4-SW', 1),
('Projet 2', 25, 80, '2021-12-09', 'A2021', '420-0Q4-SW', 1),
('Projet  BD', 40, 80, '2021-10-30', 'H2021', '420-1SU-SW', 1),
('Projet ED', 35, 60, '2021-02-19', 'A2021', '420-0Q4-SW', 1),
('Projet POO', 30, 70, '2020-11-15', 'A2020', '420-0Q4-SW', 1),
('Projet SW1', 35, 25, '2021-11-09', 'A2021', '420-0Q4-SW', 1),
('Projet ROBO', 10, 70, '2020-12-15', 'A2020', '420-0Q4-SW', 1),
('Projet SE', 25, 30, '2021-12-29', 'H2021', '420-1SU-SW', 1),
('Projet 22', 10, 20, '2021-02-22', 'H2021', '420-1SU-SW', 1),
('Projet PR', 05, 100, '2021-12-29', 'A2021', '420-0Q4-SW', 1),
('Projet POO', 30, 70, '2020-11-15', 'A2020', '420-0Q4-SW', 1),
('Projet MUS', 35, 25, '2021-11-09', 'A2021', '420-0Q4-SW', 1),
('Projet ARD', 10, 50, '2020-12-15', 'A2020', '420-0Q4-SW', 1),
('Projet COM', 15, 30, '2021-12-29', 'H2021', '420-1SU-SW', 1),
('Projet ANG', 10, 05, '2021-02-22', 'H2021', '420-1SU-SW', 1),
('Projet FR', 05, 10, '2021-12-29', 'A2021', '420-0Q4-SW', 1);

CREATE TABLE grades (
  student_id INT UNSIGNED NOT NULL ,
  assignment_id INT UNSIGNED NOT NULL ,
  points TINYINT UNSIGNED null,
  CONSTRAINT chk_points CHECK (points IS NULL OR points >= 0),
  PRIMARY KEY(student_id,assignment_id),
  FOREIGN KEY(student_id)REFERENCES students(id),
  FOREIGN KEY(assignment_id)REFERENCES assignments(id) 
  on delete cascade
  );
  
 INSERT INTO grades
  VALUES(20201,1,20),
  
  (20202,2,30),
  (20203,3,40),
  (20204,4,50),
  (20205,5,70),
  (20206,6,80),
  (20207,7,100),
  (20208,8,10),
  (20209,9,90),
  (20210,10,null),
  (20211,11,70),
  (20212,12,80),
  (20213,13,null),
  (20214,14,10),
  (20215,15,null),
  (20216,16,null)
  ;



