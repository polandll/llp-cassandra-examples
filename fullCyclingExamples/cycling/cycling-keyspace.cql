// START-single
CREATE KEYSPACE cycling
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };
// END-single

// START-drop
DROP KEYSPACE cycling;
// END-drop

// START-network
CREATE KEYSPACE cycling 
  WITH REPLICATION = { 
   'class' : 'NetworkTopologyStrategy', 
   'datacenter1' : 1 } 
;
// END-network

DROP KEYSPACE cycling;

// START-multi
CREATE KEYSPACE "Cycling"
  WITH REPLICATION = {
   'class' : 'NetworkTopologyStrategy', 
   'boston'  : 3 , // Datacenter 1 
   'seattle' : 2 , // Datacenter 2
   'tokyo'   : 2 , // Datacenter 3
  };
// END-multi

DROP KEYSPACE cycling;

// START-durable
CREATE KEYSPACE cycling
  WITH REPLICATION = { 
   'class' : 'NetworkTopologyStrategy',
   'datacenter1' : 3 
  } 
AND DURABLE_WRITES = false ;
// END-durable