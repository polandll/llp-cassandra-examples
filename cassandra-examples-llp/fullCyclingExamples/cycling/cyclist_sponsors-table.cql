SOURCE '0_create_keyspace.cql'

// USE IF ABOVE SOURCE STATEMENT IS NOT USED
// START-cyclingks
//CREATE KEYSPACE IF NOT EXISTS cycling
//WITH replication = {'class': 'SimpleStrategy', 'replication_factor':1};
// END-cyclingks

//START-usecycling
USE cycling;
//END-usecycling

DROP TABLE IF EXISTS cycling.cyclist_sponsors_expire ;

// START-cyclistsponsorsexpireset
CREATE TABLE cycling.cyclist_sponsors_expire (
  cyclist_name text PRIMARY KEY,
  sponsorship set<text>
  );
// END-cyclistsponsorsexpireset

// START-insertTTLexpireset
INSERT INTO cycling.cyclist_sponsors_expire (cyclist_name, sponsorship) 
  VALUES ('PRIETO, Marcela',  {'Castrelli', 'Alfa Romeo'}) 
  USING TIMESTAMP 100 AND TTL 10000;
// END-insertTTLexpireset

// START-updateTTLexpireset
UPDATE cycling.cyclist_sponsors_expire 
  USING TIMESTAMP 200 AND TTL 20000 
  SET sponsorship += {'Tag Heuer'} 
  WHERE cyclist_name='PRIETO, Marcela';
// END-updateTTLexpireset

// START-selectTTLexpireset
SELECT * FROM cycling.cyclist_sponsors_expire;
// END-selectTTLexpireset
