-- DELIVERABLE 1
-- Retrieve retirement list
SELECT em.emp_no, 
	em.first_name, 
	em.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti 
ON em.emp_no = ti.emp_no
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no;

-- Confirm table looks correct
SELECT *
FROM retirement_titles;

-- Create table of current employees in current position
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
	ret.first_name,
	ret.last_name,
	ret.title
INTO unique_titles
FROM retirement_titles as ret
ORDER BY ret.emp_no,
	ret.to_date DESC;
	
-- Confirm table looks correct
SELECT *
FROM unique_titles;

-- Retrieve # of employees about to retire from each title
SELECT COUNT(uni.emp_no),
	uni.title 
INTO retiring_titles
FROM unique_titles as uni
GROUP BY uni.title
ORDER BY COUNT DESC;

-- Confirm table looks correct
SELECT *
FROM retiring_titles;

-- DELIVERABLE 2
-- Retrieve list of employees of certain age, w/ no duplicates
SELECT DISTINCT ON (em.emp_no) em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title 
INTO mentorship_eligibilty
FROM employees as em
INNER JOIN dept_emp as de ON (em.emp_no = de.emp_no)
INNER JOIN titles as ti ON (em.emp_no = ti.emp_no)
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
			AND de.to_date = '9999-01-01')
ORDER BY em.emp_no,
	ti.to_date DESC;

-- Confirm table looks correct 
SELECT *
FROM mentorship_eligibilty