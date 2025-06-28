SELECT
      skills_dim.skills AS skills,
      COUNT(skills_dim.skill_id) AS demanded_skills

FROM job_postings_fact
INNER JOIN skills_job_dim
 ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short= 'Data Analyst' AND
job_work_from_home = true
GROUP BY skills
ORDER BY demanded_skills DESC
LIMIT 5