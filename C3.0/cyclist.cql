USE cycling;
CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TABLE cycling.cyclist_name ( id int PRIMARY KEY, lastname text, firstname text );

// Q1: 
// Find all teams for a particular cyclist
// teams map<int, text> is map<year, team_name>
// CREATE TABLE WITH MAP, SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_teams ( id int PRIMARY KEY, lastname text, firstname text, teams map<int,text> );
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1001,'VOS', 'Marianne', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Rabobank-Liv Giant', 2012 : 'Rabobank Women Team', 2011 : 'Nederland bloeit' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1002,'VAN DER BREGGEN', 'Anna', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Sengers Ladies Cycling Team', 2012 : 'Sengers Ladies Cycling Team', 2009 : 'Team Flexpoint' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1003,'ARMITSTEAD', 'Elizabeth', {2015 : 'Boels-Dolmans Cycling Team', 2014 : 'Boels-Dolmans Cycling Team', 2013 : 'Boels-Dolmans Cycling Team', 2012 : 'AA Drink - Leontien.nl', 2011 : 'Team Garmin - Cervelo' });
SELECT lastname, firstname, teams FROM cycling.cyclist_teams;
SELECT lastname, firstname, teams FROM cycling.cyclist_teams WHERE id=1001;

// Q2:
// Find all races for a particular cyclist
// CREATE TYPE - User-Defined Type, race
// CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY
CREATE TYPE cycling.race (race_title text, race_date timestamp, race_time text);
CREATE TABLE cycling.cyclist_races ( id int PRIMARY KEY, lastname text, firstname text, races list<frozen <race>> ); 
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1001, 'VOS', 'Marianne', [ {race_title:'Rabobank 7-Dorpenomloop Aalburg',race_date:'2015-05-09',race_time:'02:58:33'},{race_title:'Ronde van Gelderland',race_date:'2015-04-19',race_time:'03:22:23'} ]);
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1002, 'VAN DER BREGGEN', 'Anna', [ {race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date:'2015-05-01',race_time:'08:13:00'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich',race_date:'2015-05-02',race_time:'02:41:52'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer',race_date:'2015-05-03',race_time:'02:31:24'} ]);
SELECT * FROM cycling.cyclist_races;
SELECT lastname, races FROM cycling.cyclist_races WHERE id = 1002;

// Q3:
// Find all stats for a particular cyclist
// CREATE TYPE -  UDT, basic_info
// CREATE TABLE with UDT, SIMPLE PRIMARY KEY
CREATE TYPE cycling.basic_info ( birthday timestamp, nationality text, weight text, height text );
CREATE TABLE cycling.cyclist_stats ( id int, lastname text, basics frozen <basic_info>, PRIMARY KEY (id) );
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2001, 'FRAME', { birthday:'1993-06-18',nationality:'New Zealand',weight:null,height:null });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2002, 'VIGANO', { birthday:'1984-06-12',nationality:'Italy',weight:'67 kg',height:'1.82 m' });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2003, 'TIRALONGO', { birthday:'1977-07-08',nationality:'Italy',weight:'63 kg',height:'1.78 m' });
SELECT * FROM cycling.cyclist_stats;
SELECT * FROM cycling.cyclist_stats WHERE id = 2003;

// Q4:
// Find cyclists that fit a particular category
// CREATE TABLE CLUSTERING ORDER, PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN, SIMPLE WHERE QUERY
CREATE TABLE cycling.cyclist_category ( category text, points int, id int, lastname text, PRIMARY KEY (category, points)) WITH CLUSTERING ORDER BY (points DESC);
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1269,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',367,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',182,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',0,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1324,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',198,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',39,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',3,2004,'KRUIJSWIJK');
SELECT * FROM cycling.cyclist_category;
SELECT lastname, points FROM cycling.cyclist_category WHERE category = 'One-day-races';

// Q9:
// Find a cyclist's name given an ID number
// CREATE TABLE SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_name ( id int PRIMARY KEY, lastname text, firstname text );
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1001, 'VOS','Marianne');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1002, 'VAN DER BREGGEN','Anna');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2001, 'FRAME','Alex');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2003, 'TIRALONGO','Paolo');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2004, 'KRUIKSWIJK','Steven');
SELECT * FROM cycling.cyclist_name;
SELECT lastname, firstname FROM cycling.cyclist_name WHERE id = 2004;

CREATE TYPE cycling.fullname ( firstname text, lastname text );
CREATE TABLE cycling.rank_by_category ( rank int, category text, cyclist frozen <fullname>, PRIMARY KEY (rank, category) );

CREATE TABLE cycling.cyclist_id ( lastname text, firstname text, age int, id int, PRIMARY KEY ((lastname, firstname), age) );

CREATE TABLE cycling.cyclist_rank ( id int, lastname text, rank int, overall_points float, PRIMARY KEY (id));

CREATE TYPE cycling.basic_info ( birthday timestamp, nationality text, weight float, height float );
CREATE TABLE cycling.cyclist_stats ( id int, lastname text, basics frozen <basic_info>, PRIMARY KEY (id) ); 

CREATE TABLE cycling.cyclist ( id int PRIMARY KEY, lastname text, teams set<text> );
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

// This will produce the data that could be used to do a 3-DAY listing with either (1) application logic to get last 3 days or (2) USING TTL and entering data promptly
CREATE TABLE three_day ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_date, cyclist_rank, race_name));
COPY three_day (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
SELECT * FROM three_day;

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 1, {firstname:'Aaron', lastname:'Gate'}, 'An Post-Chain Reaction', '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 2, {firstname:'Alex', lastname:'Frame'}, null, '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 3, {firstname:'Davide', lastname:'Vigano'},'Team Idea 2010 ASD', '03:29:26','Italy', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-17', 'Giro d''Italia', 1, {firstname:'Paolo', lastname:'Tiralongo'},'Astana Pro Team', '05:50:31','Italy', '2015-05-18 15:09:00');
