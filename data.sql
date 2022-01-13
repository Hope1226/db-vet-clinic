/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-2-3', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-1-7', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-5-12', 5, true, 11.00);
ALTER TABLE animals  ADD species VARCHAR(250);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-2-8', 0, false, 11.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2022-11-15', 2, true, 5.70);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-4-2', 3, false, 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-6-12', 1, true, 45.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-6-7', 7, true, 20.40);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17.00);

/* Transactions */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;


BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Populate owner table */
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jannifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Deam Winchester', 14),
       ('Jodie Whittaker', 38);

/* Populate species table */
INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

/* Add values to species_id in animals table */
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon%';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;



