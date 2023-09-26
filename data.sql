/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Agumon', 'Feb 3 2020', '0', 'True', '10.23'),
('Gabumon', 'Nov 15 2018', '2', 'True', '8'),
('Pikachu', 'Jan 7 2021', '1', 'False', '15.04'),
('Devimon', 'May 12 2017', '5', 'True', '11'),
('Charmander', 'Feb 8 2020', '0', 'False', '-11'),
('Plantmon', 'Nov 15 2021', '2', 'True', '-5.7'),
('Squirtle', 'Apr 2 1993', '3', 'False', '-12.13'),
('Angemon', 'Jun 12 2005', '1', 'True', '-45'),
('Boarmon', 'Jun 7 2005', '7', 'True', '20.4'),
('Blossom', 'Oct 13 1998', '3', 'True', '17'),
('Ditto', 'May 14 2022', '4', 'True', '22');

-- Query multiple TABLE

-- Insert data into the owners table
INSERT INTO owners(full_name, age)
VALUES 
('Sam Smith', '34'),
('Jennifer Orwell', '19'),
('Bob', '45'),
('Melody Pond', '77'),
('Dean Winchester', '14'),
('Jodie Whittaker', '38');

-- Insert data into the species table
INSERT INTO species(name) VALUES 
('Pokemon'),
('Digimon');

-- Update the animals table to set species_id based on the name
UPDATE animals 
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1)
    ELSE (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1)
END;

-- Update the animals table to set owner_id based on the name
UPDATE animals
SET owner_id = CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith' LIMIT 1)
    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1)
    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1)
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1)
    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1)
END;
