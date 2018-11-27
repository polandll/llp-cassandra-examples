
// CREATE TABLE WITH STATIC COLUMN, example uses an integer to identify flag, but it could be a blob
source '0_create_keyspace.cql'
DROP TABLE IF EXISTS cycling.country_flag;

// START-staticColumn
CREATE TABLE cycling.country_flag (
   country text,
   cyclist_name text,
   flag int STATIC,
   PRIMARY KEY (country, cyclist_name));
// END-staticColumn


INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('Belgium', 'Jacques', 1);
INSERT INTO cycling.country_flag (country, cyclist_name) VALUES ('Belgium', 'Andre');
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'Andre', 2);
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'George', 3);

// query to view inserted data
SELECT * from cycling.country_flag ;

// truncate data without dropping the table
// START-truncate
TRUNCATE cycling.country_flag;
// END-truncate

// query again to view data truncated from table
// START-emptytable
SELECT * from cycling.country_flag ;
// END-emptytable

// insert data again

INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('Belgium', 'Jacques', 1);
INSERT INTO cycling.country_flag (country, cyclist_name) VALUES ('Belgium', 'Andre');
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'Andre', 2);
INSERT INTO cycling.country_flag (country, cyclist_name, flag) VALUES ('France', 'George', 3);