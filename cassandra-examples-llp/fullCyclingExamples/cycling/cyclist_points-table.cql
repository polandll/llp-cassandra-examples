source '0_create_keyspace.cql'
DROP TABLE IF EXISTS cycling.cyclist_points;

// START-cpoints
 CREATE TABLE cycling.cyclist_points (
 id UUID, 
 race_points int, 
 firstname text, 
 lastname text, 
 race_title text, 
 PRIMARY KEY (id, race_points)
 );
// END-cpoints

// Insert data
INSERT INTO cycling.cyclist_points (id,race_points,firstname,lastname,race_title) VALUES (e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 6, 'Giorgia', 'BRONZINI', 'Trofeo Alfredo Binda - Commune di Cittiglio');
INSERT INTO cycling.cyclist_points (id,race_points,firstname,lastname,race_title) VALUES (e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 75, 'Giorgia', 'BRONZINI', 'Act van Westerveld');
INSERT INTO cycling.cyclist_points (id,race_points,firstname,lastname,race_title) VALUES (e3b19ec4-774a-4d1c-9e5a-decec1e30aac, 120, 'Giorgia', 'BRONZINI', 'Tour of Chongming Island World Cup');

// Calculate sum of total points for a cyclist
// START-simplesumpoints
SELECT SUM(race_points) FROM cycling.cyclist_points WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// END-simplesumpoints

// Filter and SUM on a clustering column using an AND relation
// START-filtersumpoints
SELECT SUM(race_points) 
FROM cycling.cyclist_points 
WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac
      AND race_points > 7;
// END-filtersumpoints

// Filter for MAX points
// START-filtermaxpts
SELECT MAX(race_points) 
FROM cycling.cyclist_points
WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// END-filtermaxpts

// Filter for MIN points
// START-filterminpts
SELECT MIN(race_points) 
FROM cycling.cyclist_points
WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// END-filterminpts

// Filter for AVG points
// START-filteravgpts
SELECT AVG(race_points) 
FROM cycling.cyclist_points
WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
// END-filteravgpts

// Get WRITETIME for a column
// START-writetime
SELECT WRITETIME (firstname) FROM cycling.cyclist_points WHERE id=e3b19ec4-774a-4d1c-9e5a-decec1e30aac;
//END-writetime