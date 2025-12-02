INSERT INTO eras (name, abbreviation, description, absolute_start_year) VALUES
	('Years of the Lamps', 'YL', 'The first age of Arda, before the Two Trees.', -50000),
	('Years of the Trees', 'YT', 'Age of the Two Trees in Valinor.', -10000),
	('First Age', 'FA', 'First Age of the Sun, ending with the War of Wrath.', 1),
	('Second Age', 'SA', 'Second Age of the Sun, ending with the fall of Sauron to the Last Alliance.', 590),
	('Third Age', 'TA', 'Third Age of the Sun, ending with the destruction of the One Ring.', 3441),
	('Fourth Age', 'FoA', 'Fourth Age of the Sun, age of Men.', 7041);

INSERT INTO location_types (name, description) VALUES
	('Continent', 'Large landmass such as Middle-earth or Aman'),
	('Region', 'Large geographic region'),
	('Realm/Kingdom', 'Political realm or kingdom'),
	('City/Town', 'City, town, or village'),
	('Stronghold', 'Fortress, tower, or stronghold'),
	('Natural Feature', 'Mountains, rivers, forests, etc.');

INSERT INTO races (name, description, parent_race_id) VALUES
	('Ainur', 'Holy ones, primordial spirits created by Ilúvatar.', NULL),
	('Maiar', 'Lesser Ainur who entered Arda.', 1),
	('Elves', 'Firstborn Children of Ilúvatar.', NULL),
	('Men', 'Secondborn Children of Ilúvatar.', NULL),
	('Dwarves', 'Children of Aulë.', NULL),
	('Hobbits', 'A mortal people closely related to Men.', 4),
	('Orcs', 'Corrupted and twisted beings, often from Elves or Men.', NULL),
	('Dragons', 'Great fire-breathing or cold-drakes of Morgoth.', NULL),
	('Ents', 'Shepherds of the trees.', NULL);

INSERT INTO item_types (name, description) VALUES
	('Ring', 'Rings of Power and related rings'),
	('Sword', 'Named swords and blades'),
	('Staff', 'Wizard''s staffs and similar items'),
	('Jewel', 'Jewels and gems'),
	('Other Artifact', 'Miscellaneous unique artifacts');

INSERT INTO faction_types (name, description) VALUES
	('Realm/Kingdom', 'Political state or kingdom'),
	('Order', 'Order or society such as the Istari'),
	('Fellowship/Company', 'Small company or fellowship'),
	('Dark Power', 'Realm of evil power'),
	('Tribe/House', 'Family, house, or clan');

INSERT INTO event_types (name, description) VALUES
	('Battle', 'Large-scale battle'),
	('Council', 'Council or important meeting'),
	('Journey', 'Travel or quest'),
	('Duel', 'Single combat or small fight'),
	('Other', 'Other significant event');

INSERT INTO locations (name, description, location_type_id, parent_location_id) VALUES
	('Middle-earth', 'Main continent east of the Great Sea.', 1, NULL),
	('Aman', 'The Blessed Realm in the West.', 1, NULL),
	('Eriador', 'Region west of the Misty Mountains.', 2, 1),
	('Rhovanion', 'Region east of the Misty Mountains.', 2, 1),
	('Gondor', 'Southern Númenórean kingdom in the south of Middle-earth.', 2, 1),
	('Mordor', 'Dark land in the southeast of Middle-earth.', 2, 1),
	('The Shire', 'Homeland of the Hobbits in Eriador.', 3, 3),
	('Rivendell', 'Imladris, Elrond''s hidden valley.', 3, 3),
	('Lothlórien', 'Elven realm in the Golden Wood.', 3, 4),
	('Rohan', 'The Riddermark, land of the Horse-lords.', 3, 4),
	('Minas Tirith', 'Capital city of Gondor.', 4, 5),
	('Osgiliath', 'Old capital of Gondor on the Anduin.', 4, 5),
	('Minas Morgul', 'Fortress of the Nazgûl in Mordor.', 5, 6),
	('Barad-dûr', 'Dark Tower of Sauron.', 5, 6),
	('Mount Doom', 'Orodruin, volcano where the One Ring was forged and destroyed.', 6, 6),
	('Isengard', 'Ring of Isengard and tower of Orthanc.', 5, 4),
	('Fangorn Forest', 'Ancient forest on the borders of Rohan.', 6, 4),
	('Grey Havens', 'Port of Mithlond on the Gulf of Lune.', 4, 3);

