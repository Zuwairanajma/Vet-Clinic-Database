SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= 'Dec 31 2016' AND date_of_birth <= 'Jan 01 2019';
SELECT name FROM animals WHERE neutered = 'True' and escape_attempts < '3';
SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > '10.5';
SELECT * FROM animals WHERE neutered = 'True';
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= '10.4' and weight_kg <= '17.3';

-- Query and Update animals TABLE

BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;
-- Begin Second Transaction

BEGIN TRANSACTION;

DELETE FROM animals;

ROLLBACK;

SELECT * FROM animals;


-- Begin Third Transaction

BEGIN TRANSACTION;

DELETE FROM animals 
WHERE date_of_birth > 'Jan 1 2022';

SAVEPOINT savepoint_weight;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO savepoint_weight;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Begin forth transaction

SELECT COUNT(*) FROM animals;

SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, MAX(escape_attempts) AS max_escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY max_escape_count DESC
LIMIT 1;


SELECT species,
MIN(weight_kg) AS min_weight,
MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS 
avg_escape_attempts 
FROM animals
WHERE date_of_birth BETWEEN 'Jan 1 1990' AND 'Dec 31 2000'
GROUP BY species;
