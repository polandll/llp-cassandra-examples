source '0_create_keyspace.cql';

CREATE TYPE IF NOT EXISTS cycling.race (
   race_title text,
   race_date timestamp,
   race_time text);