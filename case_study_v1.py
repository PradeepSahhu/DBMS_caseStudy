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
