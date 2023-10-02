INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('1', 'Agumon', 'Feb 3 2020', '0', 'Yes', '10.23'),
('2', 'Gabumon', 'Nov 15 2018', '2', 'Yes', '8'),
('3', 'Pikachu', 'Jan 7 2021', '1', 'No', '15.04'),
('4', 'Devimon', 'May 12 2017', '5', 'Yes', '11');

-- Query and Update animals table

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('5', 'Charmander', 'Feb 8 2020', '0', 'No', '-11'),
('6', 'Plantmon', 'Nov 15 2021', '2', 'Yes', '-5.7'),
('7', 'Squirtle', 'Apr 2 1993', '3', 'No', '-12.13'),
('8', 'Angemon', 'Jun 12 2005', '1', 'Yes', '-45'),
('9', 'Boarmon', '07 Jun 2005', '7', 'Yes', '20.4'),
('10', 'Blossom', '13 Oct 1998', '3', 'Yes', '17'),
('11', 'Ditto', '14 May 2022', '4', 'Yes', '22');

-- Query multiple table

INSERT INTO owners(full_name, age) VALUES
	('Sam Smith', '34'),
	('Jennifer Orwell', '19'),
	('Bob', '45'),
	('Melody Pond', '77'),
	('Dean Winchester', '14'),
	('Jodie Whittaker', '38');

INSERT INTO species(name) VALUES
	('Pokemon'),
	('Digimon');

UPDATE animals
SET species_id = CASE
	WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
	ELSE (SELECT id FROM species WHERE name = 'Pokemon')
	END;

UPDATE animals
SET owner_id = CASE
	WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
	WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
	WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
	WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
	END;

-- Add 'join table' for visits

INSERT INTO vets (name, age, date_of_graduation) VALUES
	('William Tatcher', '45', 'Apr 23 2000'),
	('Maisy Smith', '26', 'Jan 17 2019'),
	('Stephanie Mendez', '64', 'May 4 1981'),
	('Jack Harkness', '38', 'Jun 8 2008');

INSERT INTO specializations (vet_id, species_id) VALUES
	('1', '1'),
	('3', '2'),
	('3', '1'),
	('4', '2');

INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES
	('1','1', 'May 24 2020'),
	('1', '3', 'Jul 22 2020'),
	('2', '4', 'Feb 2 2021'),
	('3', '2', 'Jan 5 2020'),
	('3', '2', 'Mar 8 2020'),
	('3', '2', 'May 14 2020'),
	('4', '3', 'May 4 2021'),
	('5', '4', 'Feb 24 2021'),
	('6', '2', 'Dec 21 2019'),
	('6', '1', 'Aug 10 2020'),
	('6', '2', 'Apr 7 2021'),
	('7', '3', 'Sep 29 2019'),
	('8', '4', 'Oct 3 2020'),
	('8', '4', 'Nov 4 2020'),
	('9', '2', 'Jan 24 2019'),
	('9', '2', 'May 15 2019'),
	('9', '2', 'Feb 27 2020'),
	('9', '2', 'Aug 3 2020'),
	('10', '3', 'May 24 2020'),
	('10', '1', 'Jan 11 2021');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1950-01-01'::timestamp, '2021-01-01', '8 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,5500000), 'owner_' || generate_series(1,5500000) || '@mail.com';