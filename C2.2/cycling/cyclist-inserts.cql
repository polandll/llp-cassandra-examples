USE cycling;

// Q1:
// Find a cyclist's name given an ID number
// CREATE TABLE SIMPLE PRIMARY KEY
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1001, 'VOS','Marianne');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1002, 'VAN DER BREGGEN','Anna');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2001, 'FRAME','Alex');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2003, 'TIRALONGO','Paolo');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (2004, 'KRUIKSWIJK','Steven');

// Q2:
// Find cyclists that fit a particular category
// CREATE TABLE CLUSTERING ORDER, PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN, SIMPLE WHERE QUERY
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1269,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',367,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',182,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',0,2003,'TIRALONGO');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('GC',1324,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('One-day-races',198,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Sprint',39,2004,'KRUIJSWIJK');
INSERT INTO cycling.cyclist_category (category, points, id, lastname) VALUES ('Time-trial',3,2004,'KRUIJSWIJK');

// Q3:
// Store race information by year and race name using a COMPOSITE PARTITION KEY
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Benjamin PRADES', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Adam PHELAN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Tour of Japan - Stage 4 - Minami > Shinshu', 'Thomas LEBAS', 3);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Ilnur ZAKARIN', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2015, 'Giro d''Italia - Stage 11 - Forli > Imola', 'Carlos BETANCUR', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Phillippe GILBERT', 1);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Daniel MARTIN', 2);
INSERT INTO cycling.rank_by_year_and_name (race_year, race_name, cyclist_name, rank) VALUES (2014, '4th Tour of Beijing', 'Johan Esteban CHAVES', 3);

// Q4:
// Find a cyclist's id given lastname and firstname
// Another CREATE TABLE using COMPOSITE PARTITION KEY
// 2i INDEX ALSO GOOD FOR THIS TABLE
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('EENKHOORN','Pascal',18, 3001);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('WELTEN','Bram',18, 3002);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('COSTA','Adrien',17, 3003);

// Q5:
// Display flag for riders
// CREATE TABLE WITH STATIC COLUMN, example uses an integer to identify flag, but it could be a blob
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('Belgium', 'Jacques', 1);
INSERT INTO cycling.country_flag (country, cyclist_name) VALUES ('Belgium', 'Andre');
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'Andre', 2);
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'George', 3);

// Q6:
// Find all teams that a cyclist has been a member of
//CREATE TABLE WITH SET
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1001, 'VOS', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','Rabobank Women Team','Nederland bloeit' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1002, 'VAN DER BREGGEN', { 'Rabobank-Liv Woman Cycling Team','Sengers Ladies Cycling Team','Team Flexpoint' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1003, 'ARMITSTEAD', { 'Boels-Dolmans Cycling Team','AA Drink - Leontien.nl','Team Garmin - Cervelo' } );
INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) VALUES (1005, 'BRAND', { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','AA Drink - Leontien.nl','Leontien.nl' } );

// NOT A QUERY, JUST A TABLE FOR QUERIES
// CREATE TABLE WITH LIST FOR UPDATE
// The SELECT statements that use this table can be found below
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (100, 'Giro d''Italia','2015-05-09','2015-05-31');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (101, 'Criterium du Dauphine','2015-06-07','2015-06-14');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (102, 'Tour de Suisse','2015-06-13','2015-06-21');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (103, 'Tour de France','2015-07-04','2015-07-26');

// Q7:
// Find all calendar events for a particular year and month
INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 06, ['Criterium du Dauphine','Tour de Suisse']);
INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 07, ['Tour de France']);

// Q8:
// SIMPLE USER-DEFINED TYPE
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 1, {firstname:'Frances',lastname:'DU TOUT'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 2, {firstname:'Lynette',lastname:'BENSON'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 3, {firstname:'Anja',lastname:'GERBER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 4, {firstname:'Ame',lastname:'VENTER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 5, {firstname:'Danielle',lastname:'VAN NIEKERK'});

// Q9:
// Find all races for a particular cyclist
// CREATE TYPE - User-Defined Type, race
// CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1001, 'VOS', 'Marianne', [ {race_title:'Rabobank 7-Dorpenomloop Aalburg',race_date:'2015-05-09',race_time:'02:58:33'},{race_title:'Ronde van Gelderland',race_date:'2015-04-19',race_time:'03:22:23'} 
]);
INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (1002, 'VAN DER BREGGEN', 'Anna', [ {race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date:'2015-05-01',race_time:'08:13:00'},{race_title:'Fest
ival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich',race_date:'2015-05-02',race_time:'02:41:52'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer',race_date:'2015-05-03',race_time:'02:31:24'} ]);

// Q10: 
// Find all teams for a particular cyclist associated with the year of membership
// teams map<int, text> is map<year, team_name>
// CREATE TABLE WITH MAP, SIMPLE PRIMARY KEY
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1001,'VOS', 'Marianne', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Rabobank-Liv Giant', 2012 : 'Rabobank Women Team', 2011 : 'Nederland bloeit' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1002,'VAN DER BREGGEN', 'Anna', {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Sengers Ladies Cycling Team', 2012 : 'Sengers Ladies Cycling Team', 2009 : 'Team Flexpoint' });
INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) VALUES (1003,'ARMITSTEAD', 'Elizabeth', {2015 : 'Boels-Dolmans Cycling Team', 2014 : 'Boels-Dolmans Cycling Team', 2013 : 'Boels-Dolmans Cycling Team', 2012 : 'AA Drink - Leontien.nl', 2011 : 'Team Garmin - Cervelo' });

