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

UPDATE bon 
SET DATE_CMDE = '2019-02-08 09:30:00' 
WHERE ID = 1;

INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (2, 2, 5, 2, '2019-03-02 09:30:00');
INSERT INTO COMPO (ID_ART, ID_BON, QTE) values (2, 2, 25),
(3, 2, 15),
(9, 2, 8),
(10, 2, 11);

INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (3, 3, 2, 3, '2019-04-03 17:30:00');
INSERT INTO COMPO (ID_ART, ID_BON, QTE) values (4, 3, 25),
(6, 3, 40),
(8, 3, 15);

INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (4, 4, 2, 3, '2019-04-05 11:40:00');
INSERT INTO COMPO (ID_ART, ID_BON, QTE) values (4, 4, 10),
(6, 4, 15),
(8, 4, 8);

INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (5, 5, 7, 2, '2019-05-15 14:45:00');
INSERT INTO COMPO (ID_ART, ID_BON, QTE) values (2, 5, 17),
(3, 5, 13),
(10, 5, 9);

INSERT INTO BON (ID, NUMERO, DELAI, ID_FOU, DATE_CMDE) VALUES (6, 6, 0, 1, '2019-06-24 18:55:00');

-------------
-- REQUETE --
-------------

----- a. Listez toutes les données concernant les articles

SELECT *
FROM article;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros

SELECT ref, designation
FROM article
WHERE prix > 2;

------------------------------------------------------------------------------
--- c. Enutilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
 
SELECT *
FROM article
WHERE prix  >= 2 AND <= 6.25;

------------------------------------------------------------------
-- d. Enutilisant l’opérateur BETWEEN, listez tous les articles dont le prix est compris entre 2 et 6.25 euros

SELECT *
FROM article
WHERE prix BETWEEN 2 AND 6.25;

----------------------------------------------------------------
-- e. Listez tous les articles, dans l’ordre des prix descendants, et dont le prix n’est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports.
 
SELECT *
FROM article
WHERE prix NOT between 2 AND 6.25 AND id_fou = 1;
-- select*
-- where article.prix < 2 or article.prix > 6.25 and article.id_fou = 1
--order by prix desc;

 -----------------------------------------------------------------------------------
-- f. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la Française d’imports ou Dubois et Fils

SELECT *
FROM article
WHERE id_fou = 1 || id_fou = 3;

-----------------------------------------------------------------
-- g. Enutilisant l’opérateur IN, réalisez la même requête que précédemment

SELECT *
FROM article
where id_fou IN  (1, 3);

---------------------------------------------------------------
-- h. Enutilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne sont ni Française d’Imports, ni Dubois et Fils.

SELECT *
FROM article
WHERE id_fou NOT IN (1,3);

------------------------------------------------------
-- i. Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019.

select *
FROM bon 
ORDER BY date_cmde BETWEEN 2019/02/01 AND 2019-04-30;
