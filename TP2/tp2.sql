
DROP DATABASE IF EXISTS compta;
CREATE DATABASE compta;
USE compta;

-----------------------
-- CREATION DE TABLE --
-----------------------

CREATE TABLE fournisseur (
    id INT(11) PRIMARY KEY,
    nom VARCHAR(25) NOT NULL
);

CREATE TABLE article (
    id INT(11) PRIMARY KEY,
    ref VARCHAR(13) UNIQUE NOT NULL,
    designation VARCHAR(255),
    prix DECIMAL(7,2) NOT NULL,
    id_fou INT(11)
);

CREATE TABLE bon (
    id INT(11) PRIMARY KEY,
    numero INT(11) NOT NULL,
    date_cmde DATETIME DEFAULT CURRENT_TIMESTAMP,
    delai INT(11),
    id_fou INT(11)
);


CREATE TABLE compo (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_art INT(11),
    id_bon INT(11),
    qte INT(11) NOT NULL
);


-------------------------
-- AJOUT DE CONTRAINTE --
-------------------------

ALTER TABLE article ADD CONSTRAINT FOREIGN KEY (id_fou) REFERENCES fournisseur(id);
ALTER TABLE bon     ADD CONSTRAINT FOREIGN KEY (id_fou) REFERENCES fournisseur(id);
ALTER TABLE compo   ADD CONSTRAINT FOREIGN KEY (id_art) REFERENCES article (id);
ALTER TABLE compo   ADD CONSTRAINT FOREIGN KEY (id_bon) REFERENCES bon (id);

----------------
-- INSERTIONS --
----------------

INSERT INTO fournisseur(id, nom) VALUES
(1,'Française d''imports'),
(2,'FDM SA'),
(3,'Dubois & Fils');

INSERT INTO article(id, ref, designation, prix, id_fou) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d''encastrement', 8.14, 2);

INSERT INTO bon(id, numero, delai, id_fou) VALUES (1, 1, 3, 1);

INSERT INTO compo(qte, id_art, id_bon) VALUES
(3, 1, 1), -- 3 Perceuses P1
(4, 5, 1), -- 4 Meuleuses 125mm
(1, 7, 1); -- 1 Perceuse à colonne
