source 'race_times-table.cql';


// START-duration
INSERT INTO cycling.race_times (
   finish_time,
   race_name, cyclist_name, race_date)
VALUES (
   1h4m48s20ms,
   '17th Santos Tour Down Under', 'Rohan DENNIS', '2017-04-14');
// END-duration

// START-upduration
UPDATE cycling.race_times
  SET finish_time = 1h4m48s20ms
WHERE race_name = '17th Santos Tour Down Under'
  AND cyclist_name = 'Rohan DENNIS'
  AND race_date = '2017-04-14';
// END-upduration
