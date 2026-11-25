-- =========================================
-- Jeu d'essai - Les Enfants des Portails
-- A lancer après schema.sql et donnees.sql
-- A lancer un par un
-- =========================================

-- Test 1 - Contrainte UNIQUE (nom_livre, format)
-- Attendu : REFUS, erreur "Duplicate entry"
INSERT INTO livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution)
VALUES ('Tome 1 - passé - validé', 'Broché', 'Principale', 1, 450, 18.99, 13, 'TEST doublon', CURRENT_DATE - INTERVAL 1 YEAR, 1);

-- Test 2 - RG1 : livres publiés (date passée ou du jour ET validé)
-- Attendu : id 1 et 7
SELECT * FROM livre
WHERE date_parution <= CURRENT_DATE AND valid_parution = 1;

-- Test 3 - RG1, valeur limite : vérifie l'utilité du cas "aujourd'hui"
-- Avec < au lieu de <=, attendu : id 1 seulement (le 7 disparaît)
-- Ce test montre qu'une erreur < / <= serait détectée
SELECT * FROM livre
WHERE date_parution < CURRENT_DATE AND valid_parution = 1;

-- Test 4 - RG2 : personnages visibles (au moins un livre publié)
-- Attendu : persos 1 et 3, une ligne chacun
-- (perso 2 : livre non publié ; perso 4 : aucun livre)
SELECT p.id_perso, p.nom_perso, p.prenom_perso
FROM personnage p, livre l, apparaitre a
WHERE l.id_livre = a.livre_id
  AND p.id_perso = a.perso_id
  AND l.date_parution <= CURRENT_DATE
  AND l.valid_parution = 1
GROUP BY p.id_perso;

-- T5 - Contrainte ENUM sur type_actu
-- Attendu : REFUS ('coulisse' sans s n'est pas dans la liste)
INSERT INTO actualite (titre_actu, type_actu, texte_actu, actu_active)
VALUES ('Test ENUM', 'coulisse', 'Test valeur hors liste', 1);

-- T6 - RG3 : actus visibles (active ET aucun livre non publié)
-- Attendu : actus 1 et 4
-- (2 : tome 3 futur ; 3 : tome 2 non validé ; 5 : inactive)
SELECT a.id_actu, a.titre_actu
FROM actualite a
WHERE a.actu_active = 1
  AND a.id_actu NOT IN (
      SELECT c.actu_id
      FROM concerner c, livre l
      WHERE c.livre_id = l.id_livre
        AND (l.date_parution > CURRENT_DATE
             OR l.date_parution IS NULL
             OR l.valid_parution = 0)
  );