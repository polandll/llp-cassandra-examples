USE test;

CREATE TABLE song_counter (
	artist text,
	album text,
	song_counter counter,
	PRIMARY KEY(artist)
);

COPY song_counter
	(artist, album)
FROM 'song_counter_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';