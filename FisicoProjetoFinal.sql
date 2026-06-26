/* LogicoProjetoFinal: */

CREATE TABLE Player (
    id_player serial PRIMARY KEY,
    fk_tribe serial,
    username varchar(100) UNIQUE,
    level INTEGER,
    health NUMERIC(8,2),
    stamina NUMERIC(8,2),
    join_date DATE
);

CREATE TABLE Specie (
    id_specie serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    diet varchar(20),
    threat_level INTEGER,
    can_fly BOOLEAN,
    can_swim BOOLEAN
);

CREATE TABLE Creature (
    id_creature serial PRIMARY KEY,
    fk_specie serial,
    nickname varchar(100),
    sex char(1),
    status varchar(20),
    health NUMERIC(8,2),
    stamina NUMERIC(8,2)
);

CREATE TABLE Map (
    id_map serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    biome varchar(30),
    difficulty INTEGER
);

CREATE TABLE Tribe (
    id_tribe serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    max_members INTEGER,
    founding_date DATE
);

CREATE TABLE Item (
    id_item serial PRIMARY KEY,
    name varchar(100) UNIQUE,
    type varchar(20),
    rarity varchar(20)
);

CREATE TABLE Mutation (
    id_mutation serial PRIMARY KEY,
    attribute varchar(20),
    description text
);

CREATE TABLE Spawn_rate (
    fk_specie serial,
    fk_map serial,
    frequency varchar(20)
);

CREATE TABLE Creature_mutation (
    fk_creature serial,
    fk_mutation serial,
    generation INTEGER,
    value NUMERIC(8,2)
);

CREATE TABLE Domestication (
    id_domestication serial PRIMARY KEY,
    fk_player serial,
    fk_creature serial,
    tame_date DATE,
    method varchar(20),
    effectiveness NUMERIC(5,2),
    time_spent_min INTEGER
);

CREATE TABLE Inventory_stores (
    fk_player serial,
    fk_item serial,
    quantity INTEGER
);
 
ALTER TABLE Player ADD CONSTRAINT FK_Player_3
    FOREIGN KEY (fk_tribe)
    REFERENCES Tribe (id_tribe);
 
ALTER TABLE Specie ADD CONSTRAINT FK_Specie_2
    FOREIGN KEY (fk_creature)
    REFERENCES Creature (id_creature)
    ON DELETE CASCADE;
 
ALTER TABLE Creature ADD CONSTRAINT FK_Creature_2
    FOREIGN KEY (fk_specie)
    REFERENCES Specie (id_specie);
 
ALTER TABLE Tribe ADD CONSTRAINT FK_Tribe_2
    FOREIGN KEY (fk_player)
    REFERENCES Player (id_player)
    ON DELETE SET NULL;
 
ALTER TABLE Spawn_rate ADD CONSTRAINT FK_Spawn_rate_1
    FOREIGN KEY (fk_specie)
    REFERENCES Specie (id_specie);
 
ALTER TABLE Spawn_rate ADD CONSTRAINT FK_Spawn_rate_2
    FOREIGN KEY (fk_map)
    REFERENCES Map (id_map);
 
ALTER TABLE Creature_mutation ADD CONSTRAINT FK_Creature_mutation_1
    FOREIGN KEY (fk_creature)
    REFERENCES Creature (id_creature);
 
ALTER TABLE Creature_mutation ADD CONSTRAINT FK_Creature_mutation_2
    FOREIGN KEY (fk_mutation)
    REFERENCES Mutation (id_mutation);
 
ALTER TABLE Domestication ADD CONSTRAINT FK_Domestication_2
    FOREIGN KEY (fk_player)
    REFERENCES Player (id_player);
 
ALTER TABLE Domestication ADD CONSTRAINT FK_Domestication_3
    FOREIGN KEY (fk_creature)
    REFERENCES Creature (id_creature);
 
ALTER TABLE Inventory_stores ADD CONSTRAINT FK_Inventory_stores_1
    FOREIGN KEY (fk_player)
    REFERENCES Player (id_player);
 
ALTER TABLE Inventory_stores ADD CONSTRAINT FK_Inventory_stores_2
    FOREIGN KEY (fk_item)
    REFERENCES Item (id_item);