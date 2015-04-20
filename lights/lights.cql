USE test;
CREATE TABLE lights (
   lightbulb_id int,
   temperature float,
   date timestamp,
   time timestamp,
   on_off_status boolean,
   PRIMARY KEY (lightbulb_id, date, time)
);
COPY lights (lightbulb_id, temperature, date, time, on_off_status) FROM 'lights_entries.csv' WITH HEADER=True AND DELIMITER='|';
