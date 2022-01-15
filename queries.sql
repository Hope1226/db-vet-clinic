/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01'  AND '2019-12-31';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.30 OR weight_kg = 10.40 AND weight_kg = 17.30;

/* AGREGATED FUNCTIONS */

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals GROUP BY escape_attempts HAVING escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01'  AND '2000-12-31' GROUP BY species;

/* JOINS */

/* What animals belong to Melody Pond? */
SELECT animals.name, owners.full_name
FROM owners
INNER JOIN animals ON owners.id = owner_id WHERE owners.id = 4;

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name
FROM species
INNER JOIN animals ON species.id = species_id WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT owners.full_name, animals.name
FROM owners
FULL JOIN animals ON owners.id = owner_id;

/* How many animals are there per species? */
SELECT species.name, COUNT(species.name)
FROM species
FULL JOIN animals ON species.id = species_id GROUP BY species.name;

/* How many animals are there per species? */
SELECT animals.name, species.name
FROM species
INNER JOIN animals ON species.id = species_id WHERE species.name = 'Digimon' AND animals.owner_id = 2;

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Deam Winchester';

/* Who owns the most animals? */
SELECT owners.full_name AS owners_name, COUNT(owner_id) AS number_animals_owned
FROM animals
INNER JOIN owners ON owner_id = owners.id GROUP BY owners.full_name;


/* Who was the last animal seen by William Tatcher? */
SELECT animals.name, visits.visit_date
FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vets_id = vets.id WHERE vets.name = 'William Tatcher';

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(*)
FROM visits
JOIN vets ON vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name, species.name
FROM specializations
FULL JOIN vets ON vets_id = vets.id LEFT JOIN species ON species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name, visits.visit_date, vets.name
FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date
BETWEEN '2020-4-1' AND '2020-8-30';

/* What animal has the most visits to vets? */
SELECT animals.name AS animal_name, COUNT(visits.animal_id) AS number_of_visits
FROM visits
JOIN animals ON animal_id = animals.id GROUP BY animals.name ORDER BY number_of_visits DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT animals.name, visits.visit_date
FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vets_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visit_date LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT 
animals.name AS animal_name, 
animals.date_of_birth AS animal_date_of_birth, 
animals.escape_attempts AS animal_escape_attempts, 
animals.neutered, 
animals.weight_kg AS animal_weight_kg,
species.name AS species,
vets.name AS vets_name,
vets.age AS vet_age,
vets.date_of_graduation AS vets_graduation_year,
visits.visit_date
FROM visits
JOIN animals ON animal_id = animals.id
JOIN species ON visits.vets_id = species.id
JOIN vets ON vets_id = vets.id ORDER BY visits.visit_date DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(*)
FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN specializations ON visits.vets_id = specializations.vets_id
WHERE specializations.species_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT 
vets.name AS vet_name,
species.name,
COUNT(species.name) AS n_of_species_treated
FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vets_id = vets.id
JOIN species ON animals.species_id = species.id
GROUP BY species.name, vets.name
HAVING vets.name = 'Maisy Smith' ORDER BY COUNT(species.name) DESC;