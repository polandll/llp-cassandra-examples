source '0_create_keyspace.cql';

source 'team_average-table.cql';

// START-AVG
SELECT AVG(cyclist_time_sec) AS Average FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// END-AVG

// START-rAVG
average
---------
  11474

(1 rows)
// END-rAVG

// START-COUNT
SELECT count(cyclist_name) AS Row_Count FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// END-COUNT

// START-rCOUNT
row_count
-----------
        3

(1 rows)
// END-rCOUNT

// START-MIN
SELECT MIN(cyclist_time_sec) AS Fastest FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// END-MIN

// START-rMIN
fastest
---------
  11449

(1 rows)
// END-rMIN

// START-MAX
SELECT MAX(cyclist_time_sec) AS Slowest FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// END-MAX

// START-rMAX
slowest
---------
  11490

(1 rows)
// END-rMAX

// START-SUM
SELECT SUM(cyclist_time_sec) AS Total_Time FROM cycling.team_average
WHERE team_name = 'UnitedHealthCare Pro Cycling Womens Team';
// END-SUM

// START-rSUM
total_time
------------
     34424

(1 rows)
// END-rSUM
