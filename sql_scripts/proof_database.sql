USE call_center;

SELECT * FROM departments LIMIT 10;
SELECT COUNT(*) FROM departments; -- 5

SELECT * FROM customers LIMIT 10;
SELECT COUNT(*) FROM customers; -- 60,000

SELECT * FROM agents LIMIT 10;
SELECT COUNT(*) FROM agents; -- 200

SELECT * FROM calls LIMIT 10;
SELECT COUNT(*) FROM calls; -- 50,000

SELECT * FROM abandonments LIMIT 10; -- recheck
SELECT COUNT(*) FROM abandonments;

SELECT * FROM escalations LIMIT 10;
SELECT COUNT(*) FROM escalations; -- 5,000

SELECT * FROM csat LIMIT 10;
DESCRIBE csat;
SELECT COUNT(*) FROM csat; -- 10,000
SELECT DISTINCT rating FROM csat;
