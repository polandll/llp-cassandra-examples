SOURCE 'rank_by_year_and_name-table.cql';

// START-pplimit
SELECT rank, cyclist_name AS name
FROM cycling.rank_by_year_and_name
PER PARTITION LIMIT 2;
// END-pplimit

// START-InRestrictions
SELECT rank, cyclist_name as name FROM cycling.rank_by_year_and_name
WHERE race_name = 'Tour of Japan - Stage 4 - Minami > Shinshu' AND race_year IN (2014, 2015);
// END-InRestrictions


// START-filterRegular
SELECT rank, cyclist_name as name FROM cycling.rank_by_year_and_name
WHERE race_name = 'Tour of Japan - Stage 4 - Minami > Shinshu' AND race_year = 2015
AND rank <= 2;
// END-filterRegular


// START-tokenize
SELECT race_name AS name, race_year AS year FROM cycling.rank_by_year_and_name
WHERE TOKEN(race_year,race_name) >= 4582455970709790046
// END-tokenize

// START-sdistinct
SELECT TOKEN(race_year,race_name) as tokens,
race_name AS name, race_year AS year FROM cycling.rank_by_year_and_name
PER PARTITION LIMIT 1;
// END-sdistinct


// START-node_cycling
SELECT TOKEN(race_year, race_name), race_name AS name, race_year AS year
FROM cycling.rank_by_year_and_name
WHERE TOKEN(race_year, race_name) >= -3074457345618258603
AND TOKEN(race_year, race_name) <= 3074457345618258602;
// END-node_cycling
