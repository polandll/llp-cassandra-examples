USE cycling;
// 
CREATE TABLE cy8 ( cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_country text, overall_points float, entry timestamp, PRIMARY KEY (cyclist_rank));
// 
CREATE TABLE cy9 ( cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_country text, overall_points float, entry timestamp, PRIMARY KEY (cyclist_rank, overall_points));

COPY cy8 (cyclist_rank,cyclist_name,cyclist_team_name,cyclist_country,overall_points,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy2.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy9 (cyclist_rank,cyclist_name,cyclist_team_name,cyclist_country,overall_points,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy2.csv' WITH HEADER=true AND DELIMITER='|';

SELECT * FROM cy8;

//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 1, {firstname:'Aaron', lastname:'Gate'}, 'An Post-Chain Reaction', '03:29:26','New Zealand', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 2, {firstname:'Alex', lastname:'Frame'}, null, '03:29:26','New Zealand', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 3, {firstname:'Davide', lastname:'Vigano'},'Team Idea 2010 ASD', '03:29:26','Italy', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-17', 'Giro d''Italia', 1, {firstname:'Paolo', lastname:'Tiralongo'},'Astana Pro Team', '05:50:31','Italy', '2015-05-18 15:09:00');
