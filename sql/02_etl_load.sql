-- ETL Pipeline: Load data from flat staging table (BULK_GYM) into star schema
-- Assumes BULK_GYM has been populated via CSV import of gym_members_exercise_tracking.csv.
-- Execution order matters: dimension tables first, then fact table, then remaining dimensions.

-- Step 1: Load WORKOUT_TYPE dimension
INSERT INTO WORKOUT_TYPE (Workout_Type)
SELECT DISTINCT Workout_Type FROM BULK_GYM;

-- Resolve Type_ID back to staging table for downstream joins
ALTER TABLE BULK_GYM ADD Type_ID INT;

UPDATE BULK_GYM b, WORKOUT_TYPE w
SET b.Type_ID = w.Type_ID
WHERE b.Workout_Type = w.Workout_Type;

-- Step 2: Load GYM_MEMBER dimension
INSERT INTO GYM_MEMBER (Age, Gender, Weight, Height, Fat_Percent, Water_Intake, Experience_Level)
SELECT DISTINCT Age, Gender, `Weight (kg)`, `Height (m)`, Fat_Percentage,
       `Water_Intake (liters)`, Experience_Level
FROM BULK_GYM;

-- Resolve Member_ID back to staging table
ALTER TABLE BULK_GYM ADD Member_ID INT;

UPDATE BULK_GYM b, GYM_MEMBER g
SET b.Member_ID = g.Member_ID
WHERE b.Age = g.Age
  AND b.Gender = g.Gender
  AND b.`Weight (kg)` = g.Weight
  AND b.`Height (m)` = g.Height
  AND b.Fat_Percentage = g.Fat_Percent
  AND b.`Water_Intake (liters)` = g.Water_Intake
  AND b.Experience_Level = g.Experience_Level;

-- Step 3: Load WORKOUT_SESSION fact table
INSERT INTO WORKOUT_SESSION (Member_ID, Type_ID, Session_Duration, Calories_Burned, Workout_Frequency)
SELECT DISTINCT Member_ID, Type_ID, `Session_Duration (hours)`, Calories_Burned,
       `Workout_Frequency (days/week)`
FROM BULK_GYM;

-- Resolve Session_ID back to staging table
ALTER TABLE BULK_GYM ADD Session_ID INT;

UPDATE BULK_GYM b, WORKOUT_SESSION ws
SET b.Session_ID = ws.Session_ID
WHERE b.Member_ID = ws.Member_ID;

-- Step 4: Load HEART_RATE dimension
INSERT INTO HEART_RATE (Session_ID, Max_Bpm, Avg_Bpm, Resting_Bpm)
SELECT DISTINCT Session_ID, Max_BPM, Avg_BPM, Resting_BPM
FROM BULK_GYM;
