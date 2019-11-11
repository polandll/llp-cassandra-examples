source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_name;

CREATE TABLE cycling.cyclist_name (
  id UUID PRIMARY KEY,
  lastname text,
  firstname text
);

source 'cyclist_name-table-data.cql';

// Extraneous statements removed.