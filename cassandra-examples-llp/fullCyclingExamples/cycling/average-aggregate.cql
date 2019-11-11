SOURCE '0_create_keyspace.cql';


//START-dropagg
DROP AGGREGATE IF EXISTS cycling.avgState;
//END-dropagg

// START-state
CREATE OR REPLACE FUNCTION cycling.avgState ( state tuple<int,bigint>, val int ) 
   CALLED ON NULL INPUT 
   RETURNS tuple<int,bigint> 
   LANGUAGE java AS 
     $$ if (val !=null) { 
         state.setInt(0, state.getInt(0)+1); 
         state.setLong(1, state.getLong(1)+val.intValue()); 
         } 
        return state; 
     $$;
// END-state

// START-test
CREATE TABLE cycling.test_avg (
    id int PRIMARY KEY,
    state frozen<tuple<int, bigint>>,
    val int PRIMARY KEY);
INSERT INTO test_avg (id,state,val) values (1,(6,9949),51);
INSERT INTO test_avg (id,state,val) values (2,(79,10000),9999);
SELECT state, avgstate(state,val) , val FROM test_avg;
// END-test

// START-final
CREATE OR REPLACE FUNCTION cycling.avgFinal ( state tuple<int,bigint> ) 
   CALLED ON NULL INPUT 
   RETURNS double 
   LANGUAGE java AS 
     $$ double r = 0; 
        if (state.getInt(0) == 0) return null; 
        r = state.getLong(1); 
        r /= state.getInt(0); 
        return Double.valueOf(r); $$ 
;
// END-final

// START-agg
CREATE AGGREGATE cycling.average(int) 
  SFUNC avgState 
  STYPE tuple<int,bigint> 
  FINALFUNC avgFinal 
  INITCOND (0,0);
// END-agg
