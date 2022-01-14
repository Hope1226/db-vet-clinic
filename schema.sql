/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

/* Use the following comands to create animals' table */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(250), 
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

/* Use the following comands to create owners' table */
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY (id)
);

/* Use the following comands to create species table */
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY(id)
);

/* Modify animals table */

/* Remove column species */
BEGIN;
ALTER TABLE animals
DROP COLUMN species;
COMMIT;

/* Add columns sepcies_id and owener_id */
BEGIN;
ALTER TABLE animals
ADD COLUMN species_id INT;
ALTER TABLE animals
ADD COLUMN owner_id INT;
COMMIT;

/* Add foreign key to animals table */
BEGIN;
ALTER TABLE animals
ADD CONSTRAINT species_fk
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;
COMMIT;

/* Add foreign key to animals table */
BEGIN;
ALTER TABLE animals
ADD CONSTRAINT owner_fk
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;
COMMIT;

/* Use the following comands to create vets table */

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vets_id INT,
    species_id INT,
    CONSTRAINT fk_vets
        FOREIGN KEY(vets_id)
            REFERENCES vets(id),
     CONSTRAINT fk_species
        FOREIGN KEY(species_id)
            REFERENCES species(id)
);
