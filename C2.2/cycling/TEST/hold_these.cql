============================

CREATE TABLE cycling.top_five ( race text, year timestamp, top5 list<FROZEN <fullname>>, PRIMARY KEY (race, year) );

INSERT INTO cycling.top_five (race, year, top5) VALUES ('Tour de Romandie', '2015-05-03', [{firstname: 'Ilnur', lastname: 'Zakarin'}, {firstname: 'Simon', lastname: 'Spilak'}]);
UPDATE top_five SET top5 = top5 + [{firstname:'Christopher', lastname:'Froome'}] WHERE race = 'Tour de Romandie' AND year = '2015-05-03';

SELECT * FROM top_five;

// Procyclingstats.org - my DM for it

// This will produce the data that could be used to do a 3-DAY listing with either (1) application logic to get last 3 days or (2) USING TTL and entering data promptly
CREATE TABLE three_day ( race_date timestamp, race_name text, cyclist_rank int, cyclist_name FROZEN <fullname>, cyclist_team_name text, cyclist_race_time text, cyclist_country text, photo_blob blob, entry timestamp, PRIMARY KEY (race_date, cyclist_rank, race_name));
COPY three_day (race_date, race_name, cyclist_rank, cyclist_name,cyclist_team_name,cyclist_race_time,cyclist_country,entry) FROM '~/CLONES/cassandra-example-code-LLP/C3.0/cy.csv' WITH HEADER=true AND DELIMITER='|';
SELECT * FROM three_day;

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 1, {firstname:'Aaron', lastname:'Gate'}, 'An Post-Chain Reaction', '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 2, {firstname:'Alex', lastname:'Frame'}, null, '03:29:26','New Zealand', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-18', 'An Post Ras - Stage 2 - Carlow > Tipperary', 3, {firstname:'Davide', lastname:'Vigano'},'Team Idea 2010 ASD', '03:29:26','Italy', '2015-05-18 15:09:00');

INSERT INTO three_day (race_date, race_name, cyclist_rank, cyclist_name, cyclist_team_name, cyclist_race_time, cyclist_country, entry) VALUES ('2015-05-17', 'Giro d''Italia', 1, {firstname:'Paolo', lastname:'Tiralongo'},'Astana Pro Team', '05:50:31','Italy', '2015-05-18 15:09:00');
