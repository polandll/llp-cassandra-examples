source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_emails;

// Create a table with a known table id
// START-ID
CREATE TABLE cycling.cyclist_emails (
  userid text PRIMARY KEY,
  id UUID,
  emails set<text>
) WITH ID='1bb7516e-b140-11e8-96f8-529269fb1459';
// END-ID

// Drop a table with a known table id - record somewhere
DROP TABLE cycling.cyclist_emails ;

// Create a table again with a known table id
// START-recreateID
CREATE TABLE cycling.cyclist_emails (
  userid text PRIMARY KEY,
  id UUID,
  emails set<text>
) WITH ID='1bb7516e-b140-11e8-96f8-529269fb1459';
// END-recreateID