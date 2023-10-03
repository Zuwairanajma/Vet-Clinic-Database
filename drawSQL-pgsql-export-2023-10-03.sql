CREATE TABLE "owners"(
    "id" INTEGER NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL
);
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
CREATE TABLE "specializations"(
    "species_id" INTEGER NOT NULL,
    "vet_id" BIGINT NOT NULL
);
ALTER TABLE
    "specializations" ADD PRIMARY KEY("species_id");
CREATE TABLE "visits"(
    "animal_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date_of_visit" DATE NOT NULL
);
ALTER TABLE
    "visits" ADD PRIMARY KEY("animal_id");
CREATE TABLE "species"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "animals_table"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owner_id" INTEGER NOT NULL,
    "primary key" UUID NOT NULL
);
CREATE INDEX "animals_table_id_index" ON
    "animals_table"("id");
ALTER TABLE
    "animals_table" ADD PRIMARY KEY("id");
ALTER TABLE
    "animals_table" ADD CONSTRAINT "animals_table_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("name");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("name");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_date_of_visit_foreign" FOREIGN KEY("date_of_visit") REFERENCES "animals_table"("id");
ALTER TABLE
    "species" ADD CONSTRAINT "species_id_foreign" FOREIGN KEY("id") REFERENCES "vets"("id");
ALTER TABLE
    "species" ADD CONSTRAINT "species_name_foreign" FOREIGN KEY("name") REFERENCES "specializations"("species_id");
ALTER TABLE
    "vets" ADD CONSTRAINT "vets_age_foreign" FOREIGN KEY("age") REFERENCES "visits"("animal_id");
ALTER TABLE
    "animals_table" ADD CONSTRAINT "animals_table_owner_id_foreign" FOREIGN KEY("owner_id") REFERENCES "owners"("id");
ALTER TABLE
    "vets" ADD CONSTRAINT "vets_name_foreign" FOREIGN KEY("name") REFERENCES "animals_table"("id");