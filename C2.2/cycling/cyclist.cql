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
// Find a cyclist's id given lastname and firstname
// Another CREATE TABLE using COMPOSITE PARTITION KEY
// 2i INDEX ALSO GOOD FOR THIS TABLE
CREATE TABLE cycling.cyclist_id ( lastname text, firstname text, age int, id int, PRIMARY KEY ((lastname, firstname), age) );
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('EENKHOORN','Pascal',18, 3001);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('WELTEN','Bram',18, 3002);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('COSTA','Adrien',17, 3003);
SELECT * FROM cycling.cyclist_id WHERE lastname = 'COSTA' AND firstname = 'Adrien';
// If you want to search by age, an index can be added
CREATE INDEX c_age ON cycling.cyclist_id (age);
SELECT * FROM cycling.cyclist_id WHERE age = 18;

// Q5:
// Display flag for riders
// CREATE TABLE WITH STATIC COLUMN, example uses an integer to identify flag, but it could be a blob
CREATE TABLE cyclist.country_flag (country text, cyclist_name text, flag int STATIC, PRIMARY KEY (country, cyclist_name));
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('Belgium', 'Jacques', 1);
INSERT INTO cycling.country_flag (country, cyclist_name) VALUES ('Belgium', 'Andre');
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'Andre', 2);
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'George', 3);
// USE SELECT REPEATEDLY TO SHOW CHANGING (OR UNCHANGING) NATURE OF the column 'flag'
SELECT * FROM cycling.country_flag;

// Q6:
// Find all teams that a cyclist has been a member of
//CREATE TABLE WITH SET
CREATE TABLE cycling.cyclist_career_teams ( id int PRIMARY KEY, lastname text, teams set<text> );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1001, 'VOS', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','Rabobank Women Team','Nederland bloeit' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1002, 'VAN DER BREGGEN', { 'Rabobank-Liv Woman Cycling Team','Sengers Ladies Cycling Team','Team Flexpoint' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1003, 'ARMITSTEAD', { 'Boels-Dolmans Cycling Team','AA Drink - Leontien.nl','Team Garmin - Cervelo' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1005, 'BRAND', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','AA Drink - Leontien.nl','Leontien.nl' } );
SELECT lastname,teams FROM cycling.cyclist_career_teams;
SELECT lastname, teams FROM cycling.cyclist_career_teams WHERE id=1001;

// NOT A QUERY, JUST A TABLE FOR QUERIES
// CREATE TABLE WITH LIST FOR UPDATE
// The SELECT statements that use this table can be found below
CREATE TABLE cycling.calendar (race_id int, race_name text, race_start_date timestamp, race_end_date timestamp, PRIMARY KEY (race_id, race_start_date, race_end_date));
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (100, 'Giro d''Italia','2015-05-09','2015-05-31');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (101, 'Criterium du Dauphine','2015-06-07','2015-06-14');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (102, 'Tour de Suisse','2015-06-13','2015-06-21');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (103, 'Tour de France','2015-07-04','2015-07-26');

// Q7:
// Find all calendar events for a particular year and month
CREATE TABLE cycling.upcoming_calendar ( year int, month int, events list<text>, PRIMARY KEY ( year, month ));
INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 06, ['Criterium du Dauphine','Tour de Suisse']);
INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 07, ['Tour de France']);
SELECT * FROM cycling.upcoming_calendar WHERE year=2015 AND month=06;

