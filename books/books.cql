USE test;
CREATE TABLE books (
	book_id int,
	category text,
	title text,
	number_pages int,
	publisher text,
	pub_date timestamp,
	author text,
	PRIMARY KEY(publisher, pub_date,book_id)
);

COPY books (book_id, category, title, author, publisher, pub_date, number_pages) FROM 'book_entries.csv' WITH HEADER=True AND DELIMITER='|';