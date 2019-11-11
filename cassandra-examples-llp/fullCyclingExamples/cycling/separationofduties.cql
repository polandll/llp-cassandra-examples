// need a basic roles cql

CREATE ROLE dbadmin;

GRANT ALL PERMISSIONS ON ALL KEYSPACES TO dbadmin;

CREATE ROLE security_admin WITH password = 'password' AND login = true;


