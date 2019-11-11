CREATE TABLE test.books2 (
	book_id int,
	category text,
	title text,
	number_pages int,
	publisher text,
	pub_date timestamp,
	author text,
	PRIMARY KEY(book_id,publisher, pub_date)
);
