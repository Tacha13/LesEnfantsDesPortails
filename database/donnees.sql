-- =========================================
-- Données de test - Les Enfants des Portails
-- A lancer après schema.sql
-- =========================================

-- Livres : 8 cas pour RG1 (passé / futur / sans date / aujourd'hui × validé ou non)
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 1 - passé - validé','Broché','Principale',1,450,18.99,13,'TEST Tome 1 - passé - validé',CURRENT_DATE - INTERVAL 1 YEAR,1);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 2 - passé - non validé','Poche','Principale',2,450,18.99,13,'TEST Tome 2 - passé - non validé',CURRENT_DATE - INTERVAL 1 YEAR,0);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 3 - futur - validé','Broché','Principale',3,450,18.99,13,'TEST Tome 3 - futur - validé',CURRENT_DATE + INTERVAL 1 YEAR,1);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 4 - futur - non validé','BD','Principale',4,450,18.99,13,'TEST Tome 4 - futur - non validé',CURRENT_DATE + INTERVAL 1 YEAR,0);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 5 - null - validé','Broché','Principale',5,450,18.99,13,'TEST Tome 5 - null - validé',NULL,1);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 6 - null - non validé','Poche','Principale',6,450,18.99,13,'TEST Tome 6 - null - non validé',NULL,0);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 7 - aujourdhui - validé','Broché','Principale',7,450,18.99,13,'TEST Tome 7 - aujourd hui - validé',CURRENT_DATE,1);
insert into livre (nom_livre, format, serie, tome, nb_pages, prix, age_livre, resume, date_parution, valid_parution) values ('Tome 8 - aujourdhui - non validé','BD','Principale',8,450,18.99,13,'TEST Tome 8 - aujourd hui - non validé',CURRENT_DATE,0);


-- Personnages : 4 cas pour RG2
insert into personnage (nom_perso, prenom_perso, role_perso, age_perso, citation_perso, presentation_perso) values ('TEST 1 visible 1 et 7 livre publié','Test 1','Principale',14,'TEST 1 visible 1 et 7 livre publié','TEST 1 visible 1 et 7 livre publié');
insert into personnage (nom_perso, prenom_perso, role_perso, age_perso, citation_perso, presentation_perso) values ('TEST 2 visible 2 non publié','Test 2','Secondaire',15,'TEST 2 visible 2 non publié','TEST 2 visible 2 non publié');
insert into personnage (nom_perso, prenom_perso, role_perso, age_perso, citation_perso, presentation_perso) values ('TEST 3 visible 1 et 3 ','Test 3','Principale',15,'TEST 3 visible 1 et 3 ','TEST 3 visible 1 et 3 ');
insert into personnage (nom_perso, prenom_perso, role_perso, age_perso, citation_perso, presentation_perso) values ('TEST 4  aucun livre','Test 4','Secondaire',15,'TEST 4  aucun livre','TEST 4  aucun livre');


-- Apparaitre : liens livre / personnage
insert into apparaitre (livre_id, perso_id) values (1,1);
insert into apparaitre (livre_id, perso_id) values (7,1);
insert into apparaitre (livre_id, perso_id) values (2,2);
insert into apparaitre (livre_id, perso_id) values (1,3);
insert into apparaitre (livre_id, perso_id) values (3,3);

-- Actualités : 5 cas pour RG3
-- (1 : tous livres publiés / 2 : un livre futur / 3 : livre non validé
--  4 : aucun livre / 5 : livres publiés mais actu inactive)
INSERT INTO actualite (titre_actu, type_actu, texte_actu, date_evenement, lieu_evenement, actu_active) VALUES
('Lancement',          'sortie',    'Lancement Tome 1',             CURRENT_DATE + INTERVAL 1 MONTH, 'Marseille', 1),
('Coulisse Tome',      'coulisses', 'Coulisse Tome',                NULL,                            'Aubagne',   1),
('Salon de la BD',     'salon',     'Présentation de l''éditeur',   CURRENT_DATE + INTERVAL 2 DAY,   'Paris',     1),
('Salon des éditeurs', 'salon',     'Présentation de l''écrivain',  CURRENT_DATE + INTERVAL 5 DAY,   'Marseille', 1),
('Coulisse Tome 2',    'sortie',    'Coulisse Tome 2',              NULL,                            'Aubagne',   0);

-- Concerner (livre_id, actu_id)
INSERT INTO concerner (livre_id, actu_id) VALUES
(1,1), (7,1),   -- actu 1 : tomes 1 et 7, tous publiés
(1,2), (3,2),   -- actu 2 : tome 1 publié + tome 3 futur
(2,3),          -- actu 3 : tome 2 non validé
                -- actu 4 : aucun livre
(1,5), (7,5);   -- actu 5 : livres publiés mais actu inactive

-- Images : 6 cas pour RG4
-- (1 : sans livre / 2 : livre publié / 3 : tome futur
--  4 : tome sans date / 5 : inactive / 6 : tome du jour)
INSERT INTO image (fichier_img, categorie, image_active, credits, alt, legende, livre_id) VALUES
('decor.jpg',        'ambiance',   1, 'Illustration : Yann',    'Décor',         'Décor',         NULL),
('page-garde.jpg',   'couverture', 1, NULL,                     'Page de garde', 'Page de garde', 1),
('perso1.jpg',       'portrait',   1, 'Illustration : Natacha', 'perso 1',       'perso 1',       3),
('perso2.jpg',       'portrait',   1, NULL,                     'perso 2',       'perso 2',       5),
('portail.jpg',      'actualite',  0, NULL,                     'portail',       'portail',       1),
('couv-tome7.jpg',   'couverture', 1, NULL,                     'Couverture tome 7', 'Couverture tome 7', 7);