INSERT INTO factions (name, faction_type_id, parent_faction_id, description, founded_era_id, founded_year, dissolved_era_id, dissolved_year) VALUES
	('The Fellowship of the Ring', 3, NULL, 'The Nine Walkers on the quest to destroy the One Ring.', 5, 3018, 5, 3019),
	('The White Council', 2, NULL, 'Council of the Wise opposing Sauron.', 5, 2463, 5, 2953),
	('The Istari', 2, NULL, 'Order of Wizards sent by the Valar.', 3, 1000, NULL, NULL),
	('Kingdom of Gondor', 1, NULL, 'Southern Númenórean kingdom in Middle-earth.', 4, 3320, NULL, NULL),
	('Kingdom of Rohan', 1, NULL, 'Horse-lords of the Riddermark.', 5, 2510, NULL, NULL),
	('Realm of Mordor', 4, NULL, 'Realm of Sauron in the east.', 2, 1000, 5, 3019),
	('House of Elrond', 5, NULL, 'Household and following of Elrond Half-elven in Rivendell.', 2, 1697, NULL, NULL),
	('House of Durin', 5, NULL, 'Line of Dwarves descended from Durin.', 2, 2000, NULL, NULL);

INSERT INTO characters (name, race_id, title, description, birth_era_id, birth_year, death_era_id, death_year, is_immortal) VALUES
	('Gandalf', 2, 'Mithrandir', 'One of the Istari, a Maia in the guise of an old man.', 3, 1000, 5, 3019, TRUE),
	('Frodo Baggins', 6, NULL, 'Hobbit of the Shire, Ring-bearer.', 5, 2968, NULL, NULL, FALSE),
	('Samwise Gamgee', 6, NULL, 'Hobbit of the Shire, companion of Frodo.', 5, 2980, NULL, NULL, FALSE),
	('Aragorn II Elessar', 4, 'King of Gondor and Arnor', 'Heir of Isildur, leader of the Fellowship.', 5, 2931, 6, 120, FALSE),
	('Legolas', 3, 'Prince of the Woodland Realm', 'Sindarin Elf of the Woodland Realm.', 3, 87, NULL, NULL, TRUE),
	('Gimli', 5, NULL, 'Dwarf of the House of Durin.', 5, 2879, NULL, NULL, FALSE),
	('Boromir', 4, 'Captain of the White Tower', 'Son of Denethor II of Gondor.', 5, 2978, 5, 3019, FALSE),
	('Meriadoc Brandybuck', 6, NULL, 'Hobbit of the Shire, cousin of Frodo.', 5, 2982, NULL, NULL, FALSE),
	('Peregrin Took', 6, NULL, 'Hobbit of the Shire, cousin of Frodo.', 5, 2990, NULL, NULL, FALSE),
	('Galadriel', 3, 'Lady of Lórien', 'Noldorin Elf, ruler of Lothlórien.', 2, 1362, NULL, NULL, TRUE),
	('Elrond', 3, 'Lord of Rivendell', 'Half-elven Lord of Rivendell.', 2, 532, NULL, NULL, TRUE),
	('Arwen Undómiel', 3, NULL, 'Daughter of Elrond.', 5, 241, 6, 121, FALSE),
	('Saruman', 2, 'Curunír', 'Chief of the Istari who fell into evil.', 3, 1000, 6, 1, TRUE),
	('Sauron', 2, 'The Dark Lord', 'Maia of Aulë who became Morgoth''s chief lieutenant and later Dark Lord.', 1, -1000, 5, 3019, TRUE),
	('Théoden', 4, 'King of Rohan', 'King of the Mark during the War of the Ring.', 5, 2948, 5, 3019, FALSE),
	('Éomer', 4, 'King of Rohan', 'Nephew of Théoden, later King of Rohan.', 5, 2991, NULL, NULL, FALSE),
	('Denethor II', 4, 'Steward of Gondor', 'Last Ruling Steward of Gondor.', 5, 2930, 5, 3019, FALSE),
	('Faramir', 4, 'Steward of Gondor', 'Younger son of Denethor II.', 5, 2983, NULL, NULL, FALSE),
	('Treebeard', 9, 'Eldest of the Ents', 'Oldest of the Ents in Fangorn Forest.', 1, -1000, NULL, NULL, TRUE);

INSERT INTO items (name, description, item_type_id, origin_location_id, creation_era_id, creation_year) VALUES
	('The One Ring', 'Ruling Ring forged by Sauron in Mount Doom.', 1, 15, 2, 1600),
	('Narya', 'Ring of Fire, given to Gandalf.', 1, 18, 2, 1600),
	('Andúril', 'Reforged sword of Elendil, carried by Aragorn.', 2, 8, 5, 3018),
	('Glamdring', 'Sword of Turgon, later wielded by Gandalf.', 2, 8, 1, 1),
	('Sting', 'Elven short-sword carried by Bilbo and later Frodo.', 2, 8, 3, 400),
	('Gandalf''s Staff', 'Staff of the wizard Gandalf.', 3, 8, 3, 1000),
	('Palantír of Orthanc', 'Seeing-stone kept in Orthanc.', 5, 16, 2, 1590),
	('Evenstar Jewel', 'Jewel given by Arwen to Aragorn.', 4, 8, 5, 3018);

