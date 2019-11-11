CREATE TYPE test.address ( street text, city text, zip_code int, phones set<text> );
CREATE TYPE test.fullname ( firstname text, lastname text );
CREATE TABLE test.users ( id uuid PRIMARY KEY, name frozen <fullname>, direct_reports set<frozen <fullname>>, addresses map<text, frozen <address>> );
//INSERT INTO test.users (id, name) VALUES (62c36092-82a1-3a00-93d1-46196ee77204, {firstname: 'Marie-Claude', lastname: 'Josset'});
UPDATE test.users SET addresses = addresses + {'home': { street: '191 Rue St. Charles', city: 'Paris', zip_code: 75015, phones: {'33 6 78 90 12 34'}}} WHERE id=62c36092-82a1-3a00-93d1-46196ee77204;
SELECT name FROM test.users WHERE id=62c36092-82a1-3a00-93d1-46196ee77204;
SELECT name.lastname FROM test.users WHERE id=62c36092-82a1-3a00-93d1-46196ee77204;

CREATE INDEX on test.users (name);
SELECT id FROM test.users WHERE name = {firstname: 'Marie-Claude', lastname: 'Josset'};

UPDATE test.users SET direct_reports = { ( 'Naoko', 'Murai'), ( 'Sompom', 'Peh') } WHERE id=62c36092-82a1-3a00-93d1-46196ee77204;
INSERT INTO test.users (id, direct_reports) VALUES ( 7db1a490-5878-11e2-bcfd-0800200c9a66, { ('Jeiranan', 'Thongnopneua') } );
SELECT id, direct_reports FROM test.users;

CREATE TABLE test.band (id uuid PRIMARY KEY, name frozen <fullname>, other_members set<frozen <fullname>>, addresses map<text, frozen <address>> );
COPY test.users FROM 'UDT.csv';
UPDATE test.band SET addresses = addresses + {'home': { street: 'Downe House', city: 'London', zip_code: 55555, phones: {'44 020 11 12 34 56'}}} WHERE id=7db1a490-5878-11e2-bcfd-0800200c9a66;
UPDATE test.band SET other_members = { ( 'Keith', 'Richards'), ( 'Charlie', 'Watts') } WHERE id=7db1a490-5878-11e2-bcfd-0800200c9a66;