// Q8:
// SIMPLE USER-DEFINED TYPE
CREATE TYPE cycling.fullname ( firstname text, lastname text );
CREATE TABLE cycling.race_winners (race_name text, race_position int, cyclist_name frozen<fullname>, PRIMARY KEY (race_name, race_position));
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 1, {firstname:'Frances',lastname:'DU TOUT'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 2, {firstname:'Lynette',lastname:'BENSON'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 3, {firstname:'Anja',lastname:'GERBER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 4, {firstname:'Ame',lastname:'VENTER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 5, {firstname:'Danielle',lastname:'VAN NIEKERK'});
SELECT * FROM cycling.race_winners WHERE race_name = 'National Championships South Africa WJ-ITT (CN)';

// Q9:
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

// Q10: 
// Find all teams for a particular cyclist associated with the year of membership
// teams map<int, text> is map<year, team_name>
// CREATE TABLE WITH MAP, SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_teams ( id int PRIMARY KEY, lastname text, firstname text, teams map<int,text> );
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1001,'VOS', 'Marianne', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Rabobank-Liv Giant', 2012 : 'Rabobank Women Team', 2011 : 'Nederland bloeit' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1002,'VAN DER BREGGEN', 'Anna', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Sengers Ladies Cycling Team', 2012 : 'Sengers Ladies Cycling Team', 2009 : 'Team Flexpoint' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1003,'ARMITSTEAD', 'Elizabeth', {2015 : 'Boels-Dolmans Cycling Team', 2014 : 'Boels-Dolmans Cycling Team', 2013 : 'Boels-Dolmans Cycling Team', 2012 : 'AA Drink - Leontien.nl', 2011 : 'Team Garmin - Cervelo' });
SELECT lastname, firstname, teams FROM cycling.cyclist_teams;
SELECT lastname, firstname, teams FROM cycling.cyclist_teams WHERE id=1001;

// Q11:
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

// Q12:
// Find total number of PCS points for a particular cyclist
// CREATE TABLE WITH PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN
// USE STANDARD AGGREGATE IN QUERY
CREATE TABLE cycling.cyclist_points (id int, firstname text, lastname text, race_title text, race_points int, PRIMARY KEY (id, race_points );
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Tour of Chongming Island World Cup', 120);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Trofeo Alfredo Binda - Comune di Cittiglio', 6);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Acht van Westerveld', 75);
SELECT sum(race_points) FROM cycling.cyclist_points WHERE id=1004;

// Q13:
// USES TABLE cycling.cyclist_points
// Find total number of PCS points for a particular cyclist using a user-defined function (UDF) created using java function log
// CREATE UDF
CREATE OR REPLACE FUNCTION fLog (input double) RETURNS double LANGUAGE java AS 'return Double.valueOf(Math.log(input.doubleValue()));';
SELECT id, lastname, fLog(race_points) FROM cycling.cyclist_points;

// Q14:
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

// Q15:
// CREATE INDEX - PARTITION KEY
// Uses cycling.rank_by_year_and_name
// Find rank for all races for a particular race year
CREATE INDEX ryear ON cycling.rank_by_year_and_name (race_year);
// This will not work without the index, because the table has a composite partition key
SELECT * FROM cycling.rank_by_year_and_name WHERE race_year=2015;

// Q16:
// CREATE INDEX - COLLECTION - SET
// Find all the cyclists that have been on a particular team
CREATE INDEX team ON cycling.cyclist_career_teams (teams);
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Nederland bloeit';
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Rabobank-Liv Giant';

// Q17: 
// CREATE INDEX - COLLECTION ON MAP KEYS
// Find all cyclist/team combinations for a particular year
CREATE INDEX team_year ON cycling.cyclist_teams (KEY(teams));
SELECT * FROM cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;

// NOT A QUERY, JUST AN EXAMPLE 
// INSERT DATA IN JSON FORMAT
INSERT INTO cycling.cyclist_category JSON '{ "category" : "GC", "points" : 780, "id" : 2005, "lastname" : "SUTHERLAND" }';

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
SELECT teams FROM cycling.cyclist_teams WHERE id = 1001;

// Q22:
// UPDATE AND SELECT USING TTL
// QUERY TO FIND TIME-TO-LIVE
// Insert is to put in dummy record, UPDATE gives it a TTL
// Repeated use of the SELECT will show the TTL as it counts down
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (200, 'placeholder', '2015-05-27', '2015-05-27');
UPDATE cycling.calendar USING TTL 300 SET race_name = 'dummy' WHERE race_id = 200 AND race_start_date = '2015-05-27' AND race_end_date = '2015-05-27';
SELECT TTL(race_name) FROM cycling.calendar WHERE race_id=200;

// Q18:
// QUERY WITH ORDER BY
// Find all calendar events for a particular year and order by month
SELECT * FROM cycling.upcoming_calendar WHERE year= 2015 ORDER BY month DESC;

// Q19:
// QUERY WITH INEQUALITIES
// Find all calendar events for a particular year between two set months
SELECT * FROM cycling.upcoming_calendar WHERE year = 2015 AND month <= 06 AND month >= 07;

// NOT A QUERY, REALLY, JUST AN EXAMPLE
// SELECT and GET RESULTS in JSON FORMAT
SELECT JSON month, year, events FROM cycling.upcoming_calendar;

// Q20:
// QUERY - WHERE ... IN SIMPLE
// Notice the difference between using 'ORDER BY points DESC' and not using it - changes the order of reporting
// Find all cyclists for a particular category and order by points
PAGING OFF; SELECT * FROM cycling.cyclist_category WHERE category IN ('Time-trial', 'Sprint') ORDER BY points DESC;
PAGING OFF; SELECT * FROM cycling.cyclist_category WHERE category IN ('Time-trial', 'Sprint') ORDER BY points ASC;

// Q21:
// QUERY - WHERE ... IN COMPLEX
// Find particular races in a range of start and end dates
PAGING OFF; SELECT * FROM cycling.calendar WHERE race_id IN (100, 101, 102) AND (race_start_date, race_end_date) IN (('2015-05-09','2015-05-31'),('2015-05-06', '2015-05-31'));
PAGING OFF; SELECT * FROM cycling.calendar WHERE race_id IN (100, 101, 102) AND (race_start_date, race_end_date) >= ('2015-05-09','2015-05-24');

// Q23 and 24:
// Standard Aggregates
// Find sum of cyclist points for a particular cyclist
// Find the number of cyclists from a particular country
SELECT sum(race_points) FROM cycling.cyclist_points WHERE id = 1004;
SELECT count(cyclist_name) FROM cycling.country_flag WHERE country='Belgium';

// Q25
// QUERY - SCAN A PARTITION
// Find all cyclists that finished a race in a particular window of time
CREATE TABLE cycling.race_times (race_name text, cyclist_name text, race_time text, PRIMARY KEY (race_name, race_time));
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Rohan DENNIS', '19:15:18'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Richie PORTE', '19:15:20'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Cadel EVANS', '19:15:38'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Tom DUMOULIN', '19:15:40' );
SELECT * FROM cycling.race_times WHERE race_name = '17th Santos Tour Down Under' AND race_time >= '19:15:19' AND race_time <= '19:15:39' );

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

