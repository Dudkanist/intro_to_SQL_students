DROP VIEW IF EXISTS v_users_activity;
CREATE VIEW v_users_activity AS
SELECT
u.User_ID,
u.First_Name,
u.Last_Name,
COUNT(l.Log_ID) AS Num_Sessions,
COALESCE(SUM(
CASE
WHEN l.Session_Start IS NOT NULL AND l.Session_End IS NOT NULL
THEN (julianday(l.Session_End) - julianday(l.Session_Start)) * 24.0 * 60.0
ELSE 0
END
), 0) AS Total_Session_Time
FROM users u
LEFT JOIN logs l ON u.User_ID = l.User_ID
GROUP BY u.User_ID, u.First_Name, u.Last_Name
ORDER BY Total_Session_Time DESC;
