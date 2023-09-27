SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth >= 'Dec 31 2016' AND date_of_birth <= 'Jan 01 2019';
SELECT name from animals WHERE neutered = 'True' and escape_attempts < '3';
SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > '10.5';
SELECT * from animals WHERE neutered = 'True';
SELECT * from animals WHERE name NOT IN ('Gabumon');
SELECT * from animals WHERE weight_kg >= '10.4' and weight_kg <= '17.3';

-- Query and Update animals TABLE

BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified';
WHERE species IS NULL;

SELECT * FROM animals;

ROLLBACK;
BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

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

SELECT neutered, COUNT(*) AS escape_count FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
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

-- Query multipl TABLE
-- What animals belong to Melody Pond?
SELECT A.name, O.full_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal.
SELECT A.name, O.full_name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id;

-- How many animals are there per species?
SELECT S.name AS species_name, COUNT(A.id) AS animal_count
FROM species S
LEFT JOIN animals A ON S.id = A.species_id
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name AS digimon_name
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell'
AND S.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.NAME
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester'
AND A.escape_attempts = 0;

-- Who owns the most animals?
SELECT O.full_name AS owner_name, COUNT(A.id) AS animal_count
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY COUNT(A.id) DESC
LIMIT 1;

-- Join Tables for visits

SELECT A.name AS last_animal_seen
FROM animals A
JOIN visits V ON V.animal_id = A.id
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'William Tatcher'
ORDER BY V.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT V.animal_id)
FROM visits V
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'Stephanie Mendez';

SELECT V.name AS vet_name, SP.name AS specialty
FROM vets V
LEFT JOIN specializations S ON S.vet_id = V.id
LEFT JOIN species SP ON SP.id = S.species_id;

SELECT A.name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'Stephenie Mender' AND V.date_of_visit
BETWEEN '2020-04-01' AND '2020-08-30';


SELECT A.name, COUNT(V.animal_id)
FROM animals A
LEFT JOIN visits V ON A.id = V.animal_id
GROUP BY A.name
ORDER BY COUNT(V.animal_id) DESC
LIMIT 1;

SELECT A.name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id =VE.id
WHERE VE.name = 'Maisy Smith'
ORDER BY V.date_of_visit
LIMIT 1;

SELECT A.name AS animal_name, VE.name AS vet_name, V.date_of_visit
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id = VE.id
ORDER BY V.date_of_visit DESC
LIMIT 1;

SELECT VE.name AS doctor, COUNT(A.name)
FROM visits V
JOIN vets VE ON V.vet_id = VE.id
JOIN animals A ON V.animal_id = A.id
WHERE VE.name = 'Maisy Smith'
GROUP BY VE.name;

SELECT COUNT(*) AS type, S.name 
FROM visits V JOIN vets VE ON V.vet_id = VE.id
JOIN animals A ON V.animal_id = A.id
JOIN species S ON S.id = A.species_id
WHERE VE.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY COUNT(*) DESC LIMIT 1;
