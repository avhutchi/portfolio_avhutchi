drop table if exists Pokemon
drop table if exists type
drop table if exists pokemon_type
drop table if exists evolution
drop table if exists Pokemon_evolution


CREATE TABLE Pokemon(
  pokemon_id int identity primary key,
  name varchar(25) not null,
  height_feetinches int,
  weight_lbs int,
  caught_level int not null,
  caught_location varchar(30),
  strengths varchar(100) not null
)

create table Type(
	type_id int identity primary key,
	type varchar(50) not null
	)

create table Pokemon_type (
	pokemon_type_id int identity primary key,
	type_id int not null,
	pokemon_id int not null,
	constraint fk1_pokemon_type foreign key (type_id) references Type(type_id),
	constraint fk2_pokemon_type foreign key (pokemon_id) references Pokemon(pokemon_id)
	)
	
create table Evolution (
	evolution_id int identity primary key,
	post_evolution_name varchar (20) not null,
	additional_type_added varchar (20)
	)

ALTER TABLE Pokemon 
    ADD 
        evolution_level int,
        evolution_instances int

alter table Pokemon
	ADD
		weaknesses varchar (20) not null

ALTER TABLE Pokemon 
	DROP COLUMN 
		strengths,
		weaknesses

create table Pokemon_evolution (
	pokemon_evolution_id int identity,
	pokemon_id int,
	evolution_id int,
	constraint fk1_pokemon_evolution foreign key (pokemon_id) references Pokemon(pokemon_id),
	constraint fk2_pokemon_evolution foreign key (evolution_id) references Evolution(evolution_id)
	)




insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_level, evolution_instances )
values
('Charmander', 2.00, 18.7, 10, 'Volcanic Cave', 16, 2)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_level, evolution_instances )
values
('Squirtle' , 1.08, 19.8, 7, 'Fountainspring Cave', 16, 2)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_instances )
values
('Growlithe' , 2.04, 41.9 , 12, 'Sandsear Cave', 1)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_instances )
values
('Pikachu', 1.04, 13.2, 17, 'Trophy Garden', 1)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_level, evolution_instances )
values
('Abra', 2.11 , 43.0, 4, 'Route 203', 16, 2)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_level, evolution_instances )
values
('Magikarp', 2.11, 22.0, 19, 'Lake Valor', 20, 1)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_instances )
values
('Gyarados' , 21.04, 518.1, 52, 'Route 222', 0)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location )
values
('Eevee', 1.00, 14.3 , 22, 'Pallet Town')

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_instances )
values
('Furret', 5.11, 71.7 , 34, 'Spacious Cave' , 0)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, caught_location, evolution_level, evolution_instances )
values
('Bulbasaur', 2.04, 15.2, 10, 'Grassland Cave', 16, 2)

insert into Pokemon
(name , height_feetinches, weight_lbs, caught_level, evolution_level, evolution_instances )
values
('Charmeleon', 3.07, 41.9, 17, 36, 1)

select * from pokemon

update pokemon
set evolution_instances = '0'
where pokemon_id = 9

insert into Type
(Type)
Values
('Grass')

insert into Type
(Type)
Values
('Water')

insert into Type
(Type)
Values
('Fire')

insert into Type
(Type)
Values
('Electric')

insert into Type
(Type)
Values
('Psychic')

insert into Type
(Type)
Values
('Poison')

insert into Type
(Type)
Values
('Normal')

insert into Type
(Type)
Values
('Dragon')

insert into Type
(Type)
Values
('Flying')

insert into Type
(Type)
Values
('Bug')

insert into Type
(Type)
Values
('Dark')

insert into Type
(Type)
Values
('Ice')

insert into Type
(Type)
Values
('Steel')

insert into Type
(Type)
Values
('Fairy')

insert into Type
(Type)
Values
('Ground')

insert into Type
(Type)
Values
('Fighting')

