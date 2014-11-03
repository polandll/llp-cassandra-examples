// Note that the next two SELECT statements work, but the PRIMARY KEY is badly designed, and
// the second item in the CSV file is overwritten by the third item, so only three items exist

SELECT * from projectA WHERE project_id=2;

SELECT * from projectA WHERE project_id=2 AND project_goal_priority=2;

// This works just fine.
SELECT * from projectB WHERE project_id=2;

// This will not work because the project_goal_priority is part of a map collection.
SELECT * from projectB WHERE project_id=2 AND project_goal_priority=2;