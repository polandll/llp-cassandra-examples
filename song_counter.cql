USE test;

CREATE TABLE song_counter (
	artist text,
	album text,
	song_counter counter,
	PRIMARY KEY(artist,album)
);

UPDATE song_counter SET song_counter=song_counter+1 WHERE artist='Led Zeppelin' AND album='Misty Mountain Hop';
UPDATE song_counter SET song_counter=song_counter+1 WHERE artist='Cat Stevens' AND album='Tea for the Tillerman';
UPDATE song_counter SET song_counter=song_counter+1 WHERE artist='Dar Williams' AND album='The Honesty Room';