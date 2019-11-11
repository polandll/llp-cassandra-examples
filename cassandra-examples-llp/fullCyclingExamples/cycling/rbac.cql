// when authentication and authorization is enabled

// internal roles used as user accounts
DROP ROLE IF EXISTS sys_admin;
CREATE ROLE sys_admin WITH SUPERUSER = true; // gives role access to everything
CREATE ROLE IF NOT EXISTS team_manager WITH PASSWORD = 'RockIt4Us!';
CREATE ROLE sandy WITH PASSWORD = 'password' AND LOGIN = true;
CREATE ROLE role_admin WITH PASSWORD = 'changeme' AND LOGIN = true;

// data resource examples
GRANT MODIFY ON KEYSPACE cycling TO team_manager;
GRANT AUTHORIZE ON ALL KEYSPACES TO sys_admin;

// internal role permission collects as DB object
GRANT sys_admin TO team_manager;
GRANT team_manager TO sandy;

// removing access 
REVOKE SELECT ON ALL KEYSPACES FROM team_manager;
REVOKE EXECUTE ON FUNCTION cycling.fLog(double) FROM team_manager;
REVOKE sys_admin FROM team_manager;
REVOKE team_manager FROM sandy;

// role management examples
GRANT DESCRIBE, ALTER ON ALL ROLES TO admin;

LIST ROLES;
LIST ROLES OF sandy;
LIST ALL PERMISSIONS OF sandy;
LIST ALL PERMISSIONS ON cycling.cyclist_name OF chuck;

// START-CHANGE_PW
ALTER ROLE sandy WITH PASSWORD='bestTeam';
// END-CHANGE_PW