USE test;
CREATE TABLE song (
	title text,
	band text,
	album text,
	track_number_on_album int,
	track_length float,
	PRIMARY KEY (album, band, title, track_number_on_album)
);

COPY song (title, band, album, track_number_on_album) FROM 'song_entries.csv' WITH HEADER=True AND DELIMITER='|';