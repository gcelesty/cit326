-- 2 Schemas w/ 2 tables
alter schema pokemonINFO transfer pokemon;
alter schema pokemonINFO transfer pokemon_species;

alter schema growthINFO transfer growth_rate_prose;
alter schema growthINFO transfer growth_rates;

-- View with mix-matched schemas
create view pokemonINFO.pokemon_to_growth_speed
as
select pokemonINFO.pokemon_species.identifier, growthINFO.growth_rate_prose.name
from pokemonINFO.pokemon_species
join growthINFO.growth_rate_prose
on pokemonINFO.pokemon_species.growth_rate_id = growthINFO.growth_rate_prose.growth_rate_id;