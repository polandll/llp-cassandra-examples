UPDATE ks.tablename SET counter_value = counter_value + 1 WHERE artist = 'Led Zeppelin' and title = 'Misty Mountain Hop';

INSERT INTO ks.tablename (counter_value, artist, title) VALUES (1, 'Led Zeppelin', 'Misty Mountain Hop');

UPSERT ks.tablename SET counter_value = counter_value + 1 WHERE artist = 'Led Zeppelin' and title = 'Misty Mountain Hop';

LOAD INTO ks.tablename (counter_value, artist, title) VALUES (1, 'Led Zeppelin', 'Misty Mountain Hop');
