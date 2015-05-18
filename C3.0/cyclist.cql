CREATE KEYSPACE cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TABLE cycling.cyclist_name ( id int PRIMARY KEY, lastname text, firstname text );
CREATE TABLE cycling.rank_by_category ( rank int, category text, cyclist frozen <fullname>, PRIMARY KEY (rank, category) );
CREATE TABLE cycling.cyclist_id ( lastname text, firstname text, age int, id int, PRIMARY KEY ((lastname, firstname), age) );
CREATE TABLE cycling.cyclist_rank ( id int, lastname text, rank int, overall_points float, PRIMARY KEY (id));
CREATE TABLE cycling.cyclist_stats ( id int, lastname text, basics frozen <basic_info>, PRIMARY KEY (id) ); 
CREATE TABLE cycling.cyclist ( id int PRIMARY KEY, lastname text, teams set<text> );
CREATE TYPE cycling.fullname ( firstname text, lastname text );
CREATE TYPE cycling.basic_info ( birthday timestamp, nationality text, weight float, height float );
CREATE TABLE cycling.top_five ( race text, year timestamp, top5 list<frozen <fullname>>, PRIMARY KEY (race, year) );
CREATE TABLE cycling.cyclist_races ( id int PRIMARY KEY, races map<timestamp,text> );

INSERT INTO cycling.cyclist (id, lastname) VALUES (1, 'martin');
INSERT INTO cycling.cyclist (id, lastname) VALUES (2, 'hesjedal');
INSERT INTO cycling.rank_by_category ( rank, category, cyclist) VALUES (1, 'All-Time', {firstname: 'Eddy', lastname: 'Merckx'} );
UPDATE cycling.cyclist SET teams = { 'Team Cannondate - Garmin', 'Garmin Sharp', 'Team Slipstream' } WHERE id=1;
UPDATE cycling.cyclist SET teams = { 'Team Cannondate - Garmin', 'Garmin Sharp', 'Discovery Channel', 'Phonak Hearing Systems' } WHERE id=2;

INSERT INTO cycling.top_five (race, year, top5) VALUES ('Tour de Romandie', '2015-05-03', [{firstname: 'Ilnur', lastname: 'Zakarin'}, {firstname: 'Simon', lastname: 'Spilak'}]);
UPDATE top_five SET top5 = top5 + [{firstname:'Christopher', lastname:'Froome'}] WHERE race = 'Tour de Romandie' AND year = '2015-05-03';

INSERT INTO cycling.cyclist_races (id, races) VALUES (1, {'2015-04-26' : 'Liege - Bastognes - Liege', '2015-04-28' : 'Tour de Romandie' });
SELECT * FROM cycling.cyclist;
SELECT teams FROM cycling.cyclist WHERE id = 1;
SELECT * FROM cycling.cyclist_races;
SELECT races FROM cycling.cyclist_races WHERE id = 1;

SELECT * FROM top_five;
