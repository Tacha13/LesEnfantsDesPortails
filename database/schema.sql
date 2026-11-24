CREATE TABLE IF NOT EXISTS abonne
(
id_abonne INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
email_abonne VARCHAR (250) UNIQUE NOT NULL,
date_inscription DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
token_desinscription VARCHAR (250) UNIQUE NOT NULL,
confirme BOOLEAN DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS livre
(
id_livre INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nom_livre VARCHAR (250) NOT NULL,
format VARCHAR (250) NOT NULL,
serie VARCHAR (250) NOT NULL,
tome INTEGER NOT NULL,
nb_pages INTEGER,
prix DECIMAL (10, 2),
age_livre INTEGER NOT NULL,
resume TEXT NOT NULL,
date_parution DATE,
valid_parution BOOLEAN DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS personnage
(
id_perso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nom_perso VARCHAR (250),
prenom_perso VARCHAR (250) NOT NULL,
role_perso VARCHAR (250) NOT NULL,
age_perso INTEGER,
citation_perso VARCHAR (250),
presentation_perso TEXT
);

CREATE TABLE IF NOT EXISTS compte
(
id_compte INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
prenom_user VARCHAR (250) NOT NULL,
email_user VARCHAR (250) UNIQUE NOT NULL,
mot_de_passe_hash VARCHAR (250) NOT NULL,
role ENUM('admin_tech', 'admin_contenu') NOT NULL DEFAULT 'admin_contenu',
actif BOOLEAN DEFAULT 1 NOT NULL,
date_creation_compte DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
date_derniere_connexion DATETIME,
nb_tentatives INTEGER NOT NULL DEFAULT 0,
fin_blocage DATETIME
);

CREATE TABLE IF NOT EXISTS image
(
id_image INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
fichier_img VARCHAR (250) NOT NULL,
categorie ENUM('couverture', 'portrait', 'lieu', 'ambiance', 'actualite') NOT NULL,
image_active BOOLEAN DEFAULT 0 NOT NULL,
credits VARCHAR (250),
alt VARCHAR (250) NOT NULL,
legende TEXT,
compte_id INTEGER,
livre_id INTEGER,
Foreign Key (compte_id) REFERENCES compte(id_compte) ON DELETE RESTRICT,
Foreign Key (livre_id) REFERENCES livre(id_livre) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS actualite
(
id_actu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
titre_actu VARCHAR (250) NOT NULL,
type_actu ENUM('sortie', 'coulisses', 'salon', 'dedicace') NOT NULL,
texte_actu TEXT NOT NULL,
date_evenement DATETIME,
date_publication DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
lieu_evenement VARCHAR (250),
actu_active BOOLEAN DEFAULT 0 NOT NULL,
compte_id INTEGER,
Foreign Key (compte_id) REFERENCES compte(id_compte) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS lien
(
id_lien INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nom_lien VARCHAR (250) NOT NULL,
url VARCHAR (500) NOT NULL,
lien_actif BOOLEAN DEFAULT 0 NOT NULL,
livre_id INTEGER NOT NULL,
Foreign Key (livre_id) REFERENCES livre(id_livre) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS extrait
(
id_extrait INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
titre_extrait VARCHAR (250) NOT NULL,
texte_extrait TEXT NOT NULL,
extrait_actif BOOLEAN DEFAULT 0 NOT NULL,
livre_id INTEGER NOT NULL,
Foreign Key (livre_id) REFERENCES livre(id_livre) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS apparaitre
(
livre_id INTEGER NOT NULL,
perso_id INTEGER NOT NULL,
PRIMARY KEY (livre_id, perso_id),
Foreign Key (livre_id) REFERENCES livre(id_livre) ON DELETE RESTRICT,
Foreign Key (perso_id) REFERENCES personnage(id_perso) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS illustrer
(
image_id INTEGER NOT NULL,
actu_id INTEGER NOT NULL,
PRIMARY KEY (image_id, actu_id),
Foreign Key (image_id) REFERENCES image(id_image) ON DELETE RESTRICT,
Foreign Key (actu_id) REFERENCES actualite(id_actu) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS concerner
(
livre_id INTEGER NOT NULL,
actu_id INTEGER NOT NULL,
PRIMARY KEY (livre_id, actu_id),
Foreign Key (livre_id) REFERENCES livre(id_livre) ON DELETE RESTRICT,
Foreign Key (actu_id) REFERENCES actualite(id_actu) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS representer
(
perso_id INTEGER NOT NULL,
image_id INTEGER NOT NULL,
PRIMARY KEY (perso_id, image_id),
Foreign Key (perso_id) REFERENCES personnage(id_perso) ON DELETE RESTRICT,
Foreign Key (image_id) REFERENCES image(id_image) ON DELETE RESTRICT
);