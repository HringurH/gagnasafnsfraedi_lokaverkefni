CREATE DATABASE lotr_db;

CREATE TABLE eras (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(5) NOT NULL,
    description TEXT,
    absolute_start_year INT NOT NULL
);

CREATE TABLE location_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE races (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_race_id INT,

    CONSTRAINT fk_parent_race
        FOREIGN KEY (parent_race_id)
        REFERENCES races(id)
        ON DELETE SET NULL
);

CREATE TABLE item_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE faction_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE event_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location_type_id INT NOT NULL,
    parent_location_id INT,

    CONSTRAINT fk_location_type
        FOREIGN KEY (location_type_id)
        REFERENCES location_types(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_parent_location
        FOREIGN KEY (parent_location_id)
        REFERENCES locations(id)
        ON DELETE SET NULL
);

CREATE TABLE factions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    faction_type_id INT NOT NULL,
    parent_faction_id INT,
    description TEXT,
    founded_era_id INT,
    founded_year INT,
    dissolved_era_id INT,
    dissolved_year INT,

    CONSTRAINT fk_faction_type
        FOREIGN KEY (faction_type_id)
        REFERENCES faction_types(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_parent_faction
        FOREIGN KEY (parent_faction_id)
        REFERENCES factions(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_founded_era
        FOREIGN KEY (founded_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_dissolved_era
        FOREIGN KEY (dissolved_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    race_id INT NOT NULL,
    title VARCHAR(255),
    description TEXT,
    birth_era_id INT,
    birth_year INT,
    death_era_id INT,
    death_year INT,
    is_immortal BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_race
        FOREIGN KEY (race_id)
        REFERENCES races(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_birth_era
        FOREIGN KEY (birth_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_death_era
        FOREIGN KEY (death_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);