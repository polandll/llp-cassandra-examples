source '0_create_keyspace.cql'

DROP TABLE IF EXISTS cycling.calendar;



// NOT A QUERY, JUST A TABLE FOR QUERIES
// CREATE TABLE WITH LIST FOR UPDATE
// The SELECT statements that use this table can be found below

// START-listColumn
CREATE TABLE cycling.calendar (
   race_id int,
   race_name text,
   race_start_date timestamp,
   race_end_date timestamp,
   PRIMARY KEY (race_id, race_start_date, race_end_date))
   WITH CLUSTERING ORDER BY (race_start_date DESC, race_end_date DESC);
// END-listColumn


INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (100, 'Giro d''Italia','2015-05-09','2015-05-31');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (101, 'Criterium du Dauphine','2015-06-07','2015-06-14');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (102, 'Tour de Suisse','2015-06-13','2015-06-21');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (103, 'Tour de France','2015-07-04','2015-07-26');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (100, 'Giro d''Italia','2014-05-08','2014-05-30');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (101, 'Criterium du Dauphine','2014-06-06','2014-06-13');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (102, 'Tour de Suisse','2014-06-12','2014-06-20');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (103, 'Tour de France','2014-07-03','2014-07-25');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (100, 'Giro d''Italia','2013-05-07','2014-05-29');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (101, 'Criterium du Dauphine','2013-06-05','2013-06-12');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (102, 'Tour de Suisse','2013-06-11','2013-06-19');
INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (103, 'Tour de France','2013-07-02','2013-07-24');
