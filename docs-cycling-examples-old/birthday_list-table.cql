SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.birthday_list;

CREATE TABLE cycling.birthday_list (
   cyclist_name text PRIMARY KEY, 
   blist_ map<text,text>);

source 'birthday_list-table-data.cql';