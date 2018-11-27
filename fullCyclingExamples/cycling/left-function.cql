SOURCE '0_create_keyspace.cql';

// START-left
CREATE FUNCTION IF NOT EXISTS cycling.left (column TEXT,num int) 
   RETURNS NULL ON NULL INPUT 
   RETURNS text 
   LANGUAGE javascript AS 
   $$ column.substring(0,num) $$ ;
// END-left
