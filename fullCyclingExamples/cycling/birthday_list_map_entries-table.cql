CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

// START-drop
DROP TABLE IF EXISTS cycling.birthday_list;
//END-drop

/* Map entries and regular index map fields example */

// START-blisttable
CREATE TABLE cycling.birthday_list (
   cyclist_name text PRIMARY KEY, 
   blist map<text,text>);
// END-blisttable

//Create index on map ENTRIES
// START-entriesidx
CREATE INDEX blist_idx 
   ON cycling.birthday_list (ENTRIES(blist));
// END-entriesidx

// START-insertentries
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Allan DAVIS', {'age':'35', 'bday':'27/07/1980', 'nation':'AUSTRALIA'});
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Claudio VANDELLI', {'age':'54', 'bday':'27/07/1961', 'nation':'ITALY'});
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Laurence BOURQUE', {'age':'23', 'bday':'27/07/1992', 'nation':'CANADA'});
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Claudio HEINEN', {'age':'23', 'bday':'27/07/1992', 'nation':'GERMANY'});
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Luc HAGENAARS', {'age':'28', 'bday':'27/07/1987', 'nation':'NETHERLANDS'});
INSERT INTO cycling.birthday_list (cyclist_name, blist) VALUES ('Toine POELS', {'age':'52', 'bday':'27/07/1963', 'nation':'NETHERLANDS'});
// END-insertentries

// Query entries - find cyclist same age
// START-ageentryquery
SELECT * FROM cycling.birthday_list WHERE blist['age'] = '23';
// END-ageentryquery

// Query entries - find cyclist same nation map entry
// START-nationentryquery
SELECT * FROM cycling.birthday_list WHERE blist['nation'] = 'NETHERLANDS';
// END-nationentryquery

// START-dropentriesindex
DROP INDEX IF EXISTS cycling.blist_idx;
//END-dropentriesindex

//Create index on map VALUES
// START-mapvaluesidx
CREATE INDEX blist_values_idx ON cycling.birthday_list (VALUES(blist));
// END-mapvaluesidx

// Query entries - find cyclist same nation with map VALUES CONTAINS
// START-nationvaluesquery
SELECT * FROM cycling.birthday_list WHERE blist CONTAINS 'NETHERLANDS';
// END-nationvaluesquery