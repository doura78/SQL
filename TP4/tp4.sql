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


----------------
-- REQUETES-----
----------------

-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * 
FROM article
ORDER by designation ASC;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé

SELECT *
FROM article
ORDER BY prix DESC;  -- ou article.prix

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant

SELECT *
FROM article
WHERE designation like "%boulon%"
ORDER BY prix ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».

SELECT *
FROM article
WHERE designation like "%sachet%";


-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !

SELECT *                                   -- UCASE 
FROM article
WHERE UPPER designation like "%SACHET%";    -- where Ucase

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.

SELECT *                                             -- select.ref, fournisseur.nom
FROM article            
JOIN fournisseur on fournisseur.id = article.id_fou
ORDER BY id_fou ASC, prix DESC;                     --- order by fournisseur.nom, prix desc

-- g. Listez les articles de la société « Dubois & Fils »

SELECT *
FROM article 
JOIN fournisseur on article.id_fou =fournisseur.id
WHERE fournisseur.nom = 'Dubois & Fils'                                                  --WHERE id_fou = 3;

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »

SELECT id_fou, AVG(prix)                              -- select fournisseur.nom, round(avg(article.prix),2) as prix moyen : round pemert d'ajouter des chiffres après la virgule
FROM article 
JOIN fournisseur on fournisseur.id =article.id_fou
WHERE id_fou "Dubois & Fils";                         --fournisseur.nom = 'Dubois & Fils'    

-- i. Calculez la moyenne des prix des articles de chaque fournisseur

SELECT fournisseur.nom, AVG(article.prix) as prix_moyen                               --SELECT id_fou, AVG(prix) 
FROM article                                    --FROM article
JOIN fournisseur on article.id_fou = fournisseur.id                                    --ORDER BY id_fou;
GROUP BY fournisseur.nom

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.

SELECT *
FROM bon 
WHERE date_cmde BETWEEN '2019/03/01' AND '2019/04/05 12:00:00';


-- k. Sélectionnez les divers bons de commande qui contiennent des boulons

SELECT *                                     -- select distinct bon.numero (pour avoir les bonnes infos mais au min)
FROM bon 
JOIN compo on bon.id = compo.id_bon
JOIN article on compo.id_art = article.id
WHERE designation LIKE "%boulon%"

---------------------------------------------------------------------------------------------------------------
-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.

SELECT *                                            -- select distinct bon.numero, fournisseur.nom             
FROM bon 
JOIN compo on bon.id = compo.id_bon
JOIN article on compo.id_art = article.id
JOIN fournisseur on compo.id_art = fournisseur.id   -- on fournisseur.id = article.id_fou
having designation  LIKE "%boulon%"

------------------------------------------------------
-- m. Calculez le prix total de chaque bon de commande
------------------------------------------------------

select article sum(prix)                        -- select bon.id, sum(article.prix * compo.qte)
FROM bon JOIN compo on bon.id = compo.id_bon    -- from bon
join article on compo.id_art = article.id       
GROUP BY article                                bon.id

------------------------------------------------------------
-- n. Comptez le nombre d'articles de chaque bon de commande
------------------------------------------------------------

-- SELECT bon.id, sum(compo.qte)
-- from bon
-- join compo on bon.id = compo.id_bon
-- group by bon.id;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT bon.id, sum(compo.qte)
-- from bon
-- join compo on bon.id = compo.id_bon
-- group by bon.id;
-- having sum(compo.qte) > 25;

-------------------------------------------------------------------------
-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
-------------------------------------------------------------------------

-- Select sum(article.prix * compo.qte)
-- From bon
-- Join compo ON bon.id = compo.id_bon
-- JOIN article ON article.id = compo.id_art
-- WHERE MONTH(bon.date_cmde) = 4 AND YEAR(bon.date_cmde) = 2019
-- where bon.date_cmde between '2019/04/01 and 2019/04/30;