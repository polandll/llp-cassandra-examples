SOURCE 'role-internal.cql';


// START-data
REVOKE SELECT, MODIFY ON KEYSPACE cycling 
FROM coach;
// END-data

// START-alter
REVOKE ALTER ON KEYSPACE cycling 
FROM coach;
// END-alter

