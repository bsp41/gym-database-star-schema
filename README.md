# Gym Database: Star Schema Design and ETL

## Overview
Designed and implemented a star schema database from a flat CSV dataset of gym member exercise tracking data. The project progresses from conceptual ER diagram analysis through logical and physical design to a fully implemented MySQL database with an ETL pipeline and analytical queries.

## Schema Design
A denormalized flat file (100 rows, 14 attributes) was decomposed into four normalized tables:

| Table | Role | Key Attributes |
|---|---|---|
| **WORKOUT_SESSION** | Fact table | Session duration, calories burned, workout frequency |
| **GYM_MEMBER** | Dimension | Age, gender, weight, height, body fat %, water intake, experience level |
| **WORKOUT_TYPE** | Dimension | Workout type (Cardio, HIIT, Strength, Yoga) |
| **HEART_RATE** | Dimension | Max BPM, average BPM, resting BPM |

## Repository Structure
```
├── README.md
├── data/
│   ├── gym_members_exercise_tracking.csv   # 100-row subset used in project
│   └── original_dataset.csv                # Full 973-row source dataset
├── diagrams/
│   ├── conceptual_er_diagram.jpg           # Initial ER diagram with entity identification
│   ├── conceptual_diagram.png              # Refined conceptual model with PK/FK notation
│   ├── logical_diagram.png                 # Logical model
│   └── physical_diagram.png               # Physical model (generated from MySQL)
├── sql/
│   ├── 01_create_tables.sql               # DDL: table definitions with keys and constraints
│   ├── 02_etl_load.sql                    # ETL: staged load from flat file into star schema
│   ├── 03_create_views.sql                # View to reconstruct original flat dataset
│   └── 04_analytical_queries.sql          # Five analytical queries with insights
└── docs/
    └── design_decisions.md                # Schema design rationale
```

## How to Run
1. Create a MySQL database
2. Import `data/gym_members_exercise_tracking.csv` into a staging table called `BULK_GYM`
3. Execute SQL scripts in order: `01_create_tables.sql` → `02_etl_load.sql` → `03_create_views.sql` → `04_analytical_queries.sql`

## Key Insights from Analytical Queries
- Cardio burns the most total calories across all sessions
- Workout frequency is similar between male and female members
- More experienced members have longer average session durations
- Cardio is the most popular workout type by session count

## Tools and Acknowledgments
This project used MySQL for database design and implementation. ER diagrams were created using database modeling tools. Claude was used for debugging assistance and text refinement. All design decisions and SQL implementations are my own.
