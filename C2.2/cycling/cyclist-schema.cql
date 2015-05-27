USE cycling;
CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

// Q1:
// Find a cyclist's name given an ID number
// CREATE TABLE SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_name ( id int PRIMARY KEY, lastname text, firstname text );

// Q2:
// Find cyclists that fit a particular category
// CREATE TABLE CLUSTERING ORDER, PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN, SIMPLE WHERE QUERY
CREATE TABLE cycling.cyclist_category ( category text, points int, id int, lastname text, PRIMARY KEY (category, points)) WITH CLUSTERING ORDER BY (points DESC);

// Q3:
// Store race information by year and race name using a COMPOSITE PARTITION KEY
CREATE TABLE cycling.rank_by_year_and_name ( race_year int, race_name text, cyclist_name text, rank int, PRIMARY KEY ((race_year, race_name), rank) );

// Q4:
// Find a cyclist's id given lastname and firstname
// Another CREATE TABLE using COMPOSITE PARTITION KEY
// 2i INDEX ALSO GOOD FOR THIS TABLE
CREATE TABLE cycling.cyclist_id ( lastname text, firstname text, age int, id int, PRIMARY KEY ((lastname, firstname), age) );
// If you want to search by age, an index can be added
CREATE INDEX c_age ON cycling.cyclist_id (age);

// Q5:
// Display flag for riders
// CREATE TABLE WITH STATIC COLUMN, example uses an integer to identify flag, but it could be a blob
CREATE TABLE cyclist.country_flag (country text, cyclist_name text, flag int STATIC, PRIMARY KEY (country, cyclist_name));

// Q6:
// Find all teams that a cyclist has been a member of
//CREATE TABLE WITH SET
CREATE TABLE cycling.cyclist_career_teams ( id int PRIMARY KEY, lastname text, teams set<text> );

// NOT A QUERY, JUST A TABLE FOR QUERIES
// CREATE TABLE WITH LIST FOR UPDATE
// The SELECT statements that use this table can be found below
CREATE TABLE cycling.calendar (race_id int, race_name text, race_start_date timestamp, race_end_date timestamp, PRIMARY KEY (race_id, race_start_date, race_end_date));

// Q7:
// Find all calendar events for a particular year and month
CREATE TABLE cycling.upcoming_calendar ( year int, month int, events list<text>, PRIMARY KEY ( year, month ));

// Q8:
// SIMPLE USER-DEFINED TYPE
CREATE TYPE cycling.fullname ( firstname text, lastname text );
CREATE TABLE cycling.race_winners (race_name text, race_position int, cyclist_name frozen<fullname>, PRIMARY KEY (race_name, race_position));

// Q9:
// Find all races for a particular cyclist
// CREATE TYPE - User-Defined Type, race
// CREATE TABLE WITH LIST, SIMPLE PRIMARY KEY
CREATE TYPE cycling.race (race_title text, race_date timestamp, race_time text);
CREATE TABLE cycling.cyclist_races ( id int PRIMARY KEY, lastname text, firstname text, races list<frozen <race>> );

// Q10: 
// Find all teams for a particular cyclist associated with the year of membership
// teams map<int, text> is map<year, team_name>
// CREATE TABLE WITH MAP, SIMPLE PRIMARY KEY
CREATE TABLE cycling.cyclist_teams ( id int PRIMARY KEY, lastname text, firstname text, teams map<int,text> );

// Q11:
// Find all stats for a particular cyclist
// CREATE TYPE -  UDT, basic_info
// CREATE TABLE with UDT, SIMPLE PRIMARY KEY
CREATE TYPE cycling.basic_info ( birthday timestamp, nationality text, weight text, height text );
CREATE TABLE cycling.cyclist_stats ( id int, lastname text, basics frozen <basic_info>, PRIMARY KEY (id) );

