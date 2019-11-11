source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.race_winners;

CREATE TABLE cycling.race_winners (
  cyclist_name FROZEN<fullname>,
  race_name text,
  race_position int,
  PRIMARY KEY (race_name, race_position)
);

source 'race_winners-table-data.cql';
