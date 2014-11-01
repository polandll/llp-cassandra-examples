CREATE TABLE lights (
   lightbulb_id int,
   temperature float,
   date timestamp,
   time timestamp,
   on_off_status boolean,
   PRIMARY KEY (lightbulb_id, date, time)
);
INSERT INTO lights (lightbulb_id, temperature, date, time, on_off_status) VALUES (1,98.6,2014-11-01,2014-11-01 10:00:00,true);
INSERT INTO lights (lightbulb_id, temperature, date, time, on_off_status) VALUES (1,100.6,2014-11-01,2014-11-01 10:01:00,true);
INSERT INTO lights (lightbulb_id, temperature, date, time, on_off_status) VALUES (1,97.3,2014-11-02,2014-11-01 10:00:00,true);
INSERT INTO lights (lightbulb_id, temperature, date, time, on_off_status) VALUES (1,101.5,2014-11-01,2014-11-01 10:01:00,true);
