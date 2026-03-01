-- Verification View: Reconstruct the original flat dataset from the star schema
-- Joins all four tables to confirm the normalized design preserves all source data.

CREATE VIEW vw_ALL AS
SELECT
  g.Age AS Age,
  h.Avg_Bpm AS Avg_BPM,
  ws.Calories_Burned AS Calories_Burned,
  g.Experience_Level AS Experience_Level,
  g.Fat_Percent AS Fat_Percentage,
  g.Gender AS Gender,
  g.Height AS `Height (m)`,
  h.Max_Bpm AS Max_BPM,
  h.Resting_Bpm AS Resting_BPM,
  ws.Session_Duration AS `Session_Duration (hours)`,
  g.Water_Intake AS `Water_Intake (liters)`,
  g.Weight AS `Weight (kg)`,
  ws.Workout_Frequency AS `Workout_Frequency (days/week)`,
  wt.Workout_Type AS Workout_Type
FROM WORKOUT_SESSION ws
INNER JOIN GYM_MEMBER g ON ws.Member_ID = g.Member_ID
INNER JOIN HEART_RATE h ON ws.Session_ID = h.Session_ID
INNER JOIN WORKOUT_TYPE wt ON ws.Type_ID = wt.Type_ID;
