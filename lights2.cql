USE test;
CREATE TABLE lights2 (
   lightbulb_id int,
   temperature float,
   date_time timestamp,
   on_off_status boolean,
   PRIMARY KEY (date_time, lightbulb_id)
) WITH CLUSTERING ORDER BY (lightbulb_id ASC);

COPY lights2 (lightbulb_id, temperature, date_time, on_off_status) FROM 'lights2_entries.csv' WITH HEADER=True AND DELIMITER='|';
