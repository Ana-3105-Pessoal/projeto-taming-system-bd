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
select * from specie -- add 16 species
select * from map -- add 9 maps
select * from tribe -- add 3 tribes
select * from item -- add 21 items
select * from player -- add 7 players
select * from creature -- add 2 creatures
select * from spawn_rate -- add 10 spawn_rate
select * from creature_mutation -- add 0 creature_mutation
select * from domestication -- add 1 domestication
select * from inventory -- add 7 inventory

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

alter table creature add column level integer check (level >= 1)

alter table spawn_rate add constraint id_spawn_rate primary key (fk_specie,fk_map)

alter table creature_mutation add constraint id_creature_mutation primary key (fk_creature,fk_mutation)

alter table inventory add constraint id_inventory primary key (fk_player,fk_item)

insert into item (name,type,rarity)
values
('Tranq Arrow','ammo','primitive'),
('Stone Arrow','ammo','primitive'),
('Tranquilizer Dart','ammo','primitive'),
('Simple Rifle Ammo','ammo','primitive'),
('Bow Primitive','weapon','primitive'),
('Bow Apprentice','weapon','apprentice'),
('Crossbow Journeyman','weapon','journeyman'),
('Crossbow Primitive','weapon','primitive'),
('Longneck Rifle Primitive','weapon','primitive'),
('Longneck Rifle Mastercraft','weapon','primitive')
('Extraordinary Kibble','kibble','ascendant'),
('Superior Kibble','kibble','journeyman'),
('Simple Kibble','kibble','ramshackle'),
('Raw Mutton','consumable','primitive'),
('Metal Ingot','resources','primitive'),
('Raw Meat','consumable','primitive'),
('Wood','resources','primitive'),
('Stone','resources','primitive'),
('Argentavis Saddle','equipment','primitive'),
('Rex Saddle','equipment','primitive'),
('Therizinosaur Saddle','equipment','primitive')

insert into player (username,level,health,stamina,join_date)
values
('Helena Walker',200,100000,1000,'2020-01-01'),
('Edmund Rockwell',155,50000,2000,'2000-05-12'),
('Mei Yin Li',198,80000,3000,'2000-04-27'),
('Gaius Marcellus Nerva',100,25000,1000,'2010-05-23'),
('Diana',175,60000,1500,'2001-08-21'),
('Santiago',199,90000,2500,'1990-12-30')

update tribe
set name = 'Tribe Tech'
where name = 'Cave Explores'

update tribe
set name = 'The New Legion'
where name = 'Rising Tribe'

update player
set fk_tribe = (select id_tribe from tribe where name = 'The New Legion')
where username = 'Gaius Marcellus Nerva'

update player
set fk_tribe = (select id_tribe from tribe where name = 'Tribe Tech')
where username = 'Diana'

update player
set fk_tribe = (select id_tribe from tribe where name = 'Tribe Tech')
where username = 'Santiago'

insert into inventory (fk_player, fk_item, quantity)
values
((select id_player from player where username = 'Mei Yin Li'), (select id_item from item where name = 'Rex Saddle'),1),
((select id_player from player where username = 'Santiago'), (select id_item from item where name = 'Longneck Rifle Mastercraft'),1),
((select id_player from player where username = 'Santiago'), (select id_item from item where name = 'Tranquilizer Dart'),100),
((select id_player from player where username = 'Santiago'), (select id_item from item where name = 'Simple Rifle Ammo'),400),
((select id_player from player where username = 'Diana'), (select id_item from item where name = 'Therizinosaur Saddle'),1),
((select id_player from player where username = 'Helena Walker'), (select id_item from item where name = 'Extraordinary Kibble'),10),
((select id_player from player where username = 'Helena Walker'), (select id_item from item where name = 'Raw Mutton'),50)

select player.username,item.name,inventory.quantity
from inventory
join player on id_player = fk_player
join item on id_item = fk_item
where username = 'Santiago'

select player.username, tribe.name
from player
join tribe on id_tribe = fk_tribe
where name = 'Tribe Tech'

insert into player (username,level,health,stamina,join_date)
values
('Bob',1,100,100,'2026-06-09')

update player
set fk_tribe = (select id_tribe from tribe where name = 'The Nobby Survive')
where username = 'Bob'

insert into inventory (fk_player, fk_item, quantity)
values
((select id_player from player where username = 'Bob'), (select id_item from item where name = 'Wood'),100),
((select id_player from player where username = 'Bob'), (select id_item from item where name = 'Stone'),100)

insert into specie (name, diet, threat_level,can_fly,can_swim)
values
('Dodo','herbivore',1,false, true),
('Moschops','omnivore',1,false,true),
('Parasaur','herbivore',1,false,true),
('Pteranodon','carnivore',1,true,false),
('Jerboa','herbivore',1,false,true),
('Raptor','carnivore',3.,false,true)

insert into creature (fk_specie, nickname,sex,status,health,stamina,level)
values
((select id_specie from specie where name = 'Dodo'),'Dodo','F','wild',350,120,120),
((select id_specie from specie where name = 'Parasaur'),'Parasaur','M','wild',2086,1228,80)

begin transaction;

insert into domestication (fk_player, fk_creature,tame_date,method,effectiveness,time_spent_min)
values
((select id_player from player where username = 'Bob'),(select id_creature from creature where nickname = 'Dodo'),'2026-06-09','violent',99.9,5);

update creature
set status = 'tamed'
where nickname = 'Dodo';

update creature
set nickname = 'Dodozinho'
where nickname = 'Dodo';

update creature
set level = 179
where nickname = 'Dodozinho';

commit

select player.username, creature.nickname, creature.status, domes.method
from domestication domes
join player on id_player = fk_player
join creature on id_creature = fk_creature
where username = 'Bob'