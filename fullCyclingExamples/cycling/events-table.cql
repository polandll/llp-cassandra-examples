DROP table if exists cycling.events;

CREATE TABLE cycling.events (
   Year int,
   Start_Month int,
   Start_Day int,
   End_Month int,
   End_Day int,
   Race TEXT,
   Discipline TEXT,
   Location TEXT,
   UCI_code TEXT,
   PRIMARY KEY ((YEAR, Discipline), Start_Month, Start_Day, Race));

COPY cycling.events FROM 'events-data.csv' WITH HEADER = true AND DELIMITER = '|' ;