// Q11:
// Find all stats for a particular cyclist
// CREATE TYPE -  UDT, basic_info
// CREATE TABLE with UDT, SIMPLE PRIMARY KEY
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2001, 'FRAME', { birthday:'1993-06-18',nationality:'New Zealand',weight:null,height:null });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2002, 'VIGANO', { birthday:'1984-06-12',nationality:'Italy',weight:'67 kg',height:'1.82 m' });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (2003, 'TIRALONGO', { birthday:'1977-07-08',nationality:'Italy',weight:'63 kg',height:'1.78 m' });

// Q12:
// Find total number of PCS points for a particular cyclist
// CREATE TABLE WITH PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN
// USE STANDARD AGGREGATE IN QUERY
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Tour of Chongming Island World Cup', 120);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Trofeo Alfredo Binda - Comune di Cittiglio', 6);
INSERT INTO cycling.cyclist_points (id, firstname, lastname, race_title, race_points) VALUES (1004, 'Giorgia','BRONZINI', 'Acht van Westerveld', 75);

// Q14:
//Find the average race_time in seconds for a particular race for a particular team.
// CREATE UDA that computes the average value
//CREATE TABLE WITH SIMPLE PRIMARY KEY: PARTITION KEY + 2 CLUSTERING COLUMNS
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Katie HALL',11449,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Linda VILLUMSEN',11485,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Hannah BARNES',11490,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Alena AMIALIUSIK',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Trixi WORRACK',11453,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('TWENTY16 presented by Sho-Air','Lauren KOMANSKI',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');

// NOT A QUERY, JUST AN EXAMPLE 
// INSERT DATA IN JSON FORMAT
INSERT INTO cycling.cyclist_category JSON '{ "category" : "GC", "points" : 780, "id" : 2005, "lastname" : "SUTHERLAND" }';

// Q22:
// UPDATE AND SELECT USING TTL
// QUERY TO FIND TIME-TO-LIVE
// Insert is to put in dummy record, UPDATE gives it a TTL
// Repeated use of the SELECT will show the TTL as it counts down
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (200, 'placeholder', '2015-05-27', '2015-05-27');

// Q25
// QUERY - SCAN A PARTITION
// Find all cyclists that finished a race in a particular window of time
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Rohan DENNIS', '19:15:18'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Richie PORTE', '19:15:20'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Cadel EVANS', '19:15:38'  );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time) VALUES ('17th Santos Tour Down Under', 'Tom DUMOULIN', '19:15:40' );

// NOT A QUERY, JUST AN EXAMPLE:
// BATCH statement
// Insert data into multiple tables using a BATCH statement
// Note that what is inserted is data for the SAME cyclist, to two tables
BEGIN BATCH
  INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1006, 'PIETERS', 'Amy');
  INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('PIETERS', 'Amy', 23, 1006);
APPLY BATCH;

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

// Q26
// QUERY USING MULTIPLE INDEXES
// DISCUSSION OF THE NEED FOR ALLOW FILTERING
// IS THIS BETTER THAN cyclist_stats??
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

// Q27
// USING EXPIRING DATA AND TTL TO DISPLAY THE LAST 3 DAYS race data
// 3 days in seconds is 259,200
// 2 days in seconds is 172800
// Data will vanish when its TTL runs out
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',1,'Mikel Landa') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',2,'Steven Kruijswijk') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('Giro d''Italia Stage 16','2015-05-26',3,'Alberto Contador') USING TTL 259200;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',1,'Matthew Busche') USING TTL 172800;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',2,'Joe Dombrowski') USING TTL 172800;
INSERT INTO cycling.last_3_days (race_name, year, rank, cyclist_name) VALUES ('National Championships United States - Road Race (NC)','2015-05-25',3,'Kiel Reijnen') USING TTL 172800;

// Q29:
// TUPLE
// Store the latitude/longitude waypoints for the route of a race
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 1, ('Onnens', (46.8444,6.6667)));
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 2, ('Champagne', (46.833, 6.65)));
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 3, ('Novalle', (46.833, 6.6)));
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 4, ('Vuiteboeuf', (46.8, 6.55)));
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 5, ('Baulmes', (46.7833, 6.5333)));
INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 6, ('Les Clées', (46.7222, 6.5222)));

// Q31:
// TUPLE
// Rank nations by points, including top cyclist
INSERT INTO nation_rank (nation, info) VALUES ('Spain', (1,'Alejandro VALVERDE' , 9054));
INSERT INTO nation_rank (nation, info) VALUES ('France', (2,'Sylvain CHAVANEL' , 6339));
INSERT INTO nation_rank (nation, info) VALUES ('Belgium', (3,'Phillippe GILBERT' , 6222));
INSERT INTO nation_rank (nation, info) VALUES ('Italy', (4,'Davide REBELLINI' , 6090));

// Q32:
// TUPLE
// Popular Riders
INSERT INTO popular (rank, cinfo) VALUES (1, ('Spain', 'Mikel LANDA', 1137));
INSERT INTO popular (rank, cinfo) VALUES (2, ('Netherlands', 'Steven KRUIJSWIJK', 621));
INSERT INTO popular (rank, cinfo) VALUES (3, ('USA', 'Matthew BUSCHE', 230));
INSERT INTO popular (rank, cinfo) VALUES (4, ('Italy', 'Fabio ARU', 163));
INSERT INTO popular (rank, cinfo) VALUES (5, ('Canada', 'Ryder HESJEDAL', 148));
