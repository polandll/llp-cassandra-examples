source '0_create_keyspace.cql';
source 'fullname-type.cql';

DROP TABLE IF EXISTS cycling.race_winners;


// START-usetype
CREATE TABLE cycling.race_winners (
  cyclist_name FROZEN<fullname>, 
  race_name text,
  race_position int,
  PRIMARY KEY (race_name, race_position));
// END-usetype

INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 1, {firstname:'Frances',lastname:'DU TOUT'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 2, {firstname:'Lynette',lastname:'BENSON'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 3, {firstname:'Anja',lastname:'GERBER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 4, {firstname:'Ame',lastname:'VENTER'});
INSERT INTO cycling.race_winners (race_name, race_position, cyclist_name) VALUES ('National Championships South Africa WJ-ITT (CN)', 5, {firstname:'Danielle',lastname:'VAN NIEKERK'});
