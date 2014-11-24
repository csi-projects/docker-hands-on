ALTER DATABASE handson
  CHARACTER SET 'utf8';

USE handson;

CREATE TABLE IF NOT EXISTS city (
  id INTEGER AUTO_INCREMENT,
  city CHAR(200),
  department CHAR(200), 
  region CHAR(200), 
  country CHAR(200),
  PRIMARY KEY (id)
);

INSERT INTO city (city, department, region, country) VALUES ('Paris', 'Paris', 'Ile de France', 'France');
INSERT INTO city (city, department, region, country) VALUES ('Nantes', 'Loire-Atlantique', 'Pays de la Loire', 'France');
INSERT INTO city (city, department, region, country) VALUES ('Rennes', 'Ille-et-Vilaine', 'Bretagne', 'France');
INSERT INTO city (city, department, region, country) VALUES ('Marseille', 'Bouches-du-Rhône', 'Provence-Alpes-Côte d''Azur', 'France');
INSERT INTO city (city, department, region, country) VALUES ('Lyon', 'Rhône', 'Rhône-Alpes', 'France');
INSERT INTO city (city, department, region, country) VALUES ('Bordeaux', 'Gironde', 'Aquitaine', 'France');