insert into Type
(Type)
Values
('Rock')

select * from Type

select * from Pokemon_type

insert into Evolution
(post_evolution_name)
values
('Charmeleon'),
('Wartortle'),
('Arcanine'),
('Kadabra'),
('Ivysaur')

insert into Evolution
(post_evolution_name, additional_type_added)
values
('Charizard', 'Flying'),
('Gyarados', 'Flying')

select * from Evolution


INSERT INTO Pokemon_type(type_id,pokemon_id)
VALUES
((SELECT type_id FROM Type WHERE type='Fire'),(SELECT pokemon_id FROM Pokemon WHERE name='Charmander'))

INSERT INTO Pokemon_type(type_id,pokemon_id)
VALUES
((SELECT type_id FROM Type WHERE type='Water'),(SELECT pokemon_id FROM Pokemon WHERE name='Squirtle')),
((SELECT type_id FROM Type WHERE type='Fire'),(SELECT pokemon_id FROM Pokemon WHERE name='Growlithe')),
((SELECT type_id FROM Type WHERE type='Electric'),(SELECT pokemon_id FROM Pokemon WHERE name='Pikachu')),
((SELECT type_id FROM Type WHERE type='Psychic'),(SELECT pokemon_id FROM Pokemon WHERE name='Abra')),
((SELECT type_id FROM Type WHERE type='Water'),(SELECT pokemon_id FROM Pokemon WHERE name='Magikarp')),
((SELECT type_id FROM Type WHERE type='Water'),(SELECT pokemon_id FROM Pokemon WHERE name='Gyarados')),
((SELECT type_id FROM Type WHERE type='Normal'),(SELECT pokemon_id FROM Pokemon WHERE name='Eevee')),
((SELECT type_id FROM Type WHERE type='Normal'),(SELECT pokemon_id FROM Pokemon WHERE name='Furret')),
((SELECT type_id FROM Type WHERE type='Grass'),(SELECT pokemon_id FROM Pokemon WHERE name='Bulbasaur'))


INSERT INTO Pokemon_evolution(evolution_id,pokemon_id)
VALUES
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Charmeleon'),(SELECT pokemon_id FROM Pokemon WHERE name='Charmander')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Arcanine'),(SELECT pokemon_id FROM Pokemon WHERE name='Growlithe')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Wartotle'),(SELECT pokemon_id FROM Pokemon WHERE name='Squirtle')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Kadabra'),(SELECT pokemon_id FROM Pokemon WHERE name='Abra')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Ivysaur'),(SELECT pokemon_id FROM Pokemon WHERE name='Bulbasaur')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Charizard'),(SELECT pokemon_id FROM Pokemon WHERE name='Charmeleon')),
((SELECT evolution_id FROM evolution WHERE post_evolution_name ='Magikarp'),(SELECT pokemon_id FROM Pokemon WHERE name='Gyarados'))




---	Which Pokémon evolve twice?
select name
	,evolution_instances
from pokemon
where evolution_instances = '2'

---	Which Pokémon gain a type after an evolution?
select name
	, additional_type_added
from pokemon
inner join Pokemon_evolution on pokemon.pokemon_id = Pokemon_evolution.pokemon_id 
inner join evolution on evolution.evolution_id = Pokemon_evolution.evolution_id
where additional_type_added != 'NULL'


---	At what level does a specific Pokémon evolve?
go
create procedure find_evolution_level (@name varchar(20)) as
select name
	, evolution_level
	from Pokemon
	where name = @name
go

exec find_evolution_level @name = 'Growlithe'

---	Are there Pokémon that never evolve?
select name
from pokemon
where evolution_instances = 0

go
create view Pokemon_Count as 
select count(name) as Number_of_Pokemon
from pokemon
go

select * from Pokemon_Count

select * from Pokemon_evolution
select * from Evolution
select* from Type
select * from Pokemon_type
select * from Pokemon




