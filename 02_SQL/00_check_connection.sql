-- Project: WERS Workforce Reward and Satisfaction Analysis
-- File: 00_check_connection.sql
-- Purpose: Confirm active PostgreSQL connection and database context
-- Date: 11 May 2026

SELECT
    current_database() AS database_name,
    current_user AS user_name,
    inet_server_port() AS server_port;