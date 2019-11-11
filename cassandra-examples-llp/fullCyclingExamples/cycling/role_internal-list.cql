SOURCE 'role-internal.cql';

// START-all
LIST ALL PERMISSIONS;
// END-all

// START-sam
LIST ALL PERMISSIONS OF sam;
// END-sam

// START-coach
LIST ALL PERMISSIONS OF coach;
// END-coach

// START-sandy
LIST ALL PERMISSIONS OF sandy;
// END-sandy

// START-resource
LIST ALL PERMISSIONS ON cycling.cyclist_name;
// END-resource

// START-authorize
LIST AUTHORIZE ON KEYSPACE cycling;
// END-autorize