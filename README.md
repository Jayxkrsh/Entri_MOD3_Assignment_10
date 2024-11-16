**Teacher Management System - SQL Triggers**
This repository contains the SQL code for managing teacher data with built-in triggers for data integrity and logging. The primary functionality includes:

Teacher Table: A table to store teacher information such as ID, name, subject, experience, and salary.
Teacher Log Table: A log table to capture changes to the teacher records, including insert and delete actions, along with timestamps.
**Features**
1. Teacher Table
Stores key information about teachers: ID, name, subject, experience, and salary.
Sample data for 8 teachers is included to demonstrate the functionality.
2. Triggers
Before Insert Trigger (before_insert_teacher): Validates that the salary of a new teacher is not negative before inserting data into the teachers table.
After Insert Trigger (after_insert_teacher): Automatically logs the teacher_id, the action (INSERT), and the timestamp of the insertion into the teacher_log table whenever a new teacher is added.
Before Delete Trigger (before_delete_teacher): Prevents the deletion of teachers with more than 10 years of experience by raising an error.
After Delete Trigger (after_delete_teacher): Logs deletions in the teacher_log table, recording the teacher_id, the action (DELETE), and the timestamp.
3. Teacher Log Table
A separate table that logs all insert and delete actions performed on the teachers table, along with a timestamp of when each action occurred.
