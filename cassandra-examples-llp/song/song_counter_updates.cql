USE test;

UPDATE song_counter SET song_count = song_count + 1 WHERE artist = 'Led Zeppelin' and album = 'Misty Mountain Hop';

INSERT INTO song_counter (song_count, artist, album) VALUES (1, 'Led Zeppelin', 'Misty Mountain Hop');

UPSERT song_counter SET song_count = song_count + 1 WHERE artist = 'Led Zeppelin' and album = 'Misty Mountain Hop';

LOAD INTO song_counter (song_count, artist, album) VALUES (1, 'Led Zeppelin', 'Misty Mountain Hop');
