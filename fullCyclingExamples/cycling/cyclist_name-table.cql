source '0_create_keyspace.cql';

// START-droptble
DROP TABLE IF EXISTS cycling.cyclist_name;
// END-droptble

// Create a table with a simple partition key
// START-simple
CREATE TABLE cycling.cyclist_name (
   id UUID PRIMARY KEY,
   lastname text,
   firstname text );
// END-simple

// START-uuid
INSERT INTO cycling.cyclist_name (id) VALUES ( uuid() );
// END-uuid

TRUNCATE cycling.cyclist_name;


// Insert data with TTL and timestamp
// START-insertstampttl
INSERT INTO cycling.cyclist_name (id, lastname, firstname)
  VALUES (6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47, 'KRUIKSWIJK','Steven')
  USING TTL 86400 AND TIMESTAMP 123456789;
// END-insertstampttl

// START-insertifnotexists
INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
   VALUES (c4b65263-fe58-4846-83e8-f0e1c13d518f, 'RATTO', 'Rissella') 
IF NOT EXISTS; 
// END-insertifnotexists
  
TRUNCATE cycling.cyclist_name;

// Insert 6 rows of cyclists
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 'VOS','Marianne');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN','Anna');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME','Alex');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (220844bf-4860-49d6-9a4b-6b5d3a79cbfb, 'TIRALONGO','Paolo');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47, 'KRUIKSWIJK','Steven');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (fb372533-eb95-4bb4-8685-6ef61e994caa, 'MATTHEWS', 'Michael');

// View output
SELECT * FROM cycling.cyclist_name;

// Delete data in specified columns from a row, changes cyclist Alex Frame to null in name columns
// START-deletecolumndata
DELETE firstname, lastname FROM cycling.cyclist_name 
WHERE id=e7ae5cf3-d358-4d99-b900-85902fda9bb0;
// END-deletecolumndata

// View output
SELECT * FROM cycling.cyclist_name;

// Delete an entire row, deletes cyclist Alex Frame altogether
// START-deleteentirerow
DELETE FROM cycling.cyclist_name 
WHERE id=e7ae5cf3-d358-4d99-b900-85902fda9bb0 IF EXISTS;
// END-deleteentirerow

// View output
SELECT * FROM cycling.cyclist_name;

// Delete a row based on a static column condition, attempts to delete cyclist Michael Matthews but lastname does not match 
// START-deletecondition
DELETE FROM cycling.cyclist_name 
WHERE id=fb372533-eb95-4bb4-8685-6ef61e994caa 
IF firstname='Michael' and lastname='Smith';
// END-deletecondition

// View output
SELECT * FROM cycling.cyclist_name;

// Delete a row with a WHERE clause, deletes cyclist Steven Kruikswijk
// START-deleterowhere
DELETE FROM cycling.cyclist_name 
WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
// END-deleterowhere

// View output
SELECT * FROM cycling.cyclist_name;

// Delete rows using an IN clause on a primary key, deletes cyclists Marianne and Paolo
// START-deletein
DELETE FROM cycling.cyclist_name 
WHERE id IN (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 220844bf-4860-49d6-9a4b-6b5d3a79cbfb);
// END-deletein

// View output
SELECT * FROM cycling.cyclist_name;

// Reinsert data 
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 'VOS','Marianne');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN','Anna');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME','Alex');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (220844bf-4860-49d6-9a4b-6b5d3a79cbfb, 'TIRALONGO','Paolo');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47, 'KRUIKSWIJK','Steven');
INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (fb372533-eb95-4bb4-8685-6ef61e994caa, 'MATTHEWS', 'Michael');

// START-comment
ALTER TABLE cycling.cyclist_name ADD comment text;
// END-comment

// START-update
UPDATE cycling.cyclist_name
SET comment ='Rides hard, gets along with others, a real winner'
WHERE id = fb372533-eb95-4bb4-8685-6ef61e994caa 
IF EXISTS;
// END-update

// START-multcolumns
UPDATE cycling.cyclist_name
 SET firstname = 'Marianne',
     lastname = 'VOS'
WHERE id = 88b8fd18-b1ed-4e96-bf79-4280797cba80;
// END-multcolumns

// START-records
UPDATE cycling.cyclist_name
 SET firstname = NULL
 WHERE id IN ( 5b6962dd-3f90-4c93-8f61-eabfa4a803e2, fb372533-eb95-4bb4-8685-6ef61e994caa);
// END-records

// START-upsert
UPDATE cycling.cyclist_name
SET firstname = 'Anna', lastname = 'VAN DER BREGGEN' 
WHERE id = e7cd5752-bc0d-4157-a80f-7523add8dbcd;
// END-upsert

// START-if
UPDATE cycling.cyclist_name
SET comment ='Rides hard, gets along with others, a real winner'
WHERE id = fb372533-eb95-4bb4-8685-6ef61e994caa 
IF comment = NULL;
// END-if

// START-fail
UPDATE cycling.cyclist_name
SET comment ='Rides hard, gets along with others, a real winner'
WHERE id = fb372533-eb95-4bb4-8685-6ef61e994cac 
IF comment = 'Rides hard, gets along with others, a real winner';
// END-fail


