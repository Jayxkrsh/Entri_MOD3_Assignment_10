CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    subject VARCHAR(50),
    experience INT,
    salary DECIMAL(10, 2)
);

INSERT INTO teachers (id, name, subject, experience, salary)
VALUES 
(1, 'John Doe', 'Math', 5, 50000.00),
(2, 'Jane Smith', 'Science', 8, 55000.00),
(3, 'Mark Lee', 'History', 12, 60000.00),
(4, 'Emily Davis', 'English', 6, 48000.00),
(5, 'David Brown', 'Math', 15, 65000.00),
(6, 'Linda White', 'Science', 4, 47000.00),
(7, 'Robert Clark', 'Geography', 10, 52000.00),
(8, 'Sarah Wilson', 'History', 3, 46000.00);

/*Create a before insert trigger named before_insert_teacher that will raise an error 
“salary cannot be negative” if the salary inserted to the table is less than zero.*/
DELIMITER $$
CREATE TRIGGER Before_insert_teacher
BEFORE INSERT ON Teachers
FOR EACH ROW
BEGIN
IF NEW.salary<0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Employee with salary negative is not allowed";
END IF;
END $$
DELIMITER ;
INSERT INTO teachers (id, name, subject, experience, salary)
VALUES 
(9, 'John David', 'Social Science', 5, -20000);

/* Create an after insert trigger 
named after_insert_teacher that inserts a row with teacher_id,action, 
timestamp to a table called teacher_log when a new entry gets inserted to the teacher table.*/

CREATE TABLE teacher_log (
    teacher_id INT,
    action VARCHAR(50),
    time_stamp  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- trigger 
DELIMITER $$
CREATE  TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO teacher_log (teacher_id, action)
    VALUES (NEW.id, 'INSERT');
END $$
DELIMITER ;

INSERT INTO teachers (id, name, subject, experience, salary)
VALUES 
(11, 'Siri Dan', 'Math', 8, 90000.00);

SELECT * FROM Teachers;
SELECT * FROM Teacher_log;

/* Create a before delete trigger that will raise an error when you try 
to delete a row that has experience greater than 10 years.*/

DELIMITER $$
CREATE TRIGGER before_delete
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN 
IF OLD.Experience>10 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Employee with Experience greater than 10 cant be deleted";
END IF;
END $$
DELIMITER ;

DELETE FROM teachers WHERE Name='Mark Lee';
SET sql_safe_updates=0;

/* Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.*/
DELIMITER $$
CREATE TRIGGER After_delete
AFTER DELETE ON teachers
FOR EACH ROW 
BEGIN
INSERT INTO teacher_log(teacher_id,action) VALUES (OLD.ID,"Deleted entry from teacher");
END $$
DELIMITER :

DELETE FROM Teachers WHERE ID=1;
SELECT * FROM Teacher_log;