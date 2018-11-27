SOURCE 'role-internal.cql';


// START-query
SELECT role, resource, restricted FROM system_auth.role_permissions 
WHERE role = 'db_admin';
// END-query