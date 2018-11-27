// QUERY USING MULTIPLE INDEXES
// DISCUSSION OF THE NEED FOR ALLOW FILTERING
// Showing date upserts and queries
// avg

source '0_create_keyspace.cql'

// START-drop_cyclist_alt_stats
DROP TABLE IF EXISTS cycling.cyclist_alt_stats;
// END-drop_cyclist_alt_stats


// START-cyclist_alt_stats
CREATE TABLE cycling.cyclist_alt_stats (
   id UUID PRIMARY KEY,
   lastname text,
   birthday date,
   nationality text,
   weight float,
   w_units text,
   height float,
   first_race date,
   last_race date);
// END-cyclist_alt_stats

// START-insert
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height, first_race, last_race) VALUES (ed584e99-80f7-4b13-9a90-9dc5571e6821,'TSATEVICH', '1989-07-05', 'Russia', 64, 'kg', 1.69, '2006-03-15','2017-04-16');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (a9e96714-2dd0-41f9-8bd0-557196a44ecf,'ISAYCHEV', '1986-04-21', 'Russia', 80, 'kg', 1.88,'2003-04-22','2017-03-05');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (823ec386-2a46-45c9-be41-2425a4b7658e,'BELKOV', '1985-01-09', 'Russia', 71, 'kg', 1.84,'2002-03-22','2017-04-16');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (e0953617-07eb-4c82-8f91-3b2757981625,'BRUTT', '1982-01-29', 'Russia', 68, 'kg', 1.78,'1998-02-15','2017-04-16');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (078654a6-42fa-4142-ae43-cebdc67bd902,'LAGUTIN', '1981-01-14', 'Russia', 63, 'kg', 1.82,'1996-05-21','2010-10-02');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (d74d6e70-7484-4df5-8551-f5090c37f617,'GRMAY', '1991-08-25', 'Ethiopia', 63, 'kg', 1.75, '2006-05-21','2017-04-16');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (c09e9451-50da-483d-8108-e6bea2e827b3,'VEIKKANEN', '1981-03-29', 'Finland', 66, 'kg', 1.78,'1996-05-21','2012-10-02');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (f1deff54-7d96-4981-b14a-b70be4da82d2,'TLEUBAYEV', null, 'Kazakhstan', null, null, null, '2003-04-22','2017-04-16');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (1ba0417d-62da-4103-b710-de6fb227db6f,'PAULINHO', '1990-05-27', 'Portugal', null, null, null, '2006-03-15','2017-03-05');
INSERT INTO cycling.cyclist_alt_stats (id, lastname, birthday, nationality, weight, w_units, height,  first_race, last_race) VALUES (4ceb495c-55ab-4f71-83b9-81117252bb13,'DUVAL', '1990-05-27','France', null, null, null, '2006-03-15','2017-04-16');
// END-insert
