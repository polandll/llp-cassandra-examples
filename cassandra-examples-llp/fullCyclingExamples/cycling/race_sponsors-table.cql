// source '0_create_keyspace.cql'; 
// above does not work when run from main prompt, need to be explicit

CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
USE cycling;

// create a simple table of races with sponsors in a set collection 

DROP TABLE IF EXISTS cycling.race_sponsors ;

// START-racesponsorsset
CREATE TABLE cycling.race_sponsors (
   race_name text PRIMARY KEY,
   sponsorship set<text>
    );
// END-racesponsorsset

// Insert data into table and set
INSERT INTO cycling.race_sponsors (race_name, sponsorship) VALUES ('Tour de France', {'LCL', 'Carrefour', 'Skoda', 'Vittel', 'Krys'});
INSERT INTO cycling.race_sponsors (race_name, sponsorship) VALUES ('Tour de Suisse', {'BMC', 'Tag Heuer', 'Assos'});
INSERT INTO cycling.race_sponsors (race_name, sponsorship) VALUES ('Criterium du Dauphine', {'LCL', 'Skoda'});
INSERT INTO cycling.race_sponsors (race_name, sponsorship) VALUES ('Giro d''Italia', {'Castrelli',
'Tag Heuer', 'Alfa Romeo', 'Unibet', 'Pinarello', 'Selle Italia',  'Rovagnati', 'Scrigno'});

// view populated table
SELECT * FROM race_sponsors;


// Delete all elements from a set for a race, delete Giro sponsors
// START-deleteset
DELETE sponsorship FROM cycling.race_sponsors 
WHERE race_name = 'Giro d''Italia';
// END-deleteset

// view table again, Giro sponsor column is now null
SELECT * FROM race_sponsors;

// Drop table for next example
DROP TABLE IF EXISTS race_sponsors ;

// Create table with partition keys for a list collection
// START-racesponsorlisttbl
CREATE TABLE cycling.race_sponsors (
   race_year int,
   race_name text,
   sponsorship list<text>,
   PRIMARY KEY (race_year, race_name)
    );
// END-racesponsorlisttbl

// Insert data into the table and list 
// START-insertsponsorlist
INSERT INTO cycling.race_sponsors (race_year, race_name, sponsorship) VALUES (2018, 'Tour de France', ['LCL', 'Carrefour', 'Skoda', 'Vittel', 'Krys']);
// END-insertsponsorlist

// view populated table
SELECT * FROM race_sponsors;

// Delete data from index position 2, which is sponsor Skoda because 0-based numbering
// START-deletelistelement
DELETE sponsorship[2] FROM cycling.race_sponsors WHERE race_year=2018 AND race_name='Tour de France' ;
// END-deletelistelement

// // view table again, Skoda sponsor column is gone
SELECT * FROM race_sponsors;
