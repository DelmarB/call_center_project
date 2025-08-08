USE call_center;

-- Total calls by type
SELECT call_type, COUNT(*) AS total_calls
FROM calls
GROUP BY call_type;
-- Inbound	25071
-- Outbound	24929

-- Call volume by agent
SELECT agent_id, COUNT(*) AS call_count
FROM agents
GROUP BY agent_id
ORDER BY call_count ASC;

-- average call duration
SELECT AVG(call_duration)
FROM calls;
-- 60.6007

-- minimum/maximum call duration
SELECT MIN(call_duration) AS min_call_duration, MAX(call_duration) AS max_call_duration
FROM calls;
-- 1 | 120

-- count number of call_duration in ranges
SELECT
	COUNT(*) AS total_calls,
    SUM(CASE WHEN call_duration BETWEEN 1  AND  30 THEN 1 ELSE 0 END) AS '1-30 min',
    SUM(CASE WHEN call_duration BETWEEN 31  AND  60 THEN 1 ELSE 0 END) AS '31-60 min',
    SUM(CASE WHEN call_duration BETWEEN 61  AND  90 THEN 1 ELSE 0 END) AS '61-90 min',
    SUM(CASE WHEN call_duration BETWEEN 91  AND  120 THEN 1 ELSE 0 END) AS '91-120 min',
    SUM(CASE WHEN call_duration > 120 THEN 1 ELSE 0 END) AS '120 + min'
FROM calls;
-- 50000	12487	12435	12551	12527	0    

SELECT
	COUNT(*) AS total_calls,
    SUM(CASE WHEN call_duration BETWEEN 1  AND  10 THEN 1 ELSE 0 END) AS '1-10 min',
    SUM(CASE WHEN call_duration BETWEEN 11  AND  20 THEN 1 ELSE 0 END) AS '11-20 min',
    SUM(CASE WHEN call_duration BETWEEN 21  AND  30 THEN 1 ELSE 0 END) AS '21-30 min',
    SUM(CASE WHEN call_duration BETWEEN 31  AND  40 THEN 1 ELSE 0 END) AS '31-40 min'
FROM calls;
-- 50000	4118	4089	4280	4130

SELECT DISTINCT call_duration FROM calls ORDER BY call_duration;

-- csat date range
SELECT MIN(survey_date) AS min_date, MAX(survey_date) AS max_date
FROM csat;
-- 2025-01-01	2025-07-19

-- count how many agents not getting a rating
SELECT agent_id 
FROM agents
WHERE agent_id NOT IN (SELECT agent_id FROM csat);
-- all agents have ratings!!!

-- csat best of entire date range
SELECT agent_id, COUNT(*) as total_5_rating
FROM csat
WHERE rating = 5
GROUP BY agent_id
ORDER BY total_5_rating DESC;

-- csat 1 rating of entire date range
SELECT agent_id, COUNT(*) as total_1_rating
FROM csat
WHERE rating = 1
GROUP BY agent_id
ORDER BY total_1_rating DESC;

-- count number of ratings
SELECT
	COUNT(*) AS total_stars,
    SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) AS '1-star',
    SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) AS '2-star',
    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) AS '3-star',
    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) AS '4-star',
    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) AS '5-star'
FROM csat;
-- 10000	1983	1935	2036	2016	2016

-- count escalation reasons:
SELECT
	COUNT(*) AS total_escalations,
    SUM(CASE WHEN escalation_reason = 'Policy issue' THEN 1 ELSE 0 END) AS 'Policy issue',
    SUM(CASE WHEN escalation_reason = 'Agent not skilled' THEN 1 ELSE 0 END) AS 'Agent not skilled',
    SUM(CASE WHEN escalation_reason = 'Customer request' THEN 1 ELSE 0 END) AS 'Customer request'
FROM escalations;
-- 5000		1688	1647	1665

SELECT
	COUNT(*) AS total_escalations,
    SUM(CASE WHEN escalation_reason = 'Policy issue' AND resolution_status = 'Pending' THEN 1 ELSE 0 END) AS 'Policy issue/Pending',
	SUM(CASE WHEN escalation_reason = 'Policy issue' AND resolution_status = 'Closed' THEN 1 ELSE 0 END) AS 'Policy issue/Closed',
	SUM(CASE WHEN escalation_reason = 'Policy issue' AND resolution_status = 'Resolved' THEN 1 ELSE 0 END) AS 'Policy issue/Resolved',
    SUM(CASE WHEN escalation_reason = 'Agent not skilled' AND resolution_status = 'Pending' THEN 1 ELSE 0 END) AS 'Agent not skilled/Pending',
	SUM(CASE WHEN escalation_reason = 'Agent not skilled' AND resolution_status = 'Closed' THEN 1 ELSE 0 END) AS 'Agent not skilled/Closed',
	SUM(CASE WHEN escalation_reason = 'Agent not skilled' AND resolution_status = 'Resolved' THEN 1 ELSE 0 END) AS 'Agent not skilled/Resolved',
    SUM(CASE WHEN escalation_reason = 'Customer request' AND resolution_status = 'Pending' THEN 1 ELSE 0 END) AS 'Customer request/Pending',
	SUM(CASE WHEN escalation_reason = 'Customer request' AND resolution_status = 'Closed' THEN 1 ELSE 0 END) AS 'Customer request/Closed',
	SUM(CASE WHEN escalation_reason = 'Customer request' AND resolution_status = 'Resolved' THEN 1 ELSE 0 END) AS 'Customer request/Resolved'
FROM escalations;
-- 5000	571	561	556	536	543	568	536	578	551

SELECT DISTINCT resolution_status
FROM escalations;
-- Pending    Closed    Resolved
SELECT
    resolution_status,
    COUNT(*) AS status_count
FROM escalations
GROUP BY resolution_status;


SELECT DISTINCT escalation_reason
FROM escalations;
-- Policy issue    Agent not skilled    Customer request



--  count of top 10 customer escalations
SELECT customer_id, COUNT(*) AS count
FROM escalations
GROUP BY customer_id
ORDER BY count DESC
LIMIT 10;

SELECT 
    a.agent_id, 
    a.first_name, 
    a.last_name, 
    c.rating, 
    c.survey_date
FROM agents a
JOIN csat c ON a.agent_id = c.agent_id
WHERE a.first_name = 'Adam'
  AND a.last_name = 'Fox'
  AND c.survey_date = '2025-04-17';


-- proof if call_id match in tables abandonments and calls
SELECT a.call_id
FROM abandonments a
LEFT JOIN calls c ON a.call_id = c.call_id
WHERE c.call_id IS NULL;
-- output 0 = they all have matches