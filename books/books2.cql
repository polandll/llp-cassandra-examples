USE test;
CREATE TABLE books2 (
	book_id int,
	category text,
	title text,
	number_pages int,
	publisher text,
	pub_date timestamp,
	author text,
	PRIMARY KEY(book_id,publisher, pub_date)
);

COPY books2 (book_id, category, title, author, publisher, pub_date, number_pages) FROM 'book_entries.csv' WITH HEADER=True AND DELIMITER='|';