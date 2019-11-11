source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.cyclist_alt_stats;

CREATE TABLE cycling.cyclist_alt_stats (
   id UUID PRIMARY KEY,
   lastname text,
   birthday date,
   nationality text,
   weight float,
   w_units text,
   height float,
   first_race date,
   last_race date);

source 'cyclist_alt_stats-table-data.cql';