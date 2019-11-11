source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.race_times;

CREATE TABLE cycling.race_times (
    race_name text,
    race_time time,
    finish_time duration,
    race_date date,
    cyclist_name text,
    PRIMARY KEY (race_date, race_name, cyclist_name));

source 'race_times-table-data.cql';

ALTER TABLE cycling.race_times 
  RENAME race_date TO date;

ALTER TABLE cycling.race_times 
  RENAME date TO race_date;