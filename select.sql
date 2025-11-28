--- Sýnir nöfn allra persóna ásamt lista yfir staði sem þær hafa heimsótt ásamt dagsetningu komu þeirra
SELECT c.name AS charcter_name, STRING_AGG(l.name || ' ' || e.abbreviation || ' ' || clh.start_year, ', ') AS locations_visited
FROM characters c
JOIN character_location_history clh ON c.id = clh.character_id
JOIN eras e ON clh.start_era_id = e.id
JOIN locations l ON clh.location_id = l.id
GROUP BY c.id;

--- Sýnir nöfn allra fylkinga ásamt tegund þeirra, lýsingu og stofnunardegi í röð eftir stofnunardegi
SELECT f.name AS faction_name, ft.name AS faction_type, f.description AS faction_description, (e.abbreviation || ' ' || f.founded_year) AS founded_date
FROM factions f
JOIN faction_types ft ON f.faction_type_id = ft.id
JOIN eras e ON f.founded_era_id = e.id
ORDER BY e.absolute_start_year + f.founded_year;

--- Sýnir eiganda sögu 'The One Ring' í röð eftir dagsetningu
SELECT i.name AS item_name, c.name AS possessor_name, (e.abbreviation || ' ' || ich.start_year) AS acquired_date
FROM items i
JOIN item_character_history ich ON i.id = ich.item_id
JOIN characters c ON ich.character_id = c.id
JOIN eras e ON ich.start_era_id = e.id
WHERE i.name = 'The One Ring'
ORDER BY e.absolute_start_year + ich.start_year;