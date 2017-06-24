-- Titre :             Création base projet bibliothèque
-- Version :           1.0
-- Version :      1.0
-- Date :         26 novembre 2008
-- Auteur :       Philippe TANGUY
-- Description :  Création de la table "livre" pour la réalisation de la fonctionnalité "liste de tous les livres"

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists "livre";
drop table if exists "exemplaire";
drop table if exists "usager";

-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table livre
(
	id			serial primary key,
	isbn10		varchar(25) unique,
	isbn13		varchar(25) unique,
	titre		varchar(50) not null,
	auteur		varchar(30)
);

CREATE TABLE exemplaire
(
  idExemplaire INT PRIMARY KEY NOT NULL,
  idLivre INT references livre(id)
);

CREATE TABLE usager
(
  nb serial primary key NOT NULL,
  nom character varying(25) NOT NULL,
  prenom character varying(25),
  statut character varying(25),
  email character varying(50),
  unique(nom,prenom,email)
);

CREATE TABLE emprunt
(
  idExemplaire int references exemplaire(idexemplaire)  ,
  idUsager int references usager(nb),
  dateEmprunt date,
  dateRetour date,
  unique(idExemplaire,idUsager,dateEmprunt),
  PRIMARY KEY (idExemplaire, idUsager, dateEmprunt)
  );

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+
-- TABLE LIVRE
insert into livre values(nextval('livre_id_seq'), '2-84177-042-7', NULL,                'JDBC et JAVA',                            'George Reese');    -- id = 1
insert into livre values(nextval('livre_id_seq'), NULL,            '978-2-7440-7222-2', 'Sociologie des organisations',            'Michel Foudriat'); -- id = 2
insert into livre values(nextval('livre_id_seq'), '2-212-11600-4', '978-2-212-11600-7', 'Le data warehouse',                       'Ralph Kimball');   -- id = 3
insert into livre values(nextval('livre_id_seq'), '2-7117-4811-1', NULL,                'Entrepots de donnees',                    'Ralph Kimball');   -- id = 4
insert into livre values(nextval('livre_id_seq'), '2012250564',    '978-2012250567',    'Oui-Oui et le nouveau taxi',              'Enid Blyton');     -- id = 5
insert into livre values(nextval('livre_id_seq'), '2203001011',    '978-2203001015',    'Tintin au Congo',                         'Hergé');           -- id = 6
insert into livre values(nextval('livre_id_seq'), '2012011373',    '978-2012011373',    'Le Club des Cinq et le tresor de l''Ile', 'Enid Blyton');     -- id = 7

-- Table USAGER
insert into usager values(nextval('usager_nb_seq'), 'VO LE MINH', 'Quan','Etudiant' ,'quan.vo@telecom-bretagne.eu');    
insert into usager values(nextval('usager_nb_seq'), 'MEATBALL', 'Quynh','Etudiant' ,'quynh.bui@telecom-bretagne.eu'); 
insert into usager values(nextval('usager_nb_seq'), 'NGUYEN TAN', 'Phuc','Enseignant' ,'phuc.nguyen@telecom-bretagne.eu'); 
insert into usager values(nextval('usager_nb_seq'), 'HUYNH HIEP THAO', 'Nghi','Enseignant' ,'nghi.huynh@telecom-bretagne.eu'); 
insert into usager values(nextval('usager_nb_seq'), 'Porter', 'Harry','Etudiant' ,'harry.porter@telecom-bretagne.eu'); 

