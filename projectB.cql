USE test;

CREATE TABLE projectB (
	employee_id int,
	firstname text,
	lastname text,
	project_id int,
	project_title text,
	project_budget float,
	project_due_date timestamp,
	project_goals_map map<int,text>,
	PRIMARY KEY(project_id,employee_id)
);

COPY projectB (employee_id, firstname,lastname,project_id,project_title,project_budget,project_due_date,project_goals_map) FROM 'projectB_entries.csv' WITH HEADER=True AND DELIMITER='|';