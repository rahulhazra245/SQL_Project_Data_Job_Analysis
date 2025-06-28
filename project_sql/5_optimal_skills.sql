WITH top_demanded_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills AS skills,
        COUNT(skills_dim.skill_id) AS demanded_skills
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
      AND job_work_from_home = true
      AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),

top_paying_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills AS skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = true 
    GROUP BY skills_dim.skill_id, skills_dim.skills
)

SELECT 
    top_demanded_skills.skill_id,
    top_demanded_skills.skills,
    top_demanded_skills.demanded_skills,
    top_paying_skills.avg_salary
FROM top_demanded_skills
INNER JOIN top_paying_skills
    ON top_demanded_skills.skill_id = top_paying_skills.skill_id
    ORDER BY demanded_skills DESC,
    avg_salary DESC

LIMIT 25;
