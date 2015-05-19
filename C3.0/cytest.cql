USE cycling;
// Works OK, not great
CREATE TABLE cy1 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_name, race_date, cyclist_rank));
// Works great
CREATE TABLE cy2 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_date, race_name, cyclist_rank));
// BAD
CREATE TABLE cy3 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_name, cyclist_rank, race_date));
// Works great
CREATE TABLE cy4 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_date, cyclist_rank, race_name));
// BAD
CREATE TABLE cy5 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (cyclist_rank, race_name, race_date));
// Eh! Dates are backwards
CREATE TABLE cy6 ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name frozen <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (cyclist_rank,race_date, race_name));

COPY cy1 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy2 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy3 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy4 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy5 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
COPY cy6 (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';

SELECT * FROM cy1;

//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 1, {firstname:'Aaron', lastname:'Gate'}, 'An Post-Chain Reaction', '03:29:26','New Zealand', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 2, {firstname:'Alex', lastname:'Frame'}, null, '03:29:26','New Zealand', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 3, {firstname:'Davide', lastname:'Vigano'},'Team Idea 2010 ASD', '03:29:26','Italy', '2015-05-18 15:09:00');
//INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-17', 'Giro d''Italia', 1, {firstname:'Paolo', lastname:'Tiralongo'},'Astana Pro Team', '05:50:31','Italy', '2015-05-18 15:09:00');
