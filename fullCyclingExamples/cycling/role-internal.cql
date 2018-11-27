// Requires authentication and authorization enabled using auth and role mgmt internal schemes

SOURCE '0_create_keyspace.cql';
SOURCE '';

// START-superuser
CREATE ROLE sys_admin 
   WITH LOGIN = true AND PASSWORD = 'changeme' 
   AND SUPERUSER = true;
// END-superuser

// internal roles used as user accounts

// START-user
CREATE ROLE martin 
   WITH PASSWORD = 'password' 
   AND LOGIN = true;
// END-user

CREATE ROLE sandy WITH PASSWORD = 'password' AND LOGIN = true;
CREATE ROLE sam WITH PASSWORD = 'password' AND LOGIN = true;

// START-permissionrole
CREATE ROLE IF NOT EXISTS cycling_admin;
// END-permissionrole

// START-droprole
DROP ROLE IF NOT EXISTS team_manager;
// END-droprole

CREATE ROLE IF NOT EXISTS team_manager;


CREATE ROLE IF NOT EXISTS role_admin;

// START-coach
CREATE ROLE coach 
  WITH PASSWORD = 'All4One2day!' 
  AND LOGIN = true;
// END-coach

// START-cylcingadmin
CREATE ROLE cycling_admin;
// END-cyclingadmin

// START-allauthks 
GRANT AUTHORIZE ON KEYSPACE cycling TO cycling_admin;
// END-allauthks 

// START-caALL
GRANT ALL PERMISSIONS on KEYSPACE cycling to cycling_admin;
// END-caALL

// START-roletorole
GRANT cycling_admin TO coach;
// END-roletorole

// START-authdata
GRANT AUTHORIZE FOR SELECT, MODIFY ON KEYSPACE cycling TO sam;
// END-authdata


// START-ap 
GRANT ALL PERMISSIONS ON KEYSPACE cycling TO cycling_admin;
// END-ap 

// START-data
GRANT SELECT, MODIFY ON KEYSPACE cycling TO coach;
// END-data

// START-alter
GRANT ALTER ON KEYSPACE cycling TO coach;
// END-alter

// START-rows
GRANT SELECT ON 'Sprint' ROWS IN cycling.cyclist_category TO martin;
// END-rows

// START-restrict
RESTRICT MODIFY, SELECT ON KEYSPACE cycling TO role_admin;
// END-restrict

// START-dbadmin
CREATE ROLE db_admin 
WITH superuser = true AND login = true 
AND password = 'anypasswordwilldo';
// END-dbadmin

// START-rdbadmin
RESTRICT MODIFY, SELECT ON KEYSPACE cycling TO db_admin;
// END-rdbadmin

// internal only give permissions from one role to another
GRANT cycling_admin TO martin;
GRANT team_manager TO sandy;
GRANT EXECUTE ON FUNCTION cycling.fLog(double) TO team_manager;

// removing access 
REVOKE SELECT ON ALL KEYSPACES FROM team_manager;
REVOKE EXECUTE ON FUNCTION cycling.fLog(double) FROM team_manager;
REVOKE sys_admin FROM team_manager;
REVOKE team_manager FROM sandy;

// role management examples
GRANT DESCRIBE, ALTER ON ALL ROLES TO admin;

// START-CHANGE_PW
ALTER ROLE sandy WITH PASSWORD='bestTeam';
// END-CHANGE_PW