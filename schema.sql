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
    name VARCHAR(250)
);