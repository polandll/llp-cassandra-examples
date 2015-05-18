CREATE KEYSPACE music WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'datacenter1' : 1};
USE music;
CREATE TABLE music.songs ( id uuid PRIMARY KEY, album text, artist text, data blob, reviews list<text>, tags set<text>, title text, venue map<timestamp, text>);
CREATE TABLE music.playlists ( id uuid, song_order int, song_id uuid, title text, album text, artist text, PRIMARY KEY  (id, song_order ) );

INSERT INTO music.playlists (id, song_order, song_id, title, artist, album) VALUES (62c36092-82a1-3a00-93d1-46196ee77204, 4, 7db1a490-5878-11e2-bcfd-0800200c9a66, 'Ojo Rojo', 'Fu Manchu', 'No One Rides for Free');
INSERT INTO music.playlists (id, song_order, song_id, title, artist, album) VALUES (62c36092-82a1-3a00-93d1-46196ee77204, 1, a3e64f8f-bd44-4f28-b8d9-6938726e34d4, 'La Grange', 'ZZ Top', 'Tres Hombres');
INSERT INTO music.playlists (id, song_order, song_id, title, artist, album) VALUES (62c36092-82a1-3a00-93d1-46196ee77204, 2, 8a172618-b121-4136-bb10-f665cfc469eb, 'Moving in Stereo', 'Fu Manchu', 'We Must Obey');
INSERT INTO music.playlists (id, song_order, song_id, title, artist, album) VALUES (62c36092-82a1-3a00-93d1-46196ee77204, 3, 2b09185b-fb5a-4734-9b56-49077de9edbf, 'Outside Woman Blues', 'Back Door Slam', 'Roll Away');

UPDATE music.songs SET tags = tags + {'2007'} WHERE id = 8a172618-b121-4136-bb10-f665cfc469eb;
UPDATE music.songs SET tags = tags + {'covers'} WHERE id = 8a172618-b121-4136-bb10-f665cfc469eb;
UPDATE music.songs SET tags = tags + {'1973'} WHERE id = a3e64f8f-bd44-4f28-b8d9-6938726e34d4;
UPDATE music.songs SET tags = tags + {'blues'} WHERE id = a3e64f8f-bd44-4f28-b8d9-6938726e34d4;
UPDATE music.songs SET tags = tags + {'rock'} WHERE id = 7db1a490-5878-11e2-bcfd-0800200c9a66;
UPDATE music.songs SET tags = tags + {'rock'} WHERE id = 7db1a490-5878-11e2-bcfd-0800200c9a66;
UPDATE music.songs SET reviews = reviews + [ 'hot dance music' ] WHERE id = 7db1a490-5878-11e2-bcfd-0800200c9a66;

INSERT INTO music.songs (id, venue) VALUES (7db1a490-5878-11e2-bcfd-0800200c9a66, { '2013-9-22 12:01'  : 'The Fillmore', '2013-10-1 18:00' : 'The Apple Barrel'});

// MY ADDITIONS, LLP, 05.14.15

INSERT INTO music.playlists JSON '{"id" : "8da9da40-f360-11e4-b9b2-1697f925ec7b", "song_order" : 1, "title" : "Drive My Car", "artist" : "The Beatles", "album" : "Rubber Soul"}';
SELECT JSON * FROM music.playlists;
SELECT JSON album, title, artist FROM music.playlists;

CREATE TYPE music.address ( street text, city text, zip_code int, phones set<text> );
CREATE TYPE music.fullname ( firstname text, lastname text );
CREATE TABLE music.band ( id uuid PRIMARY KEY, name frozen <fullname>, other_members set<frozen <fullname>>, addresses map<text, frozen <address>> );
COPY music.users FROM 'UDT.csv';
UPDATE music.band SET addresses = addresses + {'home': { street: 'Downe House', city: 'London', zip_code: 55555, phones: {'44 020 11 12 34 56'}}} WHERE id=7db1a490-5878-11e2-bcfd-0800200c9a66;
UPDATE music.band SET other_members = { ( 'Keith', 'Richards'), ( 'Charlie', 'Watts') } WHERE id=7db1a490-5878-11e2-bcfd-0800200c9a66;
