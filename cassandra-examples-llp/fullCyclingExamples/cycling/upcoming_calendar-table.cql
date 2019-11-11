SOURCE '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.upcoming_calendar;


// Find all calendar events for a particular year and month
// START-listColumn
CREATE TABLE cycling.upcoming_calendar (
   year int,
   month int,
   events list<text>,
   PRIMARY KEY ( year, month ));
// START-listColumn

INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 06, ['Criterium du Dauphine','Tour de Suisse']);
INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 07, ['Tour de France']);



// START-insert
UPDATE cycling.upcoming_calendar 
SET events = ['Criterium du Dauphine','Tour de Suisse']
WHERE year=2015 AND month=06;
// END-insert

// START-prepend
UPDATE cycling.upcoming_calendar 
SET events = ['Tour de France'] + events 
WHERE year=2015 AND month=06;
// END-prepend

// START-append
UPDATE cycling.upcoming_calendar 
SET events = events + ['Tour de France'] 
WHERE year=2017 AND month=05;
// END-append

// START-position
UPDATE cycling.upcoming_calendar 
SET events[2] = 'Tour de France' 
WHERE year=2015 AND month=06;
// END-position

// START-set
UPDATE cycling.upcoming_calendar 
SET events[2] = 'Vuelta Ciclista a Venezuela' 
WHERE year = 2015 AND month = 06;
// END-set

// START-ttl
UPDATE cycling.upcoming_calendar 
USING TTL 10000000
SET events[2] = 'Vuelta Ciclista a Venezuela' 
WHERE year = 2015 AND month = 06;
// END-ttl

// START-addcolumn
ALTER TABLE cycling.upcoming_calendar 
ADD description map<text,text>;
// END-addcolumn

// START-example
UPDATE cycling.upcoming_calendar 
SET description = description + {'Criterium du Dauphine' : 'Easy race', 'Tour du Suisse' : 'Hard uphill race'}
WHERE year = 2015 AND month = 6;
// END-example

// START-newrow
UPDATE cycling.upcoming_calendar 
SET description = 
{'Criterium du Dauphine' : 'Easy race', 
 'Tour du Suisse' : 'Hard uphill race'} 
WHERE year = 2015 AND month = 6;
// END-newrow

// START-value
UPDATE cycling.upcoming_calendar 
SET events = events - ['Tour de France'] 
WHERE year=2015 AND month=06;
// END-value

// START-map
UPDATE cycling.upcoming_calendar 
SET description = description + {'Criterium du Dauphine' : 'Easy race'} 
WHERE year = 2015 AND month = 06 ;
// END-map

