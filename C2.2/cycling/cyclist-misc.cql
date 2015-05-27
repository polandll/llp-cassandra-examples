USE cycling;

// NOT A QUERY, JUST AN EXAMPLE
// UPDATE SET
// Can only be +
// Add team to a cyclist's list of teams, order doesn't matter; this example adds it to the end
UPDATE cycling.cyclist_career_teams SET teams = teams + {'Team DSB - Ballast Nedam'} WHERE id=1001;

// NOT A QUERY, JUST AN EXAMPLE
// UPDATE LIST
// Add events to the events list with either +/- or a specific place in the list like events[2]
UPDATE cycling.upcoming_calendar SET events = ['The Parx Casino Philly Cycling Classic'] + events WHERE year = 2015 AND month = 06;
UPDATE cycling.upcoming_calendar SET events[2] = 'Vuelta Ciclista a Venezuela' WHERE year = 2015 AND month = 06;

// NOT A QUERY, JUST AN EXAMPLE
// UPDATE MAP
// Can only be +
UPDATE cycling.cyclist_teams SET teams = teams + {2009 : 'DSB Bank - Nederland bloeit'} WHERE id = 1001;
// SELECT teams FROM cycling.cyclist_teams WHERE id = 1001;

// Q22:
// UPDATE AND SELECT USING TTL
// QUERY TO FIND TIME-TO-LIVE
// Insert is to put in dummy record, UPDATE gives it a TTL
// Repeated use of the SELECT will show the TTL as it counts down
// INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (200, 'placeholder', '2015-05-27', '2015-05-27');
UPDATE cycling.calendar USING TTL 300 SET race_name = 'dummy' WHERE race_id = 200 AND race_start_date = '2015-05-27' AND race_end_date = '2015-05-27';
// SELECT TTL(race_name) FROM cycling.calendar WHERE race_id=200;

// NOT A QUERY, JUST AN EXAMPLE:
// BATCH statement
// Insert data into multiple tables using a BATCH statement
// Note that what is inserted is data for the SAME cyclist, to two tables
SELECT * FROM cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;
BEGIN BATCH
  INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1006, 'PIETERS', 'Amy');
  INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('PIETERS', 'Amy', 23, 1006);
APPLY BATCH;
SELECT * FROM cycling.cyclist_name;
SELECT * FRM cycling.cyclist_id;

// NOT A QUERY, JUST AN EXAMPLE:
// BATCH statement MISUSE
// Insert data into same table, but involves multiple nodes due to partition key = id
BEGIN BATCH;
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (1008,'HOSKINS', 'Melissa);
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (1009,'FERNANDES', 'Marcia');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (1010,'NIEWIADOMA', 'Katarzyna');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (1011,'ADRIAN', 'Vera');
APPLY BATCH;

// UPDATE USING LIGHTWEIGHT TRANSACTION
UPDATE cycling.cyclist_name SET firstname = 'Rossella' WHERE id=1007 IF lastname = 'RATTO';

// DELETE WHOLE ROW
// Leave column(s) blank
DELETE FROM cycling.calendar WHERE race_id = 200;

// DELETE COLUMN VALUE
DELETE lastname FROM cycling.cyclist_name WHERE id = 1006;
UPDATE cycling.cyclist_name SET lastname = 'PIETERS' WHERE id = 1006; // TO RESTORE THE COLUMN VALUE

// DELETE ITEM FROM LIST
DELETE events[2] FROM cycling.upcoming_calendar WHERE year = 2015 AND month = 06;

// DELETE ITEM FROM MAP
DELETE teams[2009] FROM cycling.cyclist_teams WHERE id=1002;
UPDATE cycling.cyclist_teams SET teams = teams + {2009 : 'Team Flexpoint' } WHERE id = 1002; // TO RESTORE THE MAP VALUE

// ALTER TABLE
// ADD COLUMN
ALTER TABLE cycling.cyclist_alt_stats ADD age int;

// ALTER TABLE AND ALTER COLUMN TYPE
// ADDS COLUMN as varchar and then changes it to text
ALTER TABLE cycling.cyclist_alt_stats ADD favorite_color varchar; 
ALTER TABLE cycling.cyclist_alt_stats ALTER favorite_color text;

// ALTER TYPE
ALTER TYPE cycling.fullname ADD middlename text;
ALTER TYPE cycling.fullname RENAME middlename middleinitial;
