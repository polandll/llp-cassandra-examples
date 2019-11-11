SOURCE 'team_average-table.cql';
SOURCE 'average-aggregate.cql';

// START-query
SELECT cycling.average(cyclist_time_sec) FROM cycling.team_average 
WHERE team_name='UnitedHealthCare Pro Cycling Womens Team' 
 AND race_title='Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe';
 // END-query