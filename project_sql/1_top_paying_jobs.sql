-- qn - what are the top paying job for my role

SELECT 
     job_id,
     job_title ,
     job_location ,
     job_posted_date,
     salary_year_avg,
     company_dim.name AS company_name
     
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id= job_postings_fact.company_id
WHERE job_title_short = 'Data Analyst' AND
job_location = 'Anywhere' AND
salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
 LIMIT 100