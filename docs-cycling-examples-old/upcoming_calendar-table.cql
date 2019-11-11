SOURCE '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.upcoming_calendar;

CREATE TABLE cycling.upcoming_calendar (
   year int,
   month int,
   events list<text>,
   PRIMARY KEY ( year, month ));

source 'upcoming_calendar-table-data.cql';

// Extraneous statements removed.