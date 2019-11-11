SOURCE 'create_keyspace.cql'

// START-drop
DROP TABLE IF EXISTS cycling.cyclist_races;
DROP TYPE IF EXISTS cycling.race;
//END-drop

/* Find all races for a particular cyclist
 CREATE TYPE - User-Defined Type, races
 CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY */

// START-udt
CREATE TYPE cycling.race (
   race_title text,
   race_date timestamp,
   race_time time);
// END-udt

// START-cyclist_races
CREATE TABLE cycling.cyclist_races (
  id UUID PRIMARY KEY,
  lastname text,
  firstname text,
  races list<FROZEN <race>> );
// END-cyclist_races

// START-insert_udt
INSERT INTO cycling.cyclist_races (
   id,
   races)
VALUES (
   5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
   [ { race_title:'Rabobank 7-Dorpenomloop Aalburg', race_date:'2015-05-09',race_time:'07:00:00' },
     { race_title:'Ronde van Gelderland', race_date:'2015-04-19', race_time:'08:00:00' } ]);
// END-insert_udt

// START-time
INSERT INTO cycling.cyclist_races (
   id,
   races)
VALUES (
   5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
   [ { race_time:'07:00:00'},
     { race_time:'08:00:00' } ]);
// END-time

// START-utime
UPDATE cycling.cyclist_races
SET races[1] = { race_time:'06:00:00'}
WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2 ;
//END-utime

// START-other
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN', 'Anna', [ {race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date:'2015-05-01',race_time:'08:00:00'},{race_title:'Fest
ival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich',race_date:'2015-05-02',race_time:'06:00:00'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer',race_date:'2015-05-03',race_time:'06:00:00'} ]);
// END-other

// START-sall
SELECT * FROM cycling.cyclist_races;
// END-sall

/* START-rall
END-rall */

// START-spart
SELECT lastname, races FROM cycling.cyclist_races
WHERE id = e7cd5752-bc0d-4157-a80f-7523add8dbcd;
// END-spart

// START-rpart
// END-rpart
