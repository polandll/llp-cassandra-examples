COPY test.books (book_id, category, title, author, publisher, pub_date, number_pages) FROM 'book_entries.csv' WITH HEADER=True AND DELIMITER='|';
COPY test.books2 (book_id, category, title, author, publisher, pub_date, number_pages) FROM 'book_entries.csv' WITH HEADER=True AND DELIMITER='|';
