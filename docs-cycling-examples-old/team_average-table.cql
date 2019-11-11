source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.team_average;

CREATE TABLE cycling.team_average (
   team_name text,
   cyclist_name text,
   cyclist_time_sec int,
   race_title text,
   PRIMARY KEY (team_name, race_title, cyclist_name));

source 'team_average-table-data.cql';

// INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN', 'Anna', [ {race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Prologue - Garnich > Garnich',race_date:'2015-05-01',race_time:'08:13:00'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 2 - Garnich > Garnich',race_date:'2015-05-02',race_time:'02:41:52'},{race_title:'Festival Luxembourgeois du cyclisme feminin Elsy Jacobs - Stage 3 - Mamer > Mamer',race_date:'2015-05-03',race_time:'02:31:24'} ]);
