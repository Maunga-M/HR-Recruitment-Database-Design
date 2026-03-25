CREATE TABLE `departments` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(255) NOT NULL
);

CREATE TABLE `sources` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `source_name` VARCHAR(255) NOT NULL
);

CREATE TABLE `stage_definitions` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `stage_name` VARCHAR(255) NOT NULL,
  `stage_order` INT NOT NULL
);

CREATE TABLE `application_exit_reasons` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(255) NOT NULL,
  `reason_text` VARCHAR(255) NOT NULL
);

CREATE TABLE `decline_reasons` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `reason_text` VARCHAR(255) NOT NULL
);

CREATE TABLE `employees` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `department_id` INT NOT NULL
);

CREATE TABLE `candidates` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255),
  `location` VARCHAR(255) NOT NULL,
  `source_id` INT NOT NULL
);

CREATE TABLE `job_openings` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `role_title` VARCHAR(255) NOT NULL,
  `job_level` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `headcount_needed` INT NOT NULL,
  `priority` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `recruiter_id` INT NOT NULL,
  `hiring_manager_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  `opened_date` DATE NOT NULL,
  `target_start_date` DATE NOT NULL
);

CREATE TABLE `applications` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `applied_at` TIMESTAMP NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `current_stage_id` INT,
  `exit_reason_id` INT,
  `source_id` INT NOT NULL,
  `job_id` INT NOT NULL,
  `candidate_id` INT NOT NULL
);

CREATE TABLE `offers` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `offered_salary` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `sent_at` TIMESTAMP,
  `accepted_at` TIMESTAMP,
  `decline_reason_id` INT,
  `application_id` INT NOT NULL
);

CREATE TABLE `interviews` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `interview_type` VARCHAR(255) NOT NULL,
  `scheduled_start` TIMESTAMP NOT NULL,
  `scheduled_end` TIMESTAMP,
  `status` VARCHAR(255) NOT NULL,
  `application_id` INT NOT NULL,
  `scheduler_id` INT NOT NULL
);

CREATE TABLE `interviewers` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `interview_id` INT NOT NULL
);

CREATE TABLE `feedback` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `submitted_at` TIMESTAMP,
  `decision` VARCHAR(255) NOT NULL,
  `notes` TEXT,
  `is_submitted` BOOLEAN NOT NULL DEFAULT false,
  `interview_id` INT NOT NULL,
  `interviewer_id` INT NOT NULL
);

CREATE TABLE `stage_events` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `changed_at` TIMESTAMP NOT NULL,
  `notes` TEXT,
  `application_id` INT NOT NULL,
  `changed_by` INT NOT NULL,
  `from_stage_id` INT,
  `to_stage_id` INT NOT NULL
);

ALTER TABLE `employees` ADD CONSTRAINT `employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

ALTER TABLE `candidates` ADD CONSTRAINT `candidates_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`);

ALTER TABLE `job_openings` ADD CONSTRAINT `job_openings_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

ALTER TABLE `job_openings` ADD CONSTRAINT `job_openings_recruiter_id_foreign` FOREIGN KEY (`recruiter_id`) REFERENCES `employees` (`id`);

ALTER TABLE `job_openings` ADD CONSTRAINT `job_openings_hiring_manager_id_foreign` FOREIGN KEY (`hiring_manager_id`) REFERENCES `employees` (`id`);

ALTER TABLE `applications` ADD CONSTRAINT `applications_current_stage_id_foreign` FOREIGN KEY (`current_stage_id`) REFERENCES `stage_definitions` (`id`);

ALTER TABLE `applications` ADD CONSTRAINT `applications_exit_reason_id_foreign` FOREIGN KEY (`exit_reason_id`) REFERENCES `application_exit_reasons` (`id`);

ALTER TABLE `applications` ADD CONSTRAINT `applications_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`);

ALTER TABLE `applications` ADD CONSTRAINT `applications_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`);

ALTER TABLE `applications` ADD CONSTRAINT `applications_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `job_openings` (`id`);

ALTER TABLE `offers` ADD CONSTRAINT `offers_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`);

ALTER TABLE `offers` ADD CONSTRAINT `offers_decline_reason_id_foreign` FOREIGN KEY (`decline_reason_id`) REFERENCES `decline_reasons` (`id`);

ALTER TABLE `interviews` ADD CONSTRAINT `interviews_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`);

ALTER TABLE `interviews` ADD CONSTRAINT `interviews_scheduler_id_foreign` FOREIGN KEY (`scheduler_id`) REFERENCES `employees` (`id`);

ALTER TABLE `interviewers` ADD CONSTRAINT `interviewers_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

ALTER TABLE `interviewers` ADD CONSTRAINT `interviewers_interview_id_foreign` FOREIGN KEY (`interview_id`) REFERENCES `interviews` (`id`);

ALTER TABLE `feedback` ADD CONSTRAINT `feedback_interview_id_foreign` FOREIGN KEY (`interview_id`) REFERENCES `interviews` (`id`);

ALTER TABLE `feedback` ADD CONSTRAINT `feedback_interviewer_id_foreign` FOREIGN KEY (`interviewer_id`) REFERENCES `interviewers` (`id`);

ALTER TABLE `stage_events` ADD CONSTRAINT `stage_events_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`);

ALTER TABLE `stage_events` ADD CONSTRAINT `stage_events_changed_by_foreign` FOREIGN KEY (`changed_by`) REFERENCES `employees` (`id`);

ALTER TABLE `stage_events` ADD CONSTRAINT `stage_events_from_stage_id_foreign` FOREIGN KEY (`from_stage_id`) REFERENCES `stage_definitions` (`id`);

ALTER TABLE `stage_events` ADD CONSTRAINT `stage_events_to_stage_id_foreign` FOREIGN KEY (`to_stage_id`) REFERENCES `stage_definitions` (`id`);
