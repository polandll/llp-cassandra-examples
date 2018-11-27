source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.race_times;

// START-TABLE
CREATE TABLE cycling.race_times (
    race_name text,
    race_time time,
    finish_time duration,
    race_date date,
    cyclist_name text,
    PRIMARY KEY (race_date, race_name, cyclist_name));
// END-TABLE

// START-DATA
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time, race_date) VALUES ('17th Santos Tour Down Under', 'Rohan DENNIS', '19:15:18', '2017-04-14');
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time, race_date) VALUES ('17th Santos Tour Down Under', 'Richie PORTE', '19:15:20', '2017-04-14' );
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time, race_date) VALUES ('17th Santos Tour Down Under', 'Cadel EVANS', '19:15:38', '2017-04-14');
INSERT INTO cycling.race_times (race_name, cyclist_name, race_time, race_date) VALUES ('17th Santos Tour Down Under', 'Tom DUMOULIN', '19:15:40', '2017-04-14');
// END-DATA

// START-rename
ALTER TABLE cycling.race_times 
   RENAME race_date TO date;
// END-rename
