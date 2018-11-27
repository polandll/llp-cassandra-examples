source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.cyclist_id;

// Find a cyclist's id given lastname and firstname
// Another CREATE TABLE using COMPOSITE PARTITION KEY
// 2i INDEX ALSO GOOD FOR THIS TABLE

// START-comp_pk
CREATE TABLE cycling.cyclist_id (
   lastname text,
   firstname text,
   age int,
   id UUID,
   PRIMARY KEY ((lastname, firstname), age) );
// END-comp_pk

// START-altercdc
ALTER TABLE cycling.cyclist_id
WITH CDC = false;
// END-altercdc

INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('EENKHOORN','Pascal',18, ffdfa2a7-5fc6-49a7-bfdc-3fcdcfdd7156);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('WELTEN','Bram',18, 18f471bf-f631-4bc4-a9a2-d6f6cf5ea503);
INSERT INTO cycling.cyclist_id (lastname, firstname, age, id) VALUES ('COSTA','Adrien',17, 15a116fc-b833-4da6-ab9a-4a7775752836);

// START-resetid
UPDATE cycling.cyclist_id 
SET id = UUID() 
WHERE lastname = 'WELTEN' AND firstname = 'Bram' AND age = 18
IF EXISTS;
// END-resetid

// START-ifid
UPDATE cycling.cyclist_id 
SET id = UUID() 
WHERE lastname = 'WELTEN' AND firstname = 'Bram' AND age = 18
IF id = 18f471bf-f631-4bc4-a9a2-d6f6cf5ea503;
// END-ifid

// START-ifnull
UPDATE cycling.cyclist_id 
SET id = UUID() 
WHERE lastname = 'Smith' AND firstname = 'Joe' AND age = 22
IF id = NULL;
// END-ifnull

 