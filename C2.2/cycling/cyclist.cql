USE cycling;
CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

// Q1:
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

// Q??:
// Find a cyclist's id given lastname and firstname
CREATE TABLE cycling.cyclist_id ( lastname text, firstname text, age int, id int, PRIMARY KEY ((lastname, firstname), age) );
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('EENKHOORN','Pascal',18, 3001);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('WELTEN','Bram',18, 3002);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('COSTA','Adrien',17, 3003);
CREATE INDEX c_age ON cycling.cyclist_id (age);
SELECT * FROM cycling.cyclist_id WHERE lastname = 'COSTA' AND firstname = 'Adrien';
SELECT * FROM cycling.cyclist_id WHERE age = 18;


// Q2:
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

// Q3:
// Store race information by year and race name using a COMPOSITE PARTITION KEY
CREATE TABLE cycling.rank_by_year_and_name ( race_year int, race_name text, cyclist_name text, rank int, PRIMARY KEY ((race_year, race_name), rank) );
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Benjamin PRADES', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Adam PHELAN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Thomas LEBAS', 3);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Ilnur ZAKARIN', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Carlos BETANCUR', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Phillippe GILBERT', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Daniel MARTIN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Johan Esteban CHAVES', 3);
SELECT * FROM cycling.rank_by_year_and_name;
SELECT * FROM cycling.rank_by_year_and_name WHERE race_year=2015 AND race_name='Tour of Japan - Stage 4 - Minami > Shinshu';

// Q4:
// Display flag for riders
// CREATE TABLE WITH STATIC COLUMN, example uses an integer to identify flag, but it could be a blob
CREATE TABLE cyclist.country_flag (country text, cyclist_name text, flag int STATIC, PRIMARY KEY (country, cyclist_name));
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('Belgium', 'Jacques', 1);
INSERT INTO cycling.country_flag (country, cyclist_name) VALUES ('Belgium', 'Andre');
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'Andre', 2);
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'George', 3);
// USE SELECT REPEATEDLY TO SHOW CHANGING (OR UNCHANGING) NATURE OF the column 'flag'
SELECT * FROM cycling.country_flag;

// Q5:
// Find all teams that a cyclist has been a member of
//CREATE TABLE WITH SET
CREATE TABLE cycling.cyclist_career_teams ( id int PRIMARY KEY, lastname text, teams set<text> );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1001, 'VOS', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','Rabobank Women Team','Nederland bloeit' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1002, 'VAN DER BREGGEN', { 'Rabobank-Liv Woman Cycling Team','Sengers Ladies Cycling Team','Team Flexpoint' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1003, 'ARMITSTEAD', { 'Boels-Dolmans Cycling Team','AA Drink - Leontien.nl','Team Garmin - Cervelo' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1005, 'BRAND', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','AA Drink - Leontien.nl','Leontien.nl' } );
SELECT lastname,teams FROM cycling.cyclist_career_teams;
SELECT lastname, teams FROM cycling.cyclist_career_teams WHERE id=1001;

// Q6:
// Find all races for a particular cyclist
// CREATE TYPE - User-Defined Type, race
// CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY
CREATE TYPE cycling.race (race_title text, race_date timestamp, race_time text);
CREATE TABLE cycling.cyclist_races ( id int PRIMARY KEY, lastname text, firstname text, races list<frozen <race>> );
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1001, 'VOS', 'Marianne', [ {race_title:'Rabobank 7-Dorpenomloop Aalburg',race_date:'2015-05-09',race_time:'02:58:33'},{race_title:'Ronde van Gelderland',race_date:'2015-04-19',race_time:'03:22:23'} 
]);
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1002, 'VAN DER BREGGEN', 'Anna', [ {race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date:'2015-05-01',race_time:'08:13:00'},{race_title:'Fest
ival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich',race_date:'2015-05-02',race_time:'02:41:52'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer',race_date:'2015-05-03',race_time:'02:31:24'} ]);
SELECT * FROM cycling.cyclist_races;
SELECT lastname, races FROM cycling.cyclist_races WHERE id = 1002;

// Q7: 
// Find all teams for a particular cyclist associated with the year of membership
// teams map<int, text> is map<year, team_name>
// CREATE TABLE WITH MAP, SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_teams ( id int PRIMARY KEY, lastname text, firstname text, teams map<int,text> );
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1001,'VOS', 'Marianne', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Rabobank-Liv Giant', 2012 : 'Rabobank Women Team', 2011 : 'Nederland bloeit' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1002,'VAN DER BREGGEN', 'Anna', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Sengers Ladies Cycling Team', 2012 : 'Sengers Ladies Cycling Team', 2009 : 'Team Flexpoint' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1003,'ARMITSTEAD', 'Elizabeth', {2015 : 'Boels-Dolmans Cycling Team', 2014 : 'Boels-Dolmans Cycling Team', 2013 : 'Boels-Dolmans Cycling Team', 2012 : 'AA Drink - Leontien.nl', 2011 : 'Team Garmin - Cervelo' });
SELECT lastname, firstname, teams FROM cycling.cyclist_teams;
SELECT lastname, firstname, teams FROM cycling.cyclist_teams WHERE id=1001;

// Q8:
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

