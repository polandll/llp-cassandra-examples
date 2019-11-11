source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.calendar;

CREATE TABLE cycling.calendar (
  race_id int,
  race_name text,
  race_start_date timestamp,
  race_end_date timestamp,
  PRIMARY KEY (
    race_id, race_start_date, race_end_date
  )
) WITH CLUSTERING ORDER BY (
  race_start_date DESC, race_end_date DESC
);

COPY cycling.calendar FROM 'calendar-table-data.csv' WITH DELIMITER=',' AND HEADER=TRUE;

// Extraneous statements removed.
