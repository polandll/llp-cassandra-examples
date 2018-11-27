source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.cyclist_teams;

// create a table with a map
CREATE TABLE cycling.cyclist_teams (
    id uuid PRIMARY KEY,
    firstname text,
    lastname text,
    teams map<int, text> );
    
// insert team data into map for cyclist Vos
// START-insertmapdata
INSERT INTO cycling.cyclist_teams (id,firstname,lastname,teams)
  VALUES(
    5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 
    'Marianne',
    'VOS', 
    { 2015 : 'Rabobank-Liv Woman Cycling Team', 
      2014 : 'Rabobank-Liv Woman Cycling Team' });
// END-insertmapdata
 
// View data
SELECT * FROM cycling.cyclist_teams;

// Delete an element from the map
// START-deletemapdata
DELETE teams[2014] FROM cycling.cyclist_teams WHERE id=5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
// END-deletemapdata

// View data again, 2014 team gone
SELECT * FROM cycling.cyclist_teams;
 
 // insert more cyclists
 INSERT INTO cycling.cyclist_teams (id,firstname,lastname,teams)
  VALUES(
    cb07baad-eac8-4f65-b28a-bddc06a0de23, 
    'Elizabeth',
    'ARMITSTEAD', 
    { 2015 : 'Boels:Dolmans Cycling Team', 
      2014 : 'Boels:Dolmans Cycling Team',
      2013 : 'Boels:Dolmans Cycling Team',
      2012 : 'AA Drink - Leontien.nl',
      2011 : 'Team Garmin - Cervelo'});
     
// Create an index on a map key to find all cyclist/team combos for a year 
// START-keysidx   
CREATE INDEX team_year_idx ON cycling.cyclist_teams ( KEYS (teams) );
// END-keysidx

// Query for KEY year 2015
// START-queryindexkey
SELECT * From cycling.cyclist_teams WHERE teams CONTAINS KEY 2015;
// END-queryindexkey
