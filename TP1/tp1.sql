CREATE TABLE fournisseur (
	ID INT(11) PRIMARY KEY NOT NULL,
    NOM VARCHAR (25) DEFAULT NULL
);

CREATE TABLE Article(
	ID INT (11) NOT NULL,
    REF VARCHAR (13) DEFAULT NULL UNIQUE NOT NULL,
    DESIGNATION VARCHAR (255) DEFAULT NULL,
    PRIX DECIMAL (7,2) DEFAULT NULL, -- 99999,99
    ID_FOU INT (11) DEFAULT NULL 
);

CREATE TABLE Bon(
	ID INT (11) PRIMARY KEY,
    NUMERO INT(11) NOT NULL,
    DATE_CMDE DATETIME DEFAULT CURRENT_TIMESTAMP,
    DELAI INT (11), 
    ID_FOU INT (11)
);

CREATE TABLE Compo(
	ID INT (11) AUTO_INCREMENT PRIMARY KEY,
    ID_ART INT,
    ID_BON INT (11),
    QTE INT (11) NOT NULL
);    

---------------------------
--- AJOUT DE CONTRAINTE ---
---------------------------

ALTER TABLE article ADD CONSTRAINT FOREIGN KEY (ID_FOU) REFERENCES fournisseur(id);

ALTER TABLE Bon     ADD CONSTRAINT FOREIGN KEY (ID_FOU) REFERENCES fournisseur (id);

ALTER TABLE compo   ADD CONSTRAINT FOREIGN KEY (ID_ART) REFERENCES article (id);

ALTER TABLE compo   ADD CONSTRAINT FOREIGN KEY (ID_BON) REFERENCES Bon (id);


ALTER TABLE Bon CHANGE DELAI DELAI INT(11);

ALTER TABLE Article CHANGE DESIGNATION DESIGNATION VARCHAR (255);

ALTER TABLE article CHANGE ID ID INT(11) PRIMARY KEY;

ALTER TABLE Article CHANGE PRIX DECIMAL (7,2);



 MySQL a retourné un résultat vide (c'est à dire aucune ligne). (traitement en 0,0007 seconde(s).)
ALTER TABLE Bon CHANGE DELAI DELAI INT(11);
[ Éditer en ligne ] [ Éditer ] [ Créer le code source PHP ]

 MySQL a retourné un résultat vide (c'est à dire aucune ligne). (traitement en 0,0005 seconde(s).)
ALTER TABLE Article CHANGE DESIGNATION DESIGNATION VARCHAR (100);
[ Éditer en ligne ] [ Éditer ] [ Créer le code source PHP ]

 MySQL a retourné un résultat vide (c'est à dire aucune ligne). (traitement en 0,0005 seconde(s).)
ALTER TABLE Article CHANGE PRIX PRIX DECIMAL (7,2);
[ Éditer en ligne ] [ Éditer ] [ Créer le code source PHP ]