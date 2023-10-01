/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name varchar(60),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- Query and Update Animals TABLE

ALTER TABLE animals 
    ADD species varchar(60);

-- Query multiple TABLES
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255), -- Increase VARCHAR length
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) -- Increase VARCHAR length
);

CREATE SEQUENCE animals_id_seq OWNED By animals.id;

ALTER TABLE animals ALTER COLUMN id
SET DEFAULT nextval('animals_id_seq');

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES
species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);
ALTER TABLE species
ALTER COLUMN name TYPE VARCHAR(255);

ALTER TABLE owners
ALTER COLUMN full_name TYPE VARCHAR(255);

-- -- Join TABLE for Visit

CREATE TABLE vets (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

ALTER TABLE vets 
ALTER COLUMN name TYPE
VARCHAR(255);

CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);

ALTER TABLE owners
ADD COLUMN email VARCHAR(120);