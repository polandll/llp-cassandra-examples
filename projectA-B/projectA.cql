USE test;

CREATE TABLE projectA (
	employee_id int,
	firstname text,
	lastname text,
	project_id int,
	project_title text,
	project_budget float,
	project_due_date timestamp,
	project_goal_priority int,
	project_goal_text text,
	PRIMARY KEY(project_id,project_goal_priority)
);

COPY projectA (employee_id, firstname,lastname,project_id,project_title,project_budget,project_due_date,project_goal_text,project_goal_priority) FROM 'projectA_entries.csv' WITH HEADER=True AND DELIMITER='|';