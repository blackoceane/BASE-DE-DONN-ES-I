# BASE-DE-DONN-ES-I


## Description du projet

Monovox est un système de gestion académique  conçu pour centraliser et automatiser le suivi des résultats scolaires (avec le meme concept  omnivox ). 
Le projet consiste en une base de données SQL complète permettant de faire le pont entre les enseignants, les étudiants, et leurs évaluations. 
Il automatise le suivi des évaluations (travaux pratiques, examens) .

## Fonctionnalités

### Côté Enseignant

- **Gestion des Groupes** : Affichage  des groupes assignés par session et calcul  du nombre d'étudiants inscrits.

- **Planification des travaux** : Création, modification et suppression de travaux (assignments) avec calcul automatique de la pondération restante sur 100%.

- **Statistiques de performance** : Calcul des moyennes de groupe, du nombre d'échecs (notes < 60%) et suivi du taux de saisie des notes par évaluation.

- **Saisie des notes** : Le professeur accède à la liste des étudiants de son groupe pour entrer les points obtenus.

- **Calcul de pondération dynamique** : Cette fonction aide le professeur lors de la création d'un TP. Le système calcule le remaining_weight pour l'empêcher de créer des évaluations qui dépasseraient un total de 100% pour la session.

 ### Côté Étudiant

- **Analyse comparative** : Accès à la moyenne du groupe pour chaque travail afin de permettre à l'étudiant de se situer par rapport à sa classe.

- **Historique académique** : Filtrage des résultats par semestre (ex: A2020, A2021) via un menu déroulant dynamique.

- **Système de notation avancé** : L'étudiant voit sa note brute, mais le système calcule instantanément pour lui son pourcentage de réussite individuel.

- **Portail de notes** : Consultation des résultats par session ,grâce à la vue students_grades, l'étudiant accède à un tableau de bord complet incluant :

   - Sa note personnelle.

   - Le poids de l'examen dans sa session.

   - La moyenne du groupe (calculée dynamiquement) pour se situer par rapport aux autres.
     
## Sécurité et Intégrité 

- Utilisation de déclencheurs (Triggers) pour valider les dates de remise.

- Contraintes de vérification (Checks) pour s'assurer que les points et les poids sont des valeurs positives valides.

- Suppression en cascade pour maintenir la cohérence des données.

## Objectifs 

- **Intégrité des données(enseignant)** : Garantir qu'un enseignant ne puisse modifier que les travaux et les notes des groupes qui lui sont réellement assignés.

- **Automatisation des calculs** : Déporter la logique métier (moyennes, pourcentages, pondérations restantes) directement dans le moteur SQL via des requêtes complexes et des vues.

- **Sécurisation des accès** : Mise en place d'un système de connexion sécurisé avec hachage des mots de passe (SHA2).

- **Centralisation** : Regrouper les informations des sessions, des groupes-cours, des enseignants et des étudiants dans une structure relationnelle cohérente.

- **Intégrité des données(étudiant)** : Assurer que chaque note est liée à un étudiant existant et à un travail valide appartenant au bon groupe.

- **Optimisation** : Utiliser des vues et des jointures performantes pour générer des tableaux de bord en temps réel.

  --------------------------------------------------------------------
  CONCEPTION 20 NOVEMBRE - 18 DECEMBRE 2024
  IMPORTER SUR GITHUB 06 FEVRIER 2026


