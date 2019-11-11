
source '0_create_keyspace.cql'
DROP TABLE IF EXISTS cycling.country_flag;

CREATE TABLE cycling.country_flag (
   country text,
   cyclist_name text,
   flag int STATIC,
   PRIMARY KEY (country, cyclist_name));

source 'country_flag-table-data.cql';

// Extraneous statements removed.