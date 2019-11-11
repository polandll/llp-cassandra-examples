source '0_create_keyspace.cql';

CREATE TYPE IF NOT EXISTS cycling.fullname (
  firstname text,
  lastname text );