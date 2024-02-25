## database management Case Study.


### Schema of the table

```SQL
use case_study;
-- Create the Students table
-- Create the Students table
CREATE TABLE Students (
    uid INT PRIMARY KEY,
    name VARCHAR(100),
    joining_date DATE,
    left_date DATE,
    city VARCHAR(100),
    reasons_to_leave VARCHAR(255)
);

-- Generate and insert 100 records into the Students table
-- Set the delimiter to //
DELIMITER //

-- Create a procedure to generate and insert 100 records
CREATE PROCEDURE Insert100Students()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO
        INSERT INTO Students (uid, name, joining_date, left_date, city, reasons_to_leave)
        VALUES (
            i,
            CONCAT('Student', i),
            DATE_ADD('2022-01-01', INTERVAL FLOOR(RAND() * 100) DAY),
            CASE WHEN RAND() < 0.5 THEN NULL ELSE DATE_ADD('2022-01-01', INTERVAL FLOOR(RAND() * 100) DAY) END,
            CASE WHEN RAND() < 0.5 THEN NULL ELSE CONCAT('City', FLOOR(RAND() * 5) + 1) END,
            CASE WHEN RAND() < 0.5 THEN NULL ELSE CONCAT('Reason', FLOOR(RAND() * 5) + 1) END
        );

        SET i = i + 1;
    END WHILE;
END//

-- Reset the delimiter
DELIMITER ;

TRUNCATE TABLE Students;
DESC Students;


CALL Insert100Students();


SELECT * FROM Students;


```
### OUTPUT

<img width="204" alt="Screenshot 2024-02-25 at 11 25 56 AM" src="https://github.com/PradeepSahhu/DBMS_caseStudy/assets/94203408/fd3f1db7-168c-4fe9-8756-8b76048944b3">



### Code to Generate the analysis of how many students left the university and how many stays and reasons to left

```Python
import mysql.connector as mysql
import matplotlib.pyplot as plt

# Connect to the database
db = mysql.connect(
    host="127.0.0.1",
    user="root",
    passwd="Pradeep@2002",
    database="case_study"
    )

print(db)


import mysql.connector as mysql
import matplotlib.pyplot as plt

# Connect to the database
db = mysql.connect(
    host="127.0.0.1",
    user="root",
    passwd="Pradeep@2002",
    database="case_study"
)

# Query to fetch the count of students who have left the university and their reasons
query_left_students = """
    SELECT 
        IF(left_date IS NULL, 'Not Left', 'Left') AS status,
        CASE 
            WHEN left_date IS NULL THEN NULL
            ELSE reasons_to_leave 
        END AS reason,
        COUNT(*) 
    FROM 
        Students 
    GROUP BY 
        status, reason
"""

# Execute the query
cursor = db.cursor()
cursor.execute(query_left_students)

# Fetch all rows
rows = cursor.fetchall()

# Close cursor and database connection
cursor.close()
db.close()

# Extract data for the pie chart
left_students = {'Not Left': 0, 'Left': 0}
reasons = {}

for row in rows:
    status, reason, count = row
    if status == 'Not Left':
        left_students['Not Left'] += count
    else:
        left_students['Left'] += count
        reasons[reason] = count

# Create pie chart for students who have left versus those who haven't
labels = ['Students Not Left', 'Students Left']
sizes = [left_students['Not Left'], left_students['Left']]
colors = ['lightskyblue', 'lightcoral']

plt.figure(figsize=(10, 6))
plt.subplot(1, 2, 1)
plt.pie(sizes, labels=labels, colors=colors, autopct='%1.1f%%', startangle=140)
plt.legend(labels, loc='upper center', bbox_to_anchor=(0.5, -0.05),fancybox=True, shadow=True, ncol=5)
plt.title('Distribution of Students')

# Create pie chart for reasons of leaving
plt.subplot(1, 2, 2)
reason_labels = reasons.keys()
reason_sizes = reasons.values()
plt.pie(reason_sizes, labels=reason_labels, autopct='%1.1f%%', startangle=140)
plt.title('Reasons for Leaving')

plt.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.
plt.legend(reason_labels, loc='upper center', bbox_to_anchor=(0.5, -0.05),fancybox=True, shadow=True, ncol=5)
plt.tight_layout()
plt.show()

```

### OUTPUT
![data_of_studets_left](https://github.com/PradeepSahhu/DBMS_caseStudy/assets/94203408/77ab0dc0-eac6-42ef-9c8f-5286f03016da)


