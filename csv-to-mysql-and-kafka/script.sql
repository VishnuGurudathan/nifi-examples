CREATE DATABASE IF NOT EXISTS  logger_data_db;
CREATE TABLE IF NOT EXISTS `logger_data_db`.`logger_data` (
  `logger_id` VARCHAR(255) NULL,
  `logger_name` VARCHAR(255) NULL,
  `timestamp` VARCHAR(255) NULL,
  `value` VARCHAR(255) NULL,
  `type` VARCHAR(255) NULL);