INSERT INTO events (name, description, start_era_id, start_year, end_era_id, end_year, location_id, event_type_id) VALUES
	('Council of Elrond', 'Council in Rivendell where the fate of the One Ring was decided.', 5, 3018, 5, 3018, 8, 2),
	('Breaking of the Fellowship', 'The Fellowship is broken at Amon Hen.', 5, 3019, 5, 3019, 4, 5),
	('Battle of Helm''s Deep', 'Defence of the Hornburg in Rohan.', 5, 3019, 5, 3019, 10, 1),
	('Destruction of the One Ring', 'The One Ring is destroyed in Mount Doom.', 5, 3019, 5, 3019, 15, 5),
	('Battle of the Pelennor Fields', 'Great battle before Minas Tirith.', 5, 3019, 5, 3019, 11, 1),
	('Last Debate', 'Debate in Minas Tirith before the march to the Black Gate.', 5, 3019, 5, 3019, 11, 2),
	('Journey to the Grey Havens', 'Frodo and the Ring-bearers depart from Middle-earth.', 5, 3021, 5, 3021, 18, 3);

INSERT INTO character_faction_history (character_id, faction_id, join_era_id, join_year, leave_era_id, leave_year, role) VALUES
	(1, 3, 3, 1000, NULL, NULL, 'Wizard of the Istari'),
	(13, 3, 3, 1000, 5, 3019, 'Chief of the Istari'),
	(1, 2, 5, 2463, 5, 2953, 'Member of the White Council'),
	(10, 2, 5, 2463, 5, 2953, 'Member of the White Council'),
	(11, 2, 5, 2463, 5, 2953, 'Member of the White Council'),
	(13, 2, 5, 2463, 5, 2953, 'Head of the White Council'),
	(2, 1, 5, 3018, 5, 3019, 'Ring-bearer'),
	(3, 1, 5, 3018, 5, 3019, 'Companion'),
	(4, 1, 5, 3018, 5, 3019, 'Leader'),
	(5, 1, 5, 3018, 5, 3019, 'Companion'),
	(6, 1, 5, 3018, 5, 3019, 'Companion'),
	(7, 1, 5, 3018, 5, 3019, 'Companion'),
	(1, 1, 5, 3018, 5, 3019, 'Guide'),
	(8, 1, 5, 3018, 5, 3019, 'Companion'),
	(9, 1, 5, 3018, 5, 3019, 'Companion'),
	(4, 4, 5, 3019, NULL, NULL, 'King of the Reunited Kingdom'),
	(15, 5, 5, 2980, 5, 3019, 'King of Rohan'),
	(16, 5, 5, 3019, NULL, NULL, 'King of Rohan'),
	(17, 4, 5, 2984, 5, 3019, 'Steward of Gondor'),
	(18, 4, 5, 3019, NULL, NULL, 'Steward of Gondor'),
	(14, 6, 2, 1000, 5, 3019, 'Dark Lord of Mordor');

INSERT INTO character_location_history (character_id, location_id, start_era_id, start_year, end_era_id, end_year) VALUES
	(2, 7, 5, 2968, 5, 3018),  -- Frodo in the Shire
	(2, 8, 5, 3018, 5, 3018),  -- Frodo in Rivendell
	(2, 15, 5, 3019, 5, 3019), -- Frodo at Mount Doom
	(2, 18, 5, 3021, NULL, NULL), -- Frodo at the Grey Havens and beyond
	
	(3, 7, 5, 2980, 5, 3018),  -- Sam in the Shire
	(3, 8, 5, 3018, 5, 3018),   -- Sam in Rivendell
	(3, 15, 5, 3019, 5, 3019),  -- Sam at Mount Doom

	(4, 8, 5, 3018, 5, 3018),  -- Aragorn in Rivendell
	(4, 10, 5, 3019, 5, 3019), -- Aragorn in Rohan
	(4, 11, 5, 3019, NULL, NULL), -- Aragorn in Minas Tirith

	(1, 8, 5, 2941, 5, 3019),  -- Gandalf using Rivendell as a base
	(1, 16, 5, 3019, 5, 3019), -- Gandalf at Isengard after its fall

	(10, 9, 3, 400, NULL, NULL), -- Galadriel in Lothlórien
	(11, 8, 2, 1697, NULL, NULL), -- Elrond in Rivendell
	(19, 17, 1, -1000, NULL, NULL); -- Treebeard in Fangorn
    
