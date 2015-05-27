USE cycling;

// Q1:
// Find a cyclist's name given an ID number
SELECT * FROM cycling.cyclist_name;
SELECT lastname, firstname FROM cycling.cyclist_name WHERE id = 2004;

// Q2:
// Find cyclists that fit a particular category
SELECT * FROM cycling.cyclist_category;
SELECT lastname, points FROM cycling.cyclist_category WHERE category = 'One-day-races';

// Q3:
// Store race information by year and race name using a COMPOSITE PARTITION KEY
SELECT * FROM cycling.rank_by_year_and_name;
SELECT * FROM cycling.rank_by_year_and_name WHERE race_year=2015 AND race_name='Tour of Japan - Stage 4 - Minami > Shinshu';

// Q4:
// Find a cyclist's id given lastname and firstname
// Another CREATE TABLE using COMPOSITE PARTITION KEY
// 2i INDEX ALSO GOOD FOR THIS TABLE
SELECT * FROM cycling.cyclist_id WHERE lastname = 'COSTA' AND firstname = 'Adrien';
// If you want to search by age, an index can be added
// CREATE INDEX c_age ON cycling.cyclist_id (age);
SELECT * FROM cycling.cyclist_id WHERE age = 18;

// Q5:
// Display flag for riders
// USE SELECT REPEATEDLY TO SHOW CHANGING (OR UNCHANGING) NATURE OF the column 'flag'
SELECT * FROM cycling.country_flag;

// Q6:
// Find all teams that a cyclist has been a member of
SELECT lastname,teams FROM cycling.cyclist_career_teams;
SELECT lastname, teams FROM cycling.cyclist_career_teams WHERE id=1001;

// Q7:
// Find all calendar events for a particular year and month
SELECT * FROM cycling.upcoming_calendar WHERE year=2015 AND month=06;

// Q8:
// Find all cyclist who won for a particular race
SELECT * FROM cycling.race_winners WHERE race_name = 'National Championships South Africa WJ-ITT (CN)';

// Q9:
// Find all races for a particular cyclist
SELECT * FROM cycling.cyclist_races;
SELECT lastname, races FROM cycling.cyclist_races WHERE id = 1002;

// Q10: 
// Find all teams for a particular cyclist associated with the year of membership
// teams map<int, text> is map<year, team_name>
SELECT lastname, firstname, teams FROM cycling.cyclist_teams;
SELECT lastname, firstname, teams FROM cycling.cyclist_teams WHERE id=1001;

// Q11:
// Find all stats for a particular cyclist
SELECT * FROM cycling.cyclist_stats;
SELECT * FROM cycling.cyclist_stats WHERE id = 2003;

// Q12:
// Find total number of PCS points for a particular cyclist
// USE STANDARD AGGREGATE IN QUERY
SELECT sum(race_points) FROM cycling.cyclist_points WHERE id=1004;

// Q13:
// USES TABLE cycling.cyclist_points
// Find total number of PCS points for a particular cyclist using a user-defined function (UDF) created using java function log
// CREATE UDF
SELECT id, lastname, fLog(race_points) FROM cycling.cyclist_points;

// Q14:
//Find the average race_time in seconds for a particular race for a particular team.
// CREATE UDA that computes the average value
SELECT average(cyclist_time_sec) FROM cycling.team_average WHERE team_name='UnitedHealthCare Pro Cycling Womens Team' AND race_title='Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe';

// Q15:
// CREATE INDEX - PARTITION KEY
// Uses cycling.rank_by_year_and_name
// Find rank for all races for a particular race year
// This will not work without the index, because the table has a composite partition key
SELECT * FROM cycling.rank_by_year_and_name WHERE race_year=2015;

// Q16:
// CREATE INDEX - COLLECTION - SET
// Find all the cyclists that have been on a particular team
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Nederland bloeit';
SELECT * FROM cyclist.cyclist_career_teams WHERE teams CONTAINS 'Rabobank-Liv Giant';

// Q17: 
// CREATE INDEX - COLLECTION ON MAP KEYS
// Find all cyclist/team combinations for a particular year
// CREATE INDEX team_year ON cycling.cyclist_teams (KEY(teams));
SELECT * FROM cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;

// UPDATE MAP
// Can only be +
// UPDATE cycling.cyclist_teams SET teams = teams + {2009 : 'DSB Bank - Nederland bloeit'} WHERE id = 1001;
SELECT teams FROM cycling.cyclist_teams WHERE id = 1001;

// Q22:
// UPDATE AND SELECT USING TTL
// QUERY TO FIND TIME-TO-LIVE
// Insert is to put in dummy record, UPDATE gives it a TTL
// Repeated use of the SELECT will show the TTL as it counts down
// UPDATE cycling.calendar USING TTL 300 SET race_name = 'dummy' WHERE race_id = 200 AND race_start_date = '2015-05-27' AND race_end_date = '2015-05-27';
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
SELECT * FROM cycling.race_times WHERE race_name = '17th Santos Tour Down Under' AND race_time >= '19:15:19' AND race_time <= '19:15:39' );

// NOT A QUERY, JUST AN EXAMPLE:
// BATCH statement
// Insert data into multiple tables using a BATCH statement
// Note that what is inserted is data for the SAME cyclist, to two tables
SELECT * FROM cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;
// BEGIN BATCH
//  INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (1006, 'PIETERS', 'Amy');
//  INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('PIETERS', 'Amy', 23, 1006);
//APPLY BATCH;
SELECT * FROM cycling.cyclist_name;
SELECT * FRM cycling.cyclist_id;

// Q26
// QUERY USING MULTIPLE INDEXES
// DISCUSSION OF THE NEED FOR ALLOW FILTERING
// IS THIS BETTER THAN cyclist_stats??
// CREATE INDEX birthday_idx ON cycling.cyclist_alt_stats (birthday);
// CREATE INDEX nationality_idx ON cycling.cyclist_alt_stats (nationality);
SELECT * FROM cycling.cyclist_alt_stats WHERE birthday = '1982-01-29' AND nationality = 'Russia' ALLOW FILTERING;
SELECT * FROM cycling.cyclist_alt_stats WHERE birthday = '1990-05-27' AND nationality = 'Portugal' ALLOW FILTERING;

// Q27
// USING EXPIRING DATA AND TTL TO DISPLAY THE LAST 3 DAYS race data
// 3 days in seconds is 259,200
// 2 days in seconds is 172800
// Data will vanish when its TTL runs out
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

// Q29:
// TUPLE
// Store the latitude/longitude waypoints for the route of a race
SELECT race_name, point_id, lat_long AS City_Latitude_Longitude FROM cycling.route; // Showcases 'AS' to rename column header

// Q30:
// QUERY USING DISTINCT
// Find all the distinct race_id values from cycling.route
SELECT DISTINCT race_id from cycling.route;

// Q31:
// TUPLE
// Rank nations by points, including top cyclist
SELECT * FROM nation_rank;

// Q32:
// TUPLE
// Popular Riders
SELECT * FROM popular;
