<<<<<<< HEAD


USE simple;

// START-one
CREATE TABLE single_cc (
  key int,
  col_1 int,
  PRIMARY KEY (key, col_1));
// END-one

INSERT INTO single_cc (key, col_1) VALUES (100, 1);
INSERT INTO single_cc (key, col_1) VALUES (100, 2);
INSERT INTO single_cc (key, col_1) VALUES (100, 3);
INSERT INTO single_cc (key, col_1) VALUES (100, 4);

// START-selectone
SELECT * FROM single_cc WHERE key = 100 AND col_1 < 3;
// END-selectone

 key | col_1
-----+-------
 100 |     1
 100 |     2

(2 rows)
SELECT * FROM single_cc WHERE key = 100;

 key | col_1
-----+-------
 100 |     1
 100 |     2
 100 |     3
 100 |     4

(4 rows)

=======
>>>>>>> dse5.1
CREATE TABLE simple.numbers (
   key int,
   col_1 int,
   col_2 int,
   col_3 int,
   col_4 int,
   PRIMARY KEY ((key), col_1, col_2, col_3, col_4));
<<<<<<< HEAD

   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,1,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,1,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,1,3);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,2,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,2,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,1,2,3);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,2,2,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,2,2,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,1,2,2,3);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,1,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,1,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,1,3);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,2,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,2,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,1,2,3);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,2,2,1);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,2,2,2);
   INSERT INTO numbers (key, col_1, col_2, col_3, col_4) VALUES (100,2,2,2,3);
=======
>>>>>>> dse5.1
