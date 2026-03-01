-- Analytical Queries: Five queries demonstrating insights from the normalized schema

-- 1. Total calories burned per workout type
--    Result: Cardio > HIIT > Strength > Yoga
SELECT Workout_Type, SUM(Calories_Burned) AS Total_Calories_Burned
FROM vw_ALL
GROUP BY Workout_Type
ORDER BY Total_Calories_Burned DESC;

-- 2. Average workout frequency by gender
--    Result: Very similar between males and females
SELECT Gender, AVG(`Workout_Frequency (days/week)`) AS Avg_Workout_Frequency
FROM vw_ALL
GROUP BY Gender;

-- 3. Average session duration by experience level
--    Result: More experienced members have longer sessions
SELECT Experience_Level, AVG(`Session_Duration (hours)`) AS Avg_Session_Duration
FROM vw_ALL
GROUP BY Experience_Level;

-- 4. Most popular workout types by session count
--    Result: Cardio most popular, followed by Strength, HIIT, Yoga
SELECT wt.Workout_Type, COUNT(ws.Session_ID) AS Number_Of_Sessions
FROM WORKOUT_SESSION ws
INNER JOIN WORKOUT_TYPE wt ON ws.Type_ID = wt.Type_ID
GROUP BY wt.Workout_Type
ORDER BY Number_Of_Sessions DESC;

-- 5. Average session duration by workout type
--    Result: Duration is fairly similar across workout types
SELECT Workout_Type, AVG(`Session_Duration (hours)`) AS Avg_Session_Duration
FROM vw_ALL
GROUP BY Workout_Type
ORDER BY Avg_Session_Duration DESC;
