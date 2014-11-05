// FIRST QUESTION

SELECT * FROM contact WHERE state='MT';
SELECT * FROM contact WHERE firstname='Diane';
SELECT * FROM contact WHERE firstname IN ('Maureen','Diane','Leo');
SELECT * FROM contact WHERE state IN ('MT','OR','NY');

// SECOND QUESTION

SELECT * FROM contact WHERE lastname = 'Healey' AND firstname = 'Diane';
SELECT * FROM contact WHERE state='MT' AND firstname='Diane' AND lastname = 'Healey';
SELECT * FROM contact WHERE firstname = 'Diane' AND state='MT';
SELECT * FROM contact WHERE lastname = 'Healey';

