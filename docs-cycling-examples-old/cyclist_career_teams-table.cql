source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.cyclist_career_teams;

CREATE TABLE cycling.cyclist_career_teams (
  id UUID PRIMARY KEY,
  lastname text,
  teams set<text>
);

CREATE INDEX teams_idx
ON cycling.cyclist_career_teams (teams) ;

source 'cyclist_career_teams-table-data.cql';

// Extraneous statements removed.
