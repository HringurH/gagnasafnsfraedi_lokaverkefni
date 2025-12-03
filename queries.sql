--- 1. Sýnir nöfn allra persóna ásamt lista yfir staði sem þær hafa heimsótt ásamt dagsetningu komu þeirra
SELECT c.name AS charcter_name, STRING_AGG(l.name || ' ' || e.abbreviation || ' ' || clh.start_year, ', ') AS locations_visited
FROM characters c
JOIN character_location_history clh ON c.id = clh.character_id
JOIN eras e ON clh.start_era_id = e.id
JOIN locations l ON clh.location_id = l.id
GROUP BY c.id;


--- 2. Sýnir nöfn allra fylkinga ásamt tegund þeirra, lýsingu og stofnunardegi í röð eftir stofnunardegi
SELECT f.name AS faction_name, ft.name AS faction_type, f.description AS faction_description, (e.abbreviation || ' ' || f.founded_year) AS founded_date
FROM factions f
JOIN faction_types ft ON f.faction_type_id = ft.id
JOIN eras e ON f.founded_era_id = e.id
ORDER BY e.absolute_start_year + f.founded_year;


--- 3. Sýnir eiganda sögu 'The One Ring' í röð eftir dagsetningu
SELECT i.name AS item_name, c.name AS possessor_name, (e.abbreviation || ' ' || ich.start_year) AS acquired_date
FROM items i
JOIN item_character_history ich ON i.id = ich.item_id
JOIN characters c ON ich.character_id = c.id
JOIN eras e ON ich.start_era_id = e.id
WHERE i.name = 'The One Ring'
ORDER BY e.absolute_start_year + ich.start_year;

--- 4. Sýnir nöfn allra persóna sem hafa verið í Mordor eða sub-locations þess
WITH RECURSIVE sub_locations AS (
    SELECT id, name, parent_location_id
    FROM locations
    WHERE name = 'Mordor'
    
    UNION ALL
    
    SELECT l.id, l.name, l.parent_location_id
    FROM locations l
    INNER JOIN sub_locations sl ON l.parent_location_id = sl.id
)
SELECT DISTINCT c.name AS character_name, c.description AS character_description, sl.name AS location_name
FROM characters c
JOIN character_location_history clh ON c.id = clh.character_id
JOIN sub_locations sl ON clh.location_id = sl.id;

--- 5. Sýnir hvaða persónur höfðu titillinn 'King' eða 'Prince' og hvaða factions þær tilheyrðu
SELECT c.name AS character_name, c.title AS title_name, STRING_AGG(f.name, ', ') AS factions 
FROM characters c
JOIN character_faction_history cfh ON c.id = cfh.character_id
JOIN factions f ON cfh.faction_id = f.id
GROUP BY c.id
HAVING c.title LIKE '%King%' OR c.title LIKE '%Prince%';

--- 6. Sýnir nöfn og lýsingu persóna sem haf verið hluti af fleiri en einni fylkingu
SELECT c.name AS character_name, c.description AS character_description, STRING_AGG(f.name || ' ' || e.abbreviation || ' ' || cfh.join_year, ', ') AS factions
FROM characters c
JOIN character_faction_history cfh ON c.id = cfh.character_id
JOIN factions f ON cfh.faction_id = f.id
JOIN eras e ON cfh.join_era_id = e.id
GROUP BY c.id
HAVING COUNT(DISTINCT f.id) > 1;

--- 7. Sýnir nöfn og lýsingu allra staða í 'Middle-earth'
WITH RECURSIVE middle_earth_locations AS (
    SELECT id, name, description, parent_location_id
    FROM locations
    WHERE name = 'Middle-earth'
    
    UNION ALL
    
    SELECT l.id, l.name, l.description, l.parent_location_id
    FROM locations l
    INNER JOIN middle_earth_locations mel ON l.parent_location_id = mel.id
)
SELECT name, description
FROM middle_earth_locations;

--- 8. Sýnir nafn og lýsing allra atburða sem áttu sér stað í 'Mordor'
WITH RECURSIVE sub_locations AS (
    SELECT id, name, parent_location_id
    FROM locations
    WHERE name = 'Mordor'
    
    UNION ALL
    
    SELECT l.id, l.name, l.parent_location_id
    FROM locations l
    INNER JOIN sub_locations sl ON l.parent_location_id = sl.id
)
SELECT e.name AS event_name, e.description AS event_description, sl.name AS location_name
FROM events e
JOIN sub_locations sl ON e.location_id = sl.id;

--- 9. Sýnir nöfn og lýsingu allra kynþátta sem eru undir 'Men'
WITH RECURSIVE sub_races AS (
    SELECT id, name, description, parent_race_id
    FROM races
    WHERE name = 'Men'
    
    UNION ALL
    
    SELECT r.id, r.name, r.description, r.parent_race_id
    FROM races r
    INNER JOIN sub_races sr ON r.parent_race_id = sr.id
)
SELECT name AS race_name, description AS race_description
FROM sub_races;

--- 10. Sýnir nöfn allra kynþátta sem tilheyra fylkingunni 'The Fellowship of the Ring' ásamt lista yfir persónur sem tilheyra hverju kynþætti
SELECT r.name AS race_name, STRING_AGG(c.name, ', ') AS characters
FROM characters c
JOIN races r ON c.race_id = r.id
WHERE r.name IN (
    SELECT r.name
    FROM factions f
    JOIN faction_races fr ON f.id = fr.faction_id
    JOIN races r ON fr.race_id = r.id
    WHERE f.name = 'The Fellowship of the Ring'
    )
GROUP BY r.id;

--- 11. Sýnir nafn, lýsingu og fjölda eiganda hlutsins sem hefur flesta eigendur í sögunni
SELECT i.name AS item_name, i.description AS item_description, COUNT(DISTINCT ich.character_id) AS owner_count
FROM items i
JOIN item_character_history ich ON i.id = ich.item_id
GROUP BY i.id
ORDER BY owner_count DESC
LIMIT 1;

--- 12. Sýnir nöfn og lýsingu allra persóna sem voru á lífi þegar 'Council of Elrond' átti sér stað
WITH absolute_council_date AS (
    SELECT e.absolute_start_year + ev.start_year AS council_year
    FROM events ev
    JOIN eras e ON ev.start_era_id = e.id
    WHERE ev.name = 'Council of Elrond'
)
SELECT cp.character_name AS character_name, cp.description AS character_description
FROM character_profiles cp
WHERE cp.absolute_birth_year < (SELECT council_year FROM absolute_council_date)
AND (cp.absolute_death_year IS NULL OR cp.absolute_death_year > (SELECT council_year FROM absolute_council_date));

--- 13. Sýnir nöfn og lýsingu allra hluta sem hafa verið í atburðum sem urðu á 'Third Age'
SELECT i.name AS item_name, i.description AS item_description, STRING_AGG(e.name, ', ') AS events
FROM items i
JOIN event_items ei ON i.id = ei.item_id
JOIN events e ON ei.event_id = e.id
JOIN eras er ON e.start_era_id = er.id
WHERE er.name = 'Third Age'
GROUP BY i.id;

--- 14. Sýnir nöfn allra persóna sem hafa búið til hluti ásamt lista yfir hluti sem þær hafa búið til
SELECT c.name AS character_name, STRING_AGG(i.name, ', ') AS items_created
FROM characters c
JOIN item_creators ic ON c.id = ic.character_id
JOIN items i ON ic.item_id = i.id
GROUP BY c.id;