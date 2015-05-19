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

// Procyclingstats.org - my DM for it

// NEED TO ADD USING TTL TO THIS TABLE TO GET ONLY LAST 3 DAYS....
// 
CREATE TABLE three_day ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_date, cyclist_rank, race_date));

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 1, {firstname:'Aaron', lastname:'Gate'}, 'An Post-Chain Reaction', '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 2, {firstname:'Alex', lastname:'Frame'}, null, '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 3, {firstname:'Davide', lastname:'Vigano'},'Team Idea 2010 ASD', '03:29:26','Italy', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-17', 'Giro d''Italia', 1, {firstname:'Paolo', lastname:'Tiralongo'},'Astana Pro Team', '05:50:31','Italy', '2015-05-18 15:09:00');
