USE test;

CREATE TABLE videolist (
	title text,
	url text,
	rating int,
	PRIMARY KEY (title,url)
);

// Both COPY commands work
// COPY videolist FROM 'videolist_entries.csv';
// COPY videolist (title,url,rating) FROM 'videolist_entries.csv';
