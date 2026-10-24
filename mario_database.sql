-- =============================================
-- Mario Database - PostgreSQL
-- freeCodeCamp Relational Database Curriculum
-- =============================================

-- Create database
CREATE DATABASE mario_database;

-- =============================================
-- TABLE: characters
-- =============================================
CREATE TABLE characters();

ALTER TABLE characters ADD COLUMN character_id SERIAL;
ALTER TABLE characters ADD PRIMARY KEY(character_id);
ALTER TABLE characters ADD COLUMN name VARCHAR(30) NOT NULL;
ALTER TABLE characters ADD COLUMN homeland VARCHAR(60);
ALTER TABLE characters ADD COLUMN favorite_color VARCHAR(30);

-- Insert characters
INSERT INTO characters(name, homeland, favorite_color) 
VALUES('Mario', 'Mushroom Kingdom', 'Red');

INSERT INTO characters(name, homeland, favorite_color) 
VALUES('Luigi', 'Mushroom Kingdom', 'Green');

INSERT INTO characters(name, homeland, favorite_color) 
VALUES('Peach', 'Mushroom Kingdom', 'Pink');

INSERT INTO characters(name, homeland, favorite_color) 
VALUES('Toadstool', 'Mushroom Kingdom', 'Red'), 
      ('Bowser', 'Mushroom Kingdom', 'Green');

INSERT INTO characters(name, homeland, favorite_color) 
VALUES('Daisy', 'Sarasaland', 'Yellow'), 
      ('Yoshi', 'Dinosaur Land', 'Green');

-- Update characters
UPDATE characters SET favorite_color='Orange' WHERE name='Daisy';
UPDATE characters SET name='Mario' WHERE character_id=1;
UPDATE characters SET favorite_color='Blue' WHERE character_id=4;
UPDATE characters SET favorite_color='Yellow' WHERE character_id=5;
UPDATE characters SET homeland='Koopa Kingdom' WHERE character_id=5;

-- =============================================
-- TABLE: more_info
-- =============================================
CREATE TABLE more_info();

ALTER TABLE more_info ADD COLUMN more_info_id SERIAL;
ALTER TABLE more_info ADD PRIMARY KEY(more_info_id);
ALTER TABLE more_info ADD COLUMN birthday DATE;
ALTER TABLE more_info ADD COLUMN height INT;
ALTER TABLE more_info ADD COLUMN weight NUMERIC(4,1);
ALTER TABLE more_info ADD COLUMN character_id INT NOT NULL REFERENCES characters(character_id);
ALTER TABLE more_info ADD UNIQUE(character_id);
ALTER TABLE more_info ALTER COLUMN character_id SET NOT NULL;
ALTER TABLE more_info RENAME COLUMN height TO height_in_cm;
ALTER TABLE more_info RENAME COLUMN weight TO weight_in_kg;

-- Insert additional info
INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1981-07-09', 155, 64.5, 1);

INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1983-07-14', 175, 48.8, 2);

INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1985-10-18', 173, 52.2, 3);

INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1950-01-10', 66, 35.6, 4);

INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1990-10-29', 258, 300, 5);

INSERT INTO more_info(birthday, character_id) 
VALUES('1989-07-31', 6);

INSERT INTO more_info(birthday, height_in_cm, weight_in_kg, character_id) 
VALUES('1990-04-13', 162, 59.1, 7);

-- =============================================
-- TABLE: sounds
-- =============================================
CREATE TABLE sounds(sound_id SERIAL PRIMARY KEY);

ALTER TABLE sounds ADD COLUMN filename VARCHAR(40) NOT NULL UNIQUE;
ALTER TABLE sounds ADD COLUMN character_id INT NOT NULL REFERENCES characters(character_id);

-- Insert sounds
INSERT INTO sounds(filename, character_id) VALUES('its-a-me.wav', 1);
INSERT INTO sounds(filename, character_id) VALUES('yippee.wav', 1);
INSERT INTO sounds(filename, character_id) VALUES('ha-ha.wav', 2);
INSERT INTO sounds(filename, character_id) VALUES('oh-yeah.wav', 2);
INSERT INTO sounds(filename, character_id) VALUES('yay.wav', 3), ('woo-hoo.wav', 3);
INSERT INTO sounds(filename, character_id) VALUES('mm-hmm.wav', 3), ('yahoo.wav', 1);

-- =============================================
-- TABLE: actions
-- =============================================
CREATE TABLE actions(action_id SERIAL PRIMARY KEY);

ALTER TABLE actions ADD COLUMN action VARCHAR(20) UNIQUE NOT NULL;

-- Insert actions
INSERT INTO actions(action) VALUES('run');
INSERT INTO actions(action) VALUES('jump');
INSERT INTO actions(action) VALUES('duck');

-- =============================================
-- TABLE: character_actions
-- =============================================
CREATE TABLE character_actions();

ALTER TABLE character_actions ADD COLUMN character_id INT NOT NULL;
ALTER TABLE character_actions ADD COLUMN action_id INT NOT NULL;
ALTER TABLE character_actions ADD FOREIGN KEY(character_id) REFERENCES characters(character_id);
ALTER TABLE character_actions ADD FOREIGN KEY(action_id) REFERENCES actions(action_id);
ALTER TABLE character_actions ADD PRIMARY KEY(character_id, action_id);

-- Insert character actions
INSERT INTO character_actions(character_id, action_id) VALUES(7,1),(7,2),(7,3);
INSERT INTO character_actions(character_id, action_id) VALUES(6,1),(6,2),(6,3);
INSERT INTO character_actions(character_id, action_id) VALUES(5,1),(5,2),(5,3);
INSERT INTO character_actions(character_id, action_id) VALUES(4,1),(4,2),(4,3);
INSERT INTO character_actions(character_id, action_id) VALUES(3,1),(3,2),(3,3);
INSERT INTO character_actions(character_id, action_id) VALUES(2,1),(2,2),(2,3);
INSERT INTO character_actions(character_id, action_id) VALUES(1,1),(1,2),(1,3);

-- =============================================
-- JOIN QUERIES
-- =============================================

-- JOIN characters with more_info
SELECT * FROM characters 
FULL JOIN more_info ON characters.character_id = more_info.character_id;

-- JOIN characters with sounds
SELECT * FROM characters 
FULL JOIN sounds ON characters.character_id = sounds.character_id;

-- Triple JOIN: character_actions, characters, actions
SELECT * FROM character_actions 
FULL JOIN characters ON character_actions.character_id = characters.character_id 
FULL JOIN actions ON character_actions.action_id = actions.action_id;
