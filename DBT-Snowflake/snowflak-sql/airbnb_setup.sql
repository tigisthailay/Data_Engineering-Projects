-- Use admin role to create database role, and user
USE ROLE ACCOUNTADMIN;

-- Create for managing the warehouse
CREATE ROLE IF NOT EXISTS TRANSFORMATION;

-- Create the default warehouse if necessary
CREATE WAREHOUSE IF NOT EXISTS SUPERMARKET_WH WITH WAREHOUSE_SIZE='X-SMALL' AUTO_SUSPEND = 600;
GRANT OPERATE ON WAREHOUSE SUPERMARKET_WH TO ROLE TRANSFORMATION;

-- Create the database and schema
CREATE DATABASE IF NOT EXISTS SUPERMARKET;
CREATE SCHEMA IF NOT EXISTS SUPERMARKET.RAW;


-- Set permission to created role
GRANT ALL ON WAREHOUSE SUPERMARKET_WH TO ROLE TRANSFORMATION;
GRANT ALL ON DATABASE SUPERMARKET to ROLE TRANSFORMATION;
GRANT ALL ON ALL SCHEMAS IN DATABASE SUPERMARKET to ROLE TRANSFORMATION;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE SUPERMARKET to ROLE TRANSFORMATION;
GRANT ALL ON ALL TABLES IN SCHEMA SUPERMARKET.RAW to ROLE TRANSFORMATION;
GRANT ALL ON FUTURE TABLES IN SCHEMA SUPERMARKET.RAW to ROLE TRANSFORMATION;

-- Create role and grant transform permissions to role
CREATE USER IF NOT EXISTS data2bot_dbt
  PASSWORD='data2bot_dbt01'
  LOGIN_NAME='data2bot_dbt'
  MUST_CHANGE_PASSWORD=FALSE
  DEFAULT_WAREHOUSE='SUPERMARKET_WH'
  DEFAULT_ROLE='TRANSFORMATION'
  DEFAULT_NAMESPACE='SUPERMARKET.RAW'
  COMMENT='transformation user for dbt';

GRANT ROLE TRANSFORMATION to USER data2bot_dbt;