SELECT 
COUNT(job_id) AS job_count,
CASE
    WHEN job_location ='Anywhere' THEN 'local'
    WHEN job_location = 'New York, NY' THEN 'nolocal'
    ELSE 'onsite'
END AS job_location_count
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' 
GROUP BY job_location_count ;

