
// START-cyclingks
CREATE KEYSPACE IF NOT EXISTS cycling
WITH replication = {'class': 'SimpleStrategy', 'replication_factor':1};
// END-cyclingks

//START-usecycling
USE cycling;
//END-usecycling
