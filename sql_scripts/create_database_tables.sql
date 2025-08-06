DROP DATABASE IF EXISTS call_center; 
CREATE DATABASE IF NOT EXISTS call_center;
USE call_center;

-- departments
CREATE TABLE `departments` (
  `department_id` INT AUTO_INCREMENT PRIMARY KEY,
  `department_name` VARCHAR(255)
);

-- customers
CREATE TABLE `customers` (
  `customer_id` VARCHAR(255) PRIMARY KEY
  );

-- agents
CREATE TABLE `agents` (
	`agent_id` VARCHAR(255) PRIMARY KEY,
    `department_id` VARCHAR(255),
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `agent_type` VARCHAR(255),
    `phone_number` VARCHAR(255),
    `email` VARCHAR(255),
     FOREIGN KEY (`department_id`) REFERENCES `departments`(`department_id`)
);

-- calls
CREATE TABLE `calls` (
	`call_id` VARCHAR(255) PRIMARY KEY,
    `customer_id` VARCHAR(255),
    `agent_id` VARCHAR(255),
    `call_type` VARCHAR(255),
    `call_duration` INT,
    `issue` VARCHAR(255),
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`),
    FOREIGN KEY (`agent_id`) REFERENCES `agents`(`agent_id`)
);

--  abandonment
CREATE TABLE `abandonments` (
    `call_abandonment_id` int NOT NULL AUTO_INCREMENT,
    `customer_id` varchar(255) DEFAULT NULL,
    `call_id` varchar(255) DEFAULT NULL,
    `abandoned` varchar(255) DEFAULT NULL,
    `abandonment_reason` varchar(255) DEFAULT NULL,
    `call_duration` int DEFAULT NULL,
    PRIMARY KEY (`call_abandonment_id`),
    KEY `customer_id` (`customer_id`),
    KEY `call_id` (`call_id`),
    CONSTRAINT `abandonments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
    CONSTRAINT `abandonments_ibfk_2` FOREIGN KEY (`call_id`) REFERENCES `calls` (`call_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- escalations
CREATE TABLE `escalations` (
   `escalation_id` VARCHAR(255) NOT NULL,
   `customer_id` VARCHAR(255) DEFAULT NULL,
   `agent_id` VARCHAR(255) DEFAULT NULL,  
   `department_id` VARCHAR(255) DEFAULT NULL,
   `issue_type` VARCHAR(255) DEFAULT NULL,
   `escalation_reason` VARCHAR(255) DEFAULT NULL,  
   `resolution_status` VARCHAR(255) DEFAULT NULL,
   PRIMARY KEY (`escalation_id`),
   KEY `customer_id` (`customer_id`),  
   CONSTRAINT `escalations_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
);

-- csat: Customer Satisfaction Surveys
CREATE TABLE `csat` (
  `csat_id` VARCHAR(255) PRIMARY KEY,
  `agent_id` VARCHAR(255),
  `customer_id` VARCHAR(255),
  `survey_date` DATE,
  `rating` INT,  
  `comments` TEXT,
  FOREIGN KEY (`agent_id`) REFERENCES `agents`(`agent_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);