// Q12:
// Find total number of PCS points for a particular cyclist
// CREATE TABLE WITH PRIMARY KEY: PARTITION KEY + 1 CLUSTERING COLUMN
// USE STANDARD AGGREGATE IN QUERY
CREATE TABLE cycling.cyclist_points (id int, firstname text, lastname text, race_title text, race_points int, PRIMARY KEY (id, race_points );

// Q13:
// USES TABLE cycling.cyclist_points
// Find total number of PCS points for a particular cyclist using a user-defined function (UDF) created using java function log
// CREATE UDF
CREATE OR REPLACE FUNCTION fLog (input double) RETURNS double LANGUAGE java AS 'return Double.valueOf(Math.log(input.doubleValue()));';

// Q14:
//Find the average race_time in seconds for a particular race for a particular team.
// CREATE UDA that computes the average value
//CREATE TABLE WITH SIMPLE PRIMARY KEY: PARTITION KEY + 2 CLUSTERING COLUMNS
CREATE OR REPLACE FUNCTION avgState ( state tuple<int,bigint>, val int ) RETURNS tuple<int,bigint> LANGUAGE java AS 'if (val !=null) { state.setInt(0, state.getInt(0)+1; state.setLong(1, state.getLong(1)+val.intValue()); } return state;'; 
CREATE OR REPLACE FUNCTION avgFinal ( state tuple<int,bigint> ) RETURNS double LANGUAGE java AS 'double r = 0; if (state.getInt(0) == 0) return null; r = state.getLong(1); r/= state.getInt(0); return Double.valueOf(r);';
CREATE AGGREGATE average ( int ) SFUNC averageState STYPE tuple<int,bigint> FINALFUNC averageFinal INITCOND (0,0);
CREATE TABLE cycling.team_average (team_name text, cyclist_name text, cyclist_time_sec int, race_title text, PRIMARY KEY (team_name, race_title,cyclist_name));

// Q15:
// CREATE INDEX - PARTITION KEY
// Uses cycling.rank_by_year_and_name
// Find rank for all races for a particular race year
CREATE INDEX ryear ON cycling.rank_by_year_and_name (race_year);

// Q16:
// CREATE INDEX - COLLECTION - SET
// Find all the cyclists that have been on a particular team
CREATE INDEX team ON cycling.cyclist_career_teams (teams);

// Q17: 
// CREATE INDEX - COLLECTION ON MAP KEYS
// Find all cyclist/team combinations for a particular year
CREATE INDEX team_year ON cycling.cyclist_teams (KEY(teams));

// Q25
// QUERY - SCAN A PARTITION
// Find all cyclists that finished a race in a particular window of time
CREATE TABLE cycling.race_times (race_name text, cyclist_name text, race_time text, PRIMARY KEY (race_name, race_time));

// Q26
// QUERY USING MULTIPLE INDEXES
// DISCUSSION OF THE NEED FOR ALLOW FILTERING
// IS THIS BETTER THAN cyclist_stats??
CREATE TABLE cycling.cyclist_alt_stats ( id int PRIMARY KEY, lastname text, birthday timestamp, nationality text, weight text, height text );
CREATE INDEX birthday_idx ON cycling.cyclist_alt_stats (birthday);
CREATE INDEX nationality_idx ON cycling.cyclist_alt_stats (nationality);

// Q27
// USING EXPIRING DATA AND TTL TO DISPLAY THE LAST 3 DAYS race data
// 3 days in seconds is 259,200
// 2 days in seconds is 172800
// Data will vanish when its TTL runs out
CREATE TABLE cycling.last_3_days (race_name text, year timestamp, rank int, cyclist_name text, PRIMARY KEY (year, rank, cyclist_name));

// Q29:
// TUPLE
// Store the latitude/longitude waypoints for the route of a race
CREATE TABLE cycling.route (race_id int, race_name text, point_id int, lat_long FROZEN <tuple<text, tuple<float,float>>>, PRIMARY KEY (race_id, point_id));

// Q31:
// TUPLE
// Rank nations by points, including top cyclist
CREATE TABLE nation_rank ( nation text PRIMARY KEY, info FROZEN <tuple<int,text,int>> );

// Q32:
// TUPLE
// Popular Riders
CREATE TABLE popular (rank int PRIMARY KEY, cinfo FROZEN <tuple<text,text,int>> );
