CREATE TABLE Mutation (
    id_mutation serial PRIMARY KEY,
    attribute varchar(20) CHECK (attribute IN ('health', 'stamina', 'melee', 'speed', 'weight')),
    description text
)

CREATE TABLE Specie (
    id_specie serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    diet varchar(20) CHECK (diet IN ('carnivore', 'herbivore', 'omnivore', 'piscivore')),
    threat_level INTEGER CHECK (threat_level BETWEEN 1 AND 5),
    can_fly BOOLEAN,
    can_swim BOOLEAN
)

CREATE TABLE Map (
    id_map serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    biome varchar(30) CHECK (biome IN ('jungle', 'arctic', 'desert', 'ocean', 'volcanic')),
    difficulty INTEGER CHECK (difficulty BETWEEN 1 AND 5)
)

CREATE TABLE Tribe (
    id_tribe serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    max_members INTEGER CHECK (max_members > 0),
    founding_date DATE
)

CREATE TABLE Item (
    id_item serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    type varchar(20) CHECK (type IN ('kibble', 'narcotic', 'food', 'tool')),
    rarity varchar(20) CHECK (rarity IN ('common', 'uncommon', 'rare', 'epic', 'legendary'))
)

CREATE TABLE Player (
    id_player serial PRIMARY KEY,
    fk_tribe integer null,
    username varchar(100) UNIQUE,
    level integer CHECK (level BETWEEN 1 AND 200),
    health NUMERIC(8,2),
    stamina NUMERIC(8,2),
    join_date DATE
)

CREATE TABLE Creature (
    id_creature serial PRIMARY KEY,
    fk_specie integer,
    nickname varchar(100),
    sex char(1) CHECK (sex IN ('M', 'F')),
    status varchar(20) CHECK (status IN ('wild', 'tamed', 'dead')),
    health NUMERIC(8,2),
    stamina NUMERIC(8,2)
)

CREATE TABLE Spawn_rate (
    fk_specie integer,
    fk_map integer,
    frequency varchar(20) CHECK (frequency IN ('rare', 'uncommon', 'common'))
)

CREATE TABLE Creature_mutation (
    fk_creature integer,
    fk_mutation integer,
    generation INTEGER CHECK (generation >= 1),
    value NUMERIC(8,2)
)

CREATE TABLE Domestication (
    id_domestication serial PRIMARY KEY,
    fk_player integer,
    fk_creature integer,
    tame_date DATE,
    method varchar(20) CHECK (method IN ('passive', 'violent')),
    effectiveness NUMERIC(5,2) CHECK (effectiveness BETWEEN 0 AND 100),
    time_spent_min INTEGER
)

CREATE TABLE Inventory (
    fk_player integer,
    fk_item integer,
    quantity INTEGER (quantity > 0)
)