// Q9:
// Find total number of PCS points for a particular cyclist
// CREATE TABLE WITH PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN
// USE STANDARD AGGREGATE IN QUERY
CREATE TABLE cycling.cyclist_points (id int, firstname text, lastname text, race_title text, race_points int, PRIMARY KEY (id, race_points );
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Tour of Chongming Island World Cup', 120);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Trofeo Alfredo Binda - Comune di Cittiglio', 6);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Acht van Westerveld', 75);
SELECT sum(race_points) FROM cycling.cyclist_points WHERE id=1004;

// Q10:
// USES TABLE cycling.cyclist_points
// Find total number of PCS points for a particular cyclist using a user-defined function (UDF) created using java function log
// CREATE UDF
CREATE OR REPLACE FUNCTION fLog (input double) RETURNS double LANGUAGE java AS 'return Double.valueOf(Math.log(input.doubleValue()));';
SELECT id, lastname, fLog(race_points) FROM cycling.cyclist_points;

// Q11:
//Find the average race_time in seconds for a particular race for a particular team.
// CREATE UDA that computes the average value
//CREATE TABLE WITH SIMPLE PRIMARY KEY: PARTITION KEY + 2 CLUSTERING COLUMNS
CREATE OR REPLACE FUNCTION avgState ( state tuple<int,bigint>, val int ) RETURNS tuple<int,bigint> LANGUAGE java AS 'if (val !=null) { state.setInt(0, state.getInt(0)+1; state.setLong(1, state.getLong(1)+val.intValue()); } return state;'; 
CREATE OR REPLACE FUNCTION avgFinal ( state tuple<int,bigint> ) RETURNS double LANGUAGE java AS 'double r = 0; if (state.getInt(0) == 0) return null; r = state.getLong(1); r/= state.getInt(0); return Double.valueOf(r);';
CREATE AGGREGATE average ( int ) SFUNC averageState STYPE tuple<int,bigint> FINALFUNC averageFinal INITCOND (0,0);
CREATE TABLE cycling.team_average (team_name text, cyclist_name text, cyclist_time_sec int, race_title text, PRIMARY KEY (team_name, race_title,cyclist_name));
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Katie HALL',11449,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Linda VILLUMSEN',11485,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Hannah BARNES',11490,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Alena AMIALIUSIK',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Trixi WORRACK',11453,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('TWENTY16 presented by Sho-Air','Lauren KOMANSKI',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
SELECT average(cyclist_time_sec) FROM cycling.team_average WHERE team_name='UnitedHealthCare Pro Cycling Womens Team' AND race_title='Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe';

// Q12:
// CREATE INDEX - PARTITION KEY
// Uses cycling.rank_by_year_and_name
// Find rank for all races for a particular race year
CREATE INDEX ryear ON cycling.rank_by_year_and_name (race_year);
// This will not work without the index, because the table has a composite partition key
SELECT * FROM cycling.rank_by_year_and_name WHERE race_year=2015;

// Q13:
// CREATE INDEX - COLLECTION - SET
// Find all the cyclists that have been on a particular team
CREATE INDEX team ON cycling.cyclist_career_teams (teams);
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Nederland bloeit';
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Rabobank-Liv Giant';

// Q14: 
// CREATE INDEX - COLLECTION ON MAP KEYS
// Find all cyclist/team combinations for a particular year
CREATE INDEX team_year ON cycling.cyclist_teams (KEY(teams));
SELECT * FROM cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;

// Q15: 
// INSERT DATA IN JSON FORMAT
INSERT INTO cycling.cyclist_category JSON '{ "category" : "GC", "points" : 780, "id" : 2005, "lastname" : "SUTHERLAND" }';

// Q16:
// UPDATE SET
UPDATE cycling.cyclist_career_teams SET teams = teams + {'Team DSB - Ballast Nedam'} WHERE id=1001;

============================

CREATE TYPE cycling.fullname ( firstname text, lastname text );
CREATE TABLE cycling.rank_by_category ( rank int, category text, cyclist frozen <fullname>, PRIMARY KEY (rank, category) );


CREATE TABLE cycling.cyclist_rank ( id int, lastname text, rank int, overall_points float, PRIMARY KEY (id));

CREATE TABLE cycling.top_five ( race text, year timestamp, top5 list<frozen <fullname>>, PRIMARY KEY (race, year) );
CREATE TABLE cycling.cyclist_races ( id int PRIMARY KEY, races map<timestamp,text> );

INSERT INTO cycling.rank_by_category ( rank, category, cyclist) VALUES (1, 'All-Time', {firstname: 'Eddy', lastname: 'Merckx'} );
UPDATE cycling.cyclist SET teams = { 'Team Cannondate - Garmin', 'Garmin Sharp', 'Team Slipstream' } WHERE id=1;
UPDATE cycling.cyclist SET teams = { 'Team Cannondate - Garmin', 'Garmin Sharp', 'Discovery Channel', 'Phonak Hearing Systems' } WHERE id=2;

INSERT INTO cycling.top_five (race, year, top5) VALUES ('Tour de Romandie', '2015-05-03', [{firstname: 'Ilnur', lastname: 'Zakarin'}, {firstname: 'Simon', lastname: 'Spilak'}]);
UPDATE top_five SET top5 = top5 + [{firstname:'Christopher', lastname:'Froome'}] WHERE race = 'Tour de Romandie' AND year = '2015-05-03';

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
