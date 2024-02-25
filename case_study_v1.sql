

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

