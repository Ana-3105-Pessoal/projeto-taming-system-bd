create table mutation (
    id_mutation serial primary key,
    attribute varchar(20) check (attribute in ('health', 'stamina', 'melee', 'speed', 'weight')),
    description text
);

create table specie (
    id_specie serial primary key,
    name varchar(100) unique,
    diet varchar(20) check (diet in ('carnivore', 'herbivore', 'omnivore', 'piscivore')),
    threat_level integer check (threat_level between 1 and 5),
    can_fly boolean,
    can_swim boolean
);

create table map (
    id_map serial primary key,
    name varchar(100) unique,
    biome varchar(30) check (biome in ('jungle', 'arctic', 'desert', 'ocean', 'volcanic')),
    difficulty integer check (difficulty between 1 and 5)
);

create table tribe (
    id_tribe serial primary key,
    name varchar(100) unique,
    max_members integer check (max_members > 0),
    founding_date date
);

create table item (
    id_item serial primary key,
    name varchar(100) unique,
    type varchar(20) check (type in ('kibble', 'narcotic', 'food', 'tool')),
    rarity varchar(20) check (rarity in ('common', 'uncommon', 'rare', 'epic', 'legendary'))
);

create table player (
    id_player serial primary key,
    fk_tribe integer null references tribe(id_tribe),
    username varchar(100) unique,
    level integer check (level between 1 and 200),
    health numeric(8,2),
    stamina numeric(8,2),
    join_date date
);

create table creature (
    id_creature serial primary key,
    fk_specie integer not null references specie(id_specie),
    nickname varchar(100),
    sex char(1) check (sex in ('M', 'F')),
    status varchar(20) not null check (status in ('wild', 'tamed', 'dead')),
    health numeric(8,2),
    stamina numeric(8,2)
);

create table spawn_rate (
    fk_specie integer not null references specie(id_specie),
    fk_map integer not null references map(id_map),
    frequency varchar(20) check (frequency in ('rare', 'uncommon', 'common'))
);

create table creature_mutation (
    fk_creature integer not null references creature(id_creature),
    fk_mutation integer not null references mutation(id_mutation),
    generation integer check (generation >= 1),
    value numeric(8,2)
);

create table domestication (
    id_domestication serial primary key,
    fk_player integer not null references player(id_player),
    fk_creature integer not null references creature(id_creature),
    tame_date date,
    method varchar(20) check (method in ('passive', 'violent')),
    effectiveness numeric(5,2) check (effectiveness between 0 and 100),
    time_spent_min integer
);

create table inventory (
    fk_player integer not null references player(id_player),
    fk_item integer not null references item(id_item),
    quantity integer check (quantity > 0)
);

select * from mutation -- add 0 mutations
select * from specie -- add 10 species
select * from map -- add 9 maps
select * from tribe -- add 3 tribes
select * from item -- add 0 items
select * from player -- add 0 players
select * from creature -- add 0 creatures
select * from spawn_rate -- add 10 spawn_rate
select * from creature_mutation -- add 0 creature_mutation
select * from domestication -- add 0 domestication
select * from inventory -- 0 inventory

insert into map (name,biome,difficulty)
values
('The Island', 'jungle', 1),
('Lost Colony','arctic',5),
('Scorched Earth','desert',4),
('Valguero','jungle',3)

alter table map drop constraint map_biome_check

insert into map (name,biome,difficulty)
values
('Astraeos','mountain',3),
('The Center','ocean',2),
('Extinction','city',4),
('Ragnarok','mountain',3),
('Aberration','underground',5)

insert into specie (name, diet, threat_level,can_fly,can_swim)
values
('Argentavis','carnivore',2,true, false),
('Ovis', 'herbivore',1,false,true),
('Rex','carnivore',5,false,true),
('Therizinosaur','herbivore',5,false,true),
('Dire Bear','omnivore',4,false,true),
('Basilosaurus','carnivore',1,false,true),
('Deinosuchus','carnivore',5,false,true),
('Cat','carnivore',2,false,true),
('Griffin','carnivore',4,true,false),
('Baryonyx','piscivore',3,false,true)

insert into tribe (name,max_members,founding_date)
values
('Nobby Sobrevive',25,'2021-08-16')

insert into spawn_rate (fk_specie,fk_map,frequency)
values
((select id_specie from specie where name = 'Cat'),(select id_map from map where name = 'The Island'), 'rare')

select specie.name, map.name as mapa, spawn.frequency
from spawn_rate spawn
join specie on id_specie = fk_specie
join map on id_map = fk_map
where specie.name = 'Cat'

update tribe
set name = 'The Nobby Survive'
where name = 'Nobby Sobrevive'

alter table item drop constraint item_type_check

alter table item drop constraint item_rarity_check

alter table item 
add constraint rarity 
check (rarity in('primitive', 'ramshackle', 'apprentice', 'journeyman', 'mastercraft', 'ascendant'))

alter table item
add constraint type
check (type in('resources','consumable','weapon','equipment','kibble','ammo'))

insert into tribe (name,max_members,founding_date)
values
('Rising Tribe',35,'2026-01-31'),
('Cave Explores',20,'2025-12-25')

insert into spawn_rate (fk_specie,fk_map,frequency)
values
((select id_specie from specie where name = 'Baryonyx'),(select id_map from map where name = 'The Center'), 'uncommon'),
((select id_specie from specie where name = 'Griffin'),(select id_map from map where name = 'Valguero'), 'rare'),
((select id_specie from specie where name = 'Argentavis'),(select id_map from map where name = 'Astraeos'), 'common'),
((select id_specie from specie where name = 'Ovis'),(select id_map from map where name = 'Aberration'), 'rare'),
((select id_specie from specie where name = 'Rex'),(select id_map from map where name = 'Extinction'), 'uncommon'),
((select id_specie from specie where name = 'Basilosaurus'),(select id_map from map where name = 'The Center'), 'common'),
((select id_specie from specie where name = 'Therizinosaur'),(select id_map from map where name = 'Lost Colony'), 'uncommon'),
((select id_specie from specie where name = 'Dire Bear'),(select id_map from map where name = 'Valguero'), 'uncommon'),
((select id_specie from specie where name = 'Deinosuchus'),(select id_map from map where name = 'The Island'), 'rare')