/*
Multi Line Comment

SQL Server Basics

SQL Syntax
- UPPERCASE - T-SQL Keyword
	- SELECT, UPDATE, DELETE, WHERE
	- Uppercase is not required
- italics = user defined parameter
- bold = Database object
- [] = Allows us to use spaces and special characters ([Movie Title])
- ; to end line

Fully Qualified Name
[server].[database].[schema].[table]

*/

-- Single Line Comment

--SELECT * FROM MSreplication_options;

--Batch Operations
-- End of the batch: GO
-- DDL - Create Tables
-- Employees and Departments - What would happen if Employees table got created first? Wouldn't Work!
/*
CREATE Departments;
GO

CREATE Employees;
GO
*/

-- sqlcmd -S localhost to run from command line
--This does not define different transactions, this is for scripting purposes.


/*
Other ways to interact with server

CLI -sqlcmd
Programmatically with a Programming Language

JDBC

We can use Python with the pymssql library
*/

-- DML/CRUD Application
-- DML = Changing, updating data

/*
Database Operations
- DDL
	-CREATE/ALTER/DROP tables/views/sequences
- DML
	-INSERT/SELECT/DELETE/UPDATE
- TCL
	-COMMIT/ROLLBACK/ BEGIN TRAN
	-Default: Auto-Commit

*/

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

/*
CRUD

CREATE -- INSERT INTO
READ - SELECT
UPDATE - UPDATE
DELETE - DELETE

*/

CREATE DATABASE demo;

use demo;

--CREATE TABLE creates a table
-- By default it will be put in dbo schema
-- We can put it into a different Schema, but we will have to create the Schema first


CREATE TABLE users (
    user_id int PRIMARY KEY IDENTITY,  -- Identity is a surrogate key. Starts at 1 and counts up
    user_first_name VARCHAR(30) NOT NULL,
    user_last_name VARCHAR(30) NOT NULL,
    user_email_id VARCHAR(50) NOT NULL,
    user_email_validated bit DEFAULT 0,
    user_password VARCHAR(200),
    user_role VARCHAR(30) NOT NULL DEFAULT 'U',
    is_active bit DEFAULT 0,
    last_updated_ts DATETIME DEFAULT getdate()
);

-- Typically our applications will not DDL, we willc onnect to already established dbs
--CRUD

-- (C)REATE INSERT
-- Syntax: INSERT INTO <table> (col1, col2, col3) VALUES ( val1, val2, val3)
INSERT INTO users ( user_first_name, user_last_name, user_email_id)
VALUES ('Scott', 'Tiger', 'scott@tiger.com');

SELECT * FROM users;

INSERT INTO users
    (user_first_name, user_last_name, user_email_id, user_password, user_role, is_active)
VALUES
    ('Sora', 'Hearts', 'keyblade@master.com', '019he221', 'U', 1),
    ('Minnie', 'Mouse', 'minnie@mouse.com', 'fhuih1234', 'U', 1),
    ('Max', 'Goof', 'max@goof.com', 'j4892hyf1', 'U', 1);

SELECT * FROM users;