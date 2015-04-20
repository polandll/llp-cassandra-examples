USE test;
CREATE TABLE film_clips (
	film_clip_id int,
	shot_time timestamp,
	shot_location text,
	actor_name text,
	PRIMARY KEY(film_clip_id)
);
CREATE INDEX film_clips_by_actor ON film_clips (actor_name);
CREATE INDEX film_clips_by_location ON film_clips (shot_location);

INSERT INTO film_clips (film_clip_id, shot_location, actor_name) VALUES (1,'Rubble City','Fred Flintstone');