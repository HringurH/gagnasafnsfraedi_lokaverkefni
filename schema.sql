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

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    item_type_id INT NOT NULL,
    origin_location_id INT,
    creation_era_id INT,
    creation_year INT,

    CONSTRAINT fk_item_type
        FOREIGN KEY (item_type_id)
        REFERENCES item_types(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_origin_location
        FOREIGN KEY (origin_location_id)
        REFERENCES locations(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_creation_era
        FOREIGN KEY (creation_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_era_id INT NOT NULL,
    start_year INT NOT NULL,
    end_era_id INT,
    end_year INT,
    location_id INT,
    event_type_id INT NOT NULL,

    CONSTRAINT fk_start_era
        FOREIGN KEY (start_era_id)
        REFERENCES eras(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_end_era
        FOREIGN KEY (end_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_location
        FOREIGN KEY (location_id)
        REFERENCES locations(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_event_type
        FOREIGN KEY (event_type_id)
        REFERENCES event_types(id)
        ON DELETE CASCADE
);

CREATE TABLE character_faction_history (
    character_id INT NOT NULL,
    faction_id INT NOT NULL,
    join_era_id INT,
    join_year INT,
    leave_era_id INT,
    leave_year INT,
    role VARCHAR(255),

    PRIMARY KEY (character_id, faction_id, join_era_id, join_year),
    CONSTRAINT fk_character
        FOREIGN KEY (character_id)
        REFERENCES characters(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_faction
        FOREIGN KEY (faction_id)
        REFERENCES factions(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_join_era
        FOREIGN KEY (join_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_leave_era
        FOREIGN KEY (leave_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE character_location_history (
    character_id INT NOT NULL,
    location_id INT NOT NULL,
    start_era_id INT,
    start_year INT,
    end_era_id INT,
    end_year INT,

    PRIMARY KEY (character_id, location_id, start_era_id, start_year),
    CONSTRAINT fk_clh_character
        FOREIGN KEY (character_id)
        REFERENCES characters(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_clh_location
        FOREIGN KEY (location_id)
        REFERENCES locations(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_start_era_loc
        FOREIGN KEY (start_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_end_era_loc
        FOREIGN KEY (end_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE item_character_history (
    item_id INT NOT NULL,
    character_id INT NOT NULL,
    start_era_id INT,
    start_year INT,
    end_era_id INT,
    end_year INT,

    PRIMARY KEY (item_id, character_id, start_era_id, start_year),
    CONSTRAINT fk_ich_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ich_character
        FOREIGN KEY (character_id)
        REFERENCES characters(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_start_era_item_char
        FOREIGN KEY (start_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_end_era_item_char
        FOREIGN KEY (end_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE item_location_history (
    item_id INT NOT NULL,
    location_id INT NOT NULL,
    start_era_id INT,
    start_year INT,
    end_era_id INT,
    end_year INT,

    PRIMARY KEY (item_id, location_id, start_era_id, start_year),
    CONSTRAINT fk_ilh_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ilh_location
        FOREIGN KEY (location_id)
        REFERENCES locations(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_start_era_item_loc
        FOREIGN KEY (start_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_end_era_item_loc
        FOREIGN KEY (end_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE item_creators (
    item_id INT NOT NULL,
    character_id INT NOT NULL,

    PRIMARY KEY (item_id, character_id),
    CONSTRAINT fk_ic_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ic_character
        FOREIGN KEY (character_id)
        REFERENCES characters(id)
        ON DELETE CASCADE
);

CREATE TABLE faction_location_history (
    faction_id INT NOT NULL,
    location_id INT NOT NULL,
    start_era_id INT,
    start_year INT,
    end_era_id INT,
    end_year INT,

    PRIMARY KEY (faction_id, location_id, start_era_id, start_year),
    CONSTRAINT fk_flh_faction
        FOREIGN KEY (faction_id)
        REFERENCES factions(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_flh_location
        FOREIGN KEY (location_id)
        REFERENCES locations(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_start_era_faction_loc
        FOREIGN KEY (start_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_end_era_faction_loc
        FOREIGN KEY (end_era_id)
        REFERENCES eras(id)
        ON DELETE SET NULL
);

CREATE TABLE faction_races (
    faction_id INT NOT NULL,
    race_id INT NOT NULL,

    PRIMARY KEY (faction_id, race_id),
    CONSTRAINT fk_fr_faction
        FOREIGN KEY (faction_id)
        REFERENCES factions(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_fr_race
        FOREIGN KEY (race_id)
        REFERENCES races(id)
        ON DELETE CASCADE
);

CREATE TABLE event_characters (
    event_id INT NOT NULL,
    character_id INT NOT NULL,

    PRIMARY KEY (event_id, character_id),
    CONSTRAINT fk_ec_event
        FOREIGN KEY (event_id)
        REFERENCES events(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ec_character
        FOREIGN KEY (character_id)
        REFERENCES characters(id)
        ON DELETE CASCADE
);

CREATE TABLE event_factions (
    event_id INT NOT NULL,
    faction_id INT NOT NULL,

    PRIMARY KEY (event_id, faction_id),
    CONSTRAINT fk_ef_event
        FOREIGN KEY (event_id)
        REFERENCES events(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ef_faction
        FOREIGN KEY (faction_id)
        REFERENCES factions(id)
        ON DELETE CASCADE
);

CREATE TABLE event_items (
    event_id INT NOT NULL,
    item_id INT NOT NULL,

    PRIMARY KEY (event_id, item_id),
    CONSTRAINT fk_ei_event
        FOREIGN KEY (event_id)
        REFERENCES events(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ei_item
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE CASCADE
);

CREATE VIEW character_profiles AS (
    SELECT c.id AS character_id, c.name AS character_name,
           r.name AS race_name, c.title, c.description,
           e_start.absolute_start_year + c.birth_year AS absolute_birth_year,
           e_end.absolute_start_year + c.death_year AS absolute_death_year, 
           c.is_immortal
    FROM characters c
    JOIN races r ON c.race_id = r.id
    LEFT JOIN eras e_start ON c.birth_era_id = e_start.id
    LEFT JOIN eras e_end ON c.death_era_id = e_end.id
);

CREATE VIEW item_profiles AS (
    SELECT i.id AS item_id, i.name AS item_name,
        it.name AS item_type,
        l.name AS origin_location,
        e.absolute_start_year + i.creation_year AS absolute_creation_year,
        ARRAY(
            SELECT c.name
            FROM item_creators ic
            JOIN characters c ON ic.character_id = c.id
            WHERE ic.item_id = i.id
        ) AS creators
    FROM items i
    JOIN item_types it ON i.item_type_id = it.id
    LEFT JOIN locations l ON i.origin_location_id = l.id
    LEFT JOIN eras e ON i.creation_era_id = e.id
);

CREATE VIEW event_details AS (
    SELECT 
        e.id AS event_id,
        e.name,
        et.name AS event_type,
        l.name AS location_name,
        e.description,
        es.absolute_start_year + e.start_year AS absolute_start_year,
        ee.absolute_start_year + e.end_year AS absolute_end_year,
        ARRAY(SELECT c.name FROM event_characters ec
            JOIN characters c ON ec.character_id = c.id
            WHERE ec.event_id = e.id) AS characters_involved,
        ARRAY(SELECT f.name FROM event_factions ef
            JOIN factions f ON ef.faction_id = f.id
            WHERE ef.event_id = e.id) AS factions_involved,
        ARRAY(SELECT i.name FROM event_items ei
            JOIN items i ON ei.item_id = i.id
            WHERE ei.event_id = e.id) AS items_involved
    FROM events e
    JOIN event_types et ON e.event_type_id = et.id
    LEFT JOIN locations l ON e.location_id = l.id
    LEFT JOIN eras es ON e.start_era_id = es.id
    LEFT JOIN eras ee ON e.end_era_id = ee.id
);

CREATE INDEX idx_character_name ON characters(name);
CREATE INDEX idx_character_title ON characters(title);
CREATE INDEX idx_item_name ON items(name);
CREATE INDEX idx_location_name ON locations(name);
CREATE INDEX idx_faction_name ON factions(name);
CREATE INDEX idx_event_name ON events(name);
CREATE INDEX idx_race_name ON races(name);
CREATE INDEX idx_era_name ON eras(name);