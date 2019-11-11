source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.cyclist_id;

CREATE TABLE cycling.cyclist_id (
  lastname text,
  firstname text,
  age int,
  id UUID,
  PRIMARY KEY ((lastname, firstname), age)
);

source 'cyclist_id-table-data.cql'

// Other updates past this point deleted.