# Design Decisions

## Dataset Preparation
The source dataset (973 rows) was limited to 100 rows for the scope of this project. No null values were present in the subset.

## Entity Design
Four entities were identified from the flat dataset:

- **GYM_MEMBER** -- Encapsulates personal information for each member (age, gender, weight, height, body fat percentage, water intake, experience level).
- **WORKOUT_SESSION** -- The central fact table containing key attributes for understanding workout behavior (session duration, calories burned, workout frequency). Links to GYM_MEMBER and WORKOUT_TYPE via foreign keys.
- **WORKOUT_TYPE** -- Stores the type of workout (Cardio, HIIT, Strength, Yoga). Separated to avoid redundancy and allow new workout types to be added without modifying existing records.
- **HEART_RATE** -- Heart rate metrics (max, average, resting BPM) stored separately for independent analysis. Linked 1:1 with WORKOUT_SESSION.

## Key Design Choices
- **Surrogate keys** (AUTO_INCREMENT integers) were used for all primary keys rather than natural keys, ensuring uniqueness and simplifying joins.
- **BMI was dropped** between the conceptual and logical design phases, as it is a derived attribute (calculable from weight and height) and should not be stored redundantly.
- **Default values** were assigned where meaningful: Experience_Level defaults to 0 (new member), Workout_Frequency defaults to 3 (days/week), and Resting_Bpm defaults to 60.

## Relationships
- GYM_MEMBER 1:M WORKOUT_SESSION -- A member can have multiple workout sessions.
- WORKOUT_TYPE 1:M WORKOUT_SESSION -- A workout type applies to many sessions.
- WORKOUT_SESSION 1:1 HEART_RATE -- Each session has exactly one set of heart rate measurements.
