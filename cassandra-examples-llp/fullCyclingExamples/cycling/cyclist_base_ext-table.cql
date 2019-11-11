// START-cyclist_base_ext
CREATE TABLE IF NOT EXISTS cycling.cyclist_base (
     cid UUID PRIMARY KEY, 
     name text, 
     age int, 
     birthday date, 
     country text
     PRIMARY KEY (cid, age, birthday));
// END-cyclist_base_ext

// START-cyclist_base_extData
INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        d1aad83b-be60-47a4-bd6e-069b8da0d97b,
        'Johannes HEIDER',
        27,
        '1987-09-04',
        'Germany');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        1c526849-d3a2-42a3-bcf9-7903c80b3d16,
        'Kanden GROVES',
        19,
        '1998-12-23',
        'Australia');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
          96c4c40d-58c8-4710-b73f-681e9b1f70ae,
        'Benjamin DYBALL',
        29,
        '1989-04-20',
        'Australia');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        410919ef-bd1b-4efa-8256-b0fd8ab67029,
        'Iskandarbek SHODIEV',
        19,
        '1999-01-04',
        'Uzbekistan');
// END-cyclist_base_extData