INSERT INTO item_character_history (item_id, character_id, start_era_id, start_year, end_era_id, end_year) VALUES
	(1, 14, 2, 1600, 2, 3441), -- Sauron holds the One Ring until Isildur takes it
	(1, 2, 5, 3018, 5, 3019),  -- Frodo bears the One Ring
	(1, 3, 5, 3019, 5, 3019),  -- Sam briefly bears the One Ring
	(2, 1, 3, 1000, NULL, NULL), -- Narya with Gandalf
	(3, 4, 5, 3018, NULL, NULL), -- Andúril with Aragorn
	(4, 1, 3, 2941, NULL, NULL), -- Glamdring with Gandalf
	(5, 2, 5, 3001, 5, 3018),    -- Sting with Frodo
	(6, 1, 3, 1000, NULL, NULL), -- Gandalf''s staff with Gandalf
	(8, 4, 5, 3018, NULL, NULL); -- Evenstar Jewel with Aragorn

INSERT INTO item_location_history (item_id, location_id, start_era_id, start_year, end_era_id, end_year) VALUES
	(1, 15, 2, 1600, 2, 1600),  -- One Ring forged at Mount Doom
	(1, 7, 5, 3001, 5, 3018),   -- One Ring in the Shire (Bag End)
	(1, 15, 5, 3019, 5, 3019),  -- One Ring destroyed at Mount Doom
	(2, 18, 5, 3019, 5, 3021),  -- Narya in the Grey Havens when Gandalf departs
	(3, 11, 5, 3019, NULL, NULL), -- Andúril in Minas Tirith
	(5, 7, 5, 3001, 5, 3018),   -- Sting kept in the Shire
	(7, 16, 5, 2759, 5, 3019);  -- Palantír of Orthanc in Isengard

INSERT INTO item_creators (item_id, character_id) VALUES
	(1, 14), -- Sauron forged the One Ring
	(2, 14), -- Sauron originally made the Rings of Power (in collaboration with Celebrimbor)
	(3, 4),  -- Symbolic: reforging of Narsil into Andúril arranged by Aragorn and Elrond''s folk
	(4, 14), -- Originally forged in Gondolin; simplified attribution
	(6, 1);  -- Gandalf''s staff

INSERT INTO faction_location_history (faction_id, location_id, start_era_id, start_year, end_era_id, end_year) VALUES
	(1, 8, 5, 3018, 5, 3018),  -- Fellowship formed in Rivendell
	(1, 4, 5, 3018, 5, 3019),  -- Fellowship travels across Middle-earth
	(4, 11, 4, 3320, NULL, NULL), -- Gondor centered on Minas Tirith
	(5, 10, 5, 2510, NULL, NULL), -- Rohan in the Mark
	(6, 14, 2, 1000, 5, 3019),    -- Mordor centered on Barad-dûr
	(7, 8, 2, 1697, NULL, NULL),  -- House of Elrond in Rivendell
	(8, 1, 2, 2000, NULL, NULL);  -- House of Durin in Middle-earth (generic)

INSERT INTO faction_races (faction_id, race_id) VALUES
	(1, 3), -- Fellowship includes Elves
	(1, 4), -- Men
	(1, 5), -- Dwarves
	(1, 6), -- Hobbits
	(2, 2), -- White Council includes Maiar
	(2, 3), -- Elves
	(3, 2), -- Istari are Maiar
	(4, 4), -- Gondor of Men
	(5, 4), -- Rohan of Men
	(6, 2), -- Mordor ruled by Sauron the Maia
	(6, 7), -- Mordor uses Orcs
	(8, 5); -- House of Durin of Dwarves

INSERT INTO event_characters (event_id, character_id) VALUES
	(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 13),
	(2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9),
	(3, 1), (3, 4), (3, 6), (3, 15), (3, 16),
	(4, 1), (4, 2), (4, 3), (4, 14),
	(5, 1), (5, 4), (5, 6), (5, 15), (5, 16), (5, 17), (5, 18),
	(6, 1), (6, 4), (6, 18),
	(7, 1), (7, 2), (7, 3), (7, 8), (7, 9), (7, 10), (7, 11);

INSERT INTO event_factions (event_id, faction_id) VALUES
	(1, 1), (1, 2), (1, 7),
	(2, 1),
	(3, 1), (3, 5), (3, 6),
	(4, 1), (4, 6),
	(5, 1), (5, 4), (5, 5), (5, 6),
	(6, 1), (6, 4),
	(7, 1), (7, 7);

INSERT INTO event_items (event_id, item_id) VALUES
	(1, 1), (1, 2), (1, 3), (1, 5),
	(2, 1), (2, 3), (2, 5),
	(3, 3), (3, 6),
	(4, 1), (4, 6),
	(5, 3), (5, 7),
	(7, 1), (7, 2), (7, 8);