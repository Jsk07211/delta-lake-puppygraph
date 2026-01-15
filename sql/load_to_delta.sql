CREATE SCHEMA IF NOT EXISTS demo;
USE demo;

-- USERS
CREATE TABLE IF NOT EXISTS demo.Users (
  user_id BIGINT,
  username STRING,
  email STRING,
  phone STRING,
  created_at TIMESTAMP,
  last_login TIMESTAMP,
  account_status STRING,
  authentication_method STRING,
  failed_login_attempts INT
) USING delta;

INSERT INTO demo.Users
SELECT
  user_id, username, email, phone,
  CAST(created_at AS TIMESTAMP),
  CAST(last_login AS TIMESTAMP),
  account_status, authentication_method, failed_login_attempts
FROM parquet.`/parquet_data/Users.parquet`;