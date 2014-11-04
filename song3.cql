USE test;
CREATE TABLE song3 (
	title text,
	band text,
	album text,
	track_number_on_album int,
	track_length float,
	PRIMARY KEY (title, track_length)
);

COPY song3 (title, band, album, track_number_on_album,track_length) FROM 'song_entries.csv' WITH HEADER=True AND DELIMITER='|';