// NOT A QUERY, JUST AN EXAMPLE
// LIGHTWEIGHT TRANSACTION
// Insert or update information using a conditional statement
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1007, 'RATTO', 'Rissella') IF NOT EXISTS;

// UPDATE USING LIGHTWEIGHT TRANSACTION
UPDATE cycling.cyclist_name SET firstname = 'Rossella' WHERE id=1007 IF lastname = 'RATTO';

// Q26
// QUERY USING MULTIPLE INDEXES
// DISCUSSION OF THE NEED FOR ALLOW FILTERING
// IS THIS BETTER THAN cyclist_stats??
CREATE TABLE cycling.cyclist_alt_stats ( id int PRIMARY KEY, lastname text, birthday timestamp, nationality text, weight text, height text );
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1020,'TSATEVICH', '1989-07-05', 'Russia', '64 kg', '1.69 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1021,'ISAYCHEV', '1986-04-21', 'Russia', '80 kg', '1.88 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1022,'BELKOV', '1985-01-09', 'Russia', '71 kg', '1.84 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1023,'BRUTT', '1982-01-29', 'Russia', '68 kg', '1.78 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1024,'LAGUTIN', '1981-01-14', 'Russia', '63 kg', '1.82 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1025,'GRMAY', '1991-08-25', 'Ethiopia', '63 kg', '1.75 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1026,'VEIKKANEN', '1981-03-29', 'Finland', '66 kg', '1.78 m');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1027,'TLEUBAYEV', '1987-03-07', 'Kazakhstan', null, null);
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1028,'PAULINHO', '1990-05-27', 'Portugal', null, null);
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, height) VALUES (1029,'DUVAL', '1990-05-27','France', null, null);
CREATE INDEX birthday_idx ON cycling.cyclist_alt_stats (birthday);
CREATE INDEX nationality_idx ON cycling.cyclist_alt_stats (nationality);
SELECT * FROM cycling.cyclist_alt_stats WHERE birthday = '1982-01-29' AND nationality = 'Russia' ALLOW FILTERING;
SELECT * FROM cycling.cyclist_alt_stats WHERE birthday = '1990-05-27' AND nationality = 'Portugal' ALLOW FILTERING;

