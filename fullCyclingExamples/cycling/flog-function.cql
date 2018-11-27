SOURCE '0_create_keyspace.cql';

//START-dropflog
DROP FUNCTION IF EXISTS cycling.fLog;
//END-dropflog


// START-flog
CREATE OR REPLACE FUNCTION cycling.fLog (input double) 
   CALLED ON NULL INPUT 
   RETURNS double 
   LANGUAGE java AS 
   $$ return Double.valueOf(Math.log(input.doubleValue())); $$ 
;
// END-flog
