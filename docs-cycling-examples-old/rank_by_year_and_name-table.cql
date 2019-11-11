source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.rank_by_year_and_name;

CREATE TABLE cycling.rank_by_year_and_name (
  race_year int,
  race_name text,
  cyclist_name text,
  rank int,
  PRIMARY KEY ((race_year, race_name), rank)
);

source 'rank_by_year_and_name-table-data.cql';

// Extraneous statements removed.