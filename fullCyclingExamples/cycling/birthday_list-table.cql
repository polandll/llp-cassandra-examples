CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

// START-drop
DROP TABLE IF EXISTS cycling.birthday_list;
//END-drop

/* Map field and search index map fields example */

// START-table
CREATE TABLE cycling.birthday_list (
   cyclist_name text PRIMARY KEY, 
   blist_ map<text,text>);
// END-table

// START-insertall
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Allan DAVIS', {'blist_age':'35', 'bday':'27/07/1980', 'blist_nation':'AUSTRALIA'});
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Claudio VANDELLI', {'blist_age':'54', 'bday':'27/07/1961', 'blist_nation':'ITALY'});
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Laurence BOURQUE', {'blist_age':'23', 'bday':'27/07/1992', 'nation':'CANADA'});
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Claudio HEINEN', {'blist_age':'23', 'bday':'27/07/1992', 'blist_nation':'GERMANY'});
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Luc HAGENAARS', {'blist_age':'28', 'bday':'27/07/1987', 'blist_nation':'NETHERLANDS'});
INSERT INTO cycling.birthday_list (cyclist_name, blist_) VALUES ('Toine POELS', {'blist_age':'52', 'bday':'27/07/1963', 'blist_nation':'NETHERLANDS'});
// END-insertall