// Q27
// USING EXPIRING DATA AND TTL TO DISPLAY THE LAST 3 DAYS race data
// 3 days in seconds is 259,200
// 2 days in seconds is 172800
// Data will vanish when its TTL runs out
CREATE TABLE cycling.last_3_days (race_name text, year timestamp, rank int, cyclist_name text, PRIMARY KEY (year, rank, cyclist_name));
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',1,'Mikel Landa') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',2,'Steven Kruijswijk') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',3,'Alberto Contador') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',1,'Matthew Busche') USING TTL 172800;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',2,'Joe Dombrowski') USING TTL 172800;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',3,'Kiel Reijnen') USING TTL 172800;
SELECT TTL(race_name) FROM cycling.last_3_days;
SELECT TTL(race_name) FROM cycling.last_3_days;
SELECT * FROM cycling.last_3_days; // WILL ONLY SHOW NON-EXPIRED ROWS

// Q28:
// QUERY USING FUNCTION TOKEN()
// Note how results are not consistent with dates alone; partitioner order is how they are returned
// All 6 entries show
SELECT * FROM cycling.last_3_days WHERE token(year) > token ('2015-05-24');
// No entries show
SELECT * FROM cycling.last_3_days WHERE token(year) > token ('2015-05-25');
// 3 entries for 2015-05-25 show
SELECT * FROM cycling.last_3_days WHERE token(year) > token ('2015-05-26');
// No entries show
SELECT * FROM cycling.last_3_days WHERE token(year) > token ('2015-05-27');
SELECT token(year) FROM cycling.last_3_days; //PRINTS partition hash

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

// TUPLE WAS USED IN THE UDA TO HOLD 2 values - see example in UDA section

// TUPLE
// Store the latitude/longitude waypoints for the route of a race
CREATE TABLE route (race_id int, race_name text, point_id int, lat_long FROZEN <tuple<text, tuple<float,float>>>);
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 1, (Onnens, (46.8444,6.6667)));
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 2, (Champagne, (46.833, 6.65)));
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 3, (Novalle, (46.833, 6.6)));
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 4, (Vuiteboeuf, (46.8, 6.55)));
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 5, (Baulmes, (46.7833, 6.5333)));
INSERT INTO route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 6, (Les Clées, (46.7222, 6.5222)));
SELECT * FROM route;


// TUPLE
// Rank nations by points, including top cyclist
CREATE TABLE nation_rank ( nation text PRIMARY KEY, info FROZEN <tuple<int,text,int>> );
INSERT INTO nation_rank (nation, info) VALUES ('Spain', (1,'Alejandro VALVERDE' , 9054));
INSERT INTO nation_rank (nation, info) VALUES ('France', (2,'Sylvain CHAVANEL' , 6339));
INSERT INTO nation_rank (nation, info) VALUES ('Belgium', (3,'Phillippe GILBERT' , 6222));
INSERT INTO nation_rank (nation, info) VALUES ('Italy', (4,'Davide REBELLINI' , 6090));
SELECT * FROM nation_rank;

// TUPLE
// Popular Riders
CREATE TABLE popular (rank int PRIMARY KEY, cinfo FROZEN <tuple<text,text,int>> );
INSERT INTO popular (rank, cinfo) VALUES (1, ('Spain', 'Mikel LANDA', 1137));
INSERT INTO popular (rank, cinfo) VALUES (2, ('Netherlands', 'Steven KRUIJSWIJK', 621));
INSERT INTO popular (rank, cinfo) VALUES (3, ('USA', 'Matthew BUSCHE', 230));
INSERT INTO popular (rank, cinfo) VALUES (4, ('Italy', 'Fabio ARU', 163));
INSERT INTO popular (rank, cinfo) VALUES (5, ('Canada', 'Ryder HESJEDAL', 148));
SELECT * FROM popular;

============================

CREATE TABLE cycling.top_five ( race text, year timestamp, top5 list<frozen <fullname>>, PRIMARY KEY (race, year) );

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
