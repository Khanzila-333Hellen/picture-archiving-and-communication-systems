-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 07, 2026 at 03:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `picture_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_control`
--

CREATE TABLE `access_control` (
  `access_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `permission_type` enum('Read','Write','Delete','Export','Share','View','Approve','Verify','Cancel','Archive','Restore','Edit','Assign','Schedule','Modify') NOT NULL,
  `resource_type` enum('Patient','Study','Series','Image','Report','Order','Appointment','Equipment','Department','User','Modality','Audit','Archive','DiagnosticCode','ClinicalIndication','Template','Finding','Annotation') NOT NULL,
  `resource_id` int(11) DEFAULT NULL COMMENT 'NULL means applies to all resources of this type',
  `scope` enum('All','Department','Facility','Specific') DEFAULT 'All',
  `department_id` int(11) DEFAULT NULL,
  `is_granted` tinyint(1) DEFAULT 1 COMMENT '1=Granted, 0=Denied',
  `granted_by` int(11) DEFAULT NULL,
  `granted_at` datetime DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `access_control`
--

INSERT INTO `access_control` (`access_id`, `user_id`, `role_id`, `permission_type`, `resource_type`, `resource_id`, `scope`, `department_id`, `is_granted`, `granted_by`, `granted_at`, `expires_at`, `reason`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 'Read', 'Patient', 1, 'Specific', NULL, 1, 1, '2026-09-07 09:09:32', NULL, 'Cardiology consult access', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(2, 2, 2, 'Read', 'Study', 1, 'Specific', NULL, 1, 1, '2026-09-07 09:09:32', NULL, 'Cardiology study access', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(3, 3, 3, 'Approve', 'Report', NULL, 'Department', 1, 1, 1, '2026-09-07 09:09:32', NULL, 'Department report approval', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(4, 6, 5, 'Read', 'Patient', NULL, 'Department', 2, 1, 1, '2026-09-07 09:09:32', NULL, 'Cardiology department access', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(5, 4, 4, 'Write', 'Equipment', NULL, 'Department', 1, 1, 1, '2026-09-07 09:09:32', NULL, 'Equipment management', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(6, 10, 7, 'Read', 'Patient', NULL, 'All', NULL, 1, 1, '2026-09-07 09:09:32', NULL, 'Medical records access', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32'),
(7, 10, 7, 'Write', 'Patient', NULL, 'All', NULL, 1, 1, '2026-09-07 09:09:32', NULL, 'Medical records update access', 1, '2026-09-07 09:09:32', '2026-09-07 06:09:32');

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `admin_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'References users table',
  `admin_level` enum('Super Admin','System Admin','Department Admin','Modality Admin','Clinical Admin','Billing Admin','Audit Admin','Report Admin') NOT NULL DEFAULT 'System Admin',
  `permission_level` int(11) DEFAULT 100 COMMENT '1-100: Higher number = more permissions',
  `can_manage_users` tinyint(1) DEFAULT 0,
  `can_manage_roles` tinyint(1) DEFAULT 0,
  `can_manage_system_settings` tinyint(1) DEFAULT 0,
  `can_manage_departments` tinyint(1) DEFAULT 0,
  `can_manage_modalities` tinyint(1) DEFAULT 0,
  `can_manage_equipment` tinyint(1) DEFAULT 0,
  `can_manage_clinical_codes` tinyint(1) DEFAULT 0,
  `can_manage_report_templates` tinyint(1) DEFAULT 0,
  `can_view_audit_logs` tinyint(1) DEFAULT 0,
  `can_manage_backups` tinyint(1) DEFAULT 0,
  `can_manage_storage` tinyint(1) DEFAULT 0,
  `can_manage_billing` tinyint(1) DEFAULT 0,
  `can_override_security` tinyint(1) DEFAULT 0,
  `admin_department_id` int(11) DEFAULT NULL COMMENT 'Department admin for specific department',
  `restricted_to_facility` varchar(100) DEFAULT NULL,
  `two_factor_auth_enabled` tinyint(1) DEFAULT 0,
  `admin_notes` text DEFAULT NULL,
  `last_admin_action` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` (`admin_id`, `user_id`, `admin_level`, `permission_level`, `can_manage_users`, `can_manage_roles`, `can_manage_system_settings`, `can_manage_departments`, `can_manage_modalities`, `can_manage_equipment`, `can_manage_clinical_codes`, `can_manage_report_templates`, `can_view_audit_logs`, `can_manage_backups`, `can_manage_storage`, `can_manage_billing`, `can_override_security`, `admin_department_id`, `restricted_to_facility`, `two_factor_auth_enabled`, `admin_notes`, `last_admin_action`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Super Admin', 100, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, 1, 'Super Administrator with full system access', NULL, 1, '2026-09-07 09:17:39', '2026-09-07 06:17:39'),
(2, 2, 'Report Admin', 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, NULL, NULL, 0, 'Radiologist with administrative privileges for reports', NULL, 1, '2026-09-07 09:17:39', '2026-09-07 06:17:39'),
(3, 10, 'Audit Admin', 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, NULL, 0, 'Medical Records staff with audit access', NULL, 1, '2026-09-07 09:17:39', '2026-09-07 06:17:39');

-- --------------------------------------------------------

--
-- Table structure for table `admin_audit_trail`
--

CREATE TABLE `admin_audit_trail` (
  `audit_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action_type` enum('Login','Logout','User_Create','User_Update','User_Delete','Role_Create','Role_Update','Role_Delete','Permission_Change','System_Settings','Department_Manage','Modality_Manage','Equipment_Manage','Backup','Restore','Security_Override','Audit_View','Report_Export','Template_Manage','Archive_Manage','Billing_Manage') NOT NULL,
  `action_description` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `affected_user_id` int(11) DEFAULT NULL,
  `affected_resource` varchar(100) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `is_successful` tinyint(1) DEFAULT 1,
  `error_message` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_audit_trail`
--

INSERT INTO `admin_audit_trail` (`audit_id`, `admin_id`, `action_type`, `action_description`, `ip_address`, `user_agent`, `affected_user_id`, `affected_resource`, `old_value`, `new_value`, `is_successful`, `error_message`, `created_at`) VALUES
(1, 1, 'Login', 'Super Admin login from main console', '192.168.1.1', 'Chrome/120.0', 1, 'User ID: 1', NULL, NULL, 1, NULL, '2026-01-10 08:00:00'),
(2, 1, 'User_Create', 'Created new user account for Radiologist', '192.168.1.1', 'Chrome/120.0', 2, 'User ID: 2', NULL, NULL, 1, NULL, '2026-01-10 09:00:00'),
(3, 1, 'Role_Create', 'Created new role: Senior Radiologist', '192.168.1.1', 'Chrome/120.0', NULL, 'Role ID: 3', NULL, NULL, 1, NULL, '2026-01-10 09:30:00'),
(4, 1, 'Permission_Change', 'Modified permissions for Technologist role', '192.168.1.1', 'Chrome/120.0', NULL, 'Role ID: 4', NULL, NULL, 1, NULL, '2026-01-10 10:00:00'),
(5, 2, 'Login', 'Report Admin login', '192.168.1.100', 'Chrome/120.0', 2, 'User ID: 2', NULL, NULL, 1, NULL, '2026-01-12 08:30:00'),
(6, 2, 'Report_Export', 'Exported radiology report for patient Alice Mwangi', '192.168.1.100', 'Chrome/120.0', NULL, 'Report ID: 1', NULL, NULL, 1, NULL, '2026-01-12 14:00:00'),
(7, 1, 'System_Settings', 'Updated system security settings - enabled 2FA', '192.168.1.1', 'Chrome/120.0', NULL, 'Security Settings', NULL, NULL, 1, NULL, '2026-01-13 11:00:00'),
(8, 1, 'Backup', 'Started full system backup', '192.168.1.1', 'Chrome/120.0', NULL, 'Backup ID: 1', NULL, NULL, 1, NULL, '2026-01-14 02:00:00'),
(9, 3, 'Login', 'Audit Admin login', '192.168.1.104', 'Firefox/121.0', 10, 'User ID: 10', NULL, NULL, 1, NULL, '2026-01-15 08:00:00'),
(10, 3, 'Audit_View', 'Viewed audit logs for January 2026', '192.168.1.104', 'Firefox/121.0', NULL, 'Audit Period: Jan 2026', NULL, NULL, 1, NULL, '2026-01-15 09:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `admin_sessions`
--

CREATE TABLE `admin_sessions` (
  `session_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT current_timestamp(),
  `last_activity` datetime DEFAULT current_timestamp(),
  `logout_time` datetime DEFAULT NULL,
  `session_status` enum('Active','Expired','Terminated','Logged Out') DEFAULT 'Active',
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_sessions`
--

INSERT INTO `admin_sessions` (`session_id`, `admin_id`, `session_token`, `ip_address`, `user_agent`, `login_time`, `last_activity`, `logout_time`, `session_status`, `is_active`) VALUES
(1, 1, 'admin_token_super_20260110', '192.168.1.1', 'Chrome/120.0', '2026-01-10 08:00:00', '2026-01-10 17:00:00', NULL, 'Active', 1),
(2, 2, 'admin_token_report_20260112', '192.168.1.100', 'Chrome/120.0', '2026-01-12 08:30:00', '2026-01-12 16:00:00', NULL, 'Active', 1),
(3, 3, 'admin_token_audit_20260115', '192.168.1.104', 'Firefox/121.0', '2026-01-15 08:00:00', '2026-01-15 17:30:00', NULL, 'Logged Out', 1);

-- --------------------------------------------------------

--
-- Table structure for table `appointment_scheduling`
--

CREATE TABLE `appointment_scheduling` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `study_id` int(11) DEFAULT NULL,
  `modality_id` int(11) NOT NULL,
  `radiologist_id` int(11) DEFAULT NULL,
  `technician_id` int(11) DEFAULT NULL,
  `appointment_date` datetime NOT NULL,
  `appointment_duration` int(11) DEFAULT 30,
  `appointment_type` enum('Screening','Diagnostic','Follow-up','Interventional','Emergency') NOT NULL,
  `priority` enum('Low','Medium','High','Emergency') DEFAULT 'Medium',
  `status` enum('Scheduled','Confirmed','In Progress','Completed','Cancelled','No Show','Rescheduled') DEFAULT 'Scheduled',
  `preparation_instructions` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `canceled_by` int(11) DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `reminder_sent` tinyint(1) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_scheduling`
--

INSERT INTO `appointment_scheduling` (`appointment_id`, `patient_id`, `order_id`, `study_id`, `modality_id`, `radiologist_id`, `technician_id`, `appointment_date`, `appointment_duration`, `appointment_type`, `priority`, `status`, `preparation_instructions`, `notes`, `canceled_by`, `cancellation_reason`, `reminder_sent`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 2, 4, '2026-01-11 09:00:00', 45, 'Diagnostic', 'High', 'Completed', 'NPO for 4 hours. No caffeine.', 'Patient arrived 15 minutes early', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(2, 2, 2, 2, 2, 3, 5, '2026-01-14 10:00:00', 60, 'Diagnostic', 'Medium', 'Completed', 'No metal objects. No contrast required.', 'Patient anxious, needs reassurance', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(3, 3, 3, 3, 1, 2, 4, '2026-01-15 11:00:00', 30, 'Emergency', 'Emergency', 'Completed', 'None - emergency procedure', 'Trauma patient, unstable', NULL, NULL, 0, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(4, 4, 4, 4, 2, 3, 5, '2026-01-20 14:00:00', 45, 'Diagnostic', 'Medium', 'Completed', 'No metal objects. Patient can eat normally.', 'Patient has claustrophobia - needs sedation', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(5, 5, 5, 5, 6, 2, 4, '2026-01-22 08:00:00', 30, 'Screening', 'Low', 'Completed', 'No deodorant or powder on day of exam.', 'First mammogram - patient nervous', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(6, 6, 6, 6, 4, NULL, 5, '2026-01-23 09:00:00', 30, 'Diagnostic', 'High', 'In Progress', 'NPO for 6 hours. Full bladder required.', 'Patient has RUQ pain', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(7, 7, 7, 7, 2, 3, 5, '2026-01-27 11:00:00', 60, 'Follow-up', 'Medium', 'Scheduled', 'No metal objects. Sedation available if needed.', 'Post-stroke follow-up', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(8, 8, 8, 8, 2, 3, 5, '2026-01-30 15:00:00', 45, 'Diagnostic', 'Low', 'Completed', 'No metal objects. Rest knee before exam.', 'Sports injury', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(9, 9, 9, 9, 1, 2, 4, '2026-02-01 11:30:00', 30, 'Emergency', 'Emergency', 'In Progress', 'None - emergency', 'Patient in ER with severe headache', NULL, NULL, 0, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47'),
(10, 10, 10, 10, 1, 2, 4, '2026-02-05 09:00:00', 45, 'Diagnostic', 'High', 'Scheduled', 'NPO for 4 hours. Hold metformin for 48 hours.', 'Suspected lung mass', NULL, NULL, 1, 1, '2026-09-07 08:57:47', '2026-09-07 05:57:47');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `study_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `action_type` enum('View','Create','Update','Delete','Export','Print','Share','Archive','Restore','Login','Logout','Download') NOT NULL,
  `action_description` text DEFAULT NULL,
  `action_date` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `affected_resource` varchar(100) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `is_successful` tinyint(1) DEFAULT 1,
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `user_id`, `patient_id`, `study_id`, `image_id`, `action_type`, `action_description`, `action_date`, `ip_address`, `user_agent`, `affected_resource`, `old_value`, `new_value`, `is_successful`, `error_message`) VALUES
(1, 2, 1, 1, NULL, 'View', 'Radiologist viewed study CT Chest', '2026-01-12 10:00:00', '192.168.1.100', 'Chrome/120.0', 'Study ID: 1', NULL, NULL, 1, NULL),
(2, 2, 1, NULL, 3, 'View', 'Radiologist viewed image CT_003', '2026-01-12 10:15:00', '192.168.1.100', 'Chrome/120.0', 'Image ID: 3', NULL, NULL, 1, NULL),
(3, 2, 1, 1, NULL, 'Create', 'Radiologist created report for CT Chest', '2026-01-12 10:30:00', '192.168.1.100', 'Chrome/120.0', 'Report ID: 1', NULL, NULL, 1, NULL),
(4, 3, 2, 2, NULL, 'View', 'Radiologist viewed MRI Brain study', '2026-01-15 09:00:00', '192.168.1.101', 'Firefox/121.0', 'Study ID: 2', NULL, NULL, 1, NULL),
(5, 3, 2, 2, NULL, 'Create', 'Radiologist created report for MRI Brain', '2026-01-15 09:30:00', '192.168.1.101', 'Firefox/121.0', 'Report ID: 2', NULL, NULL, 1, NULL),
(6, 2, 3, 3, NULL, 'View', 'Radiologist viewed CT Trauma study', '2026-01-16 14:00:00', '192.168.1.100', 'Chrome/120.0', 'Study ID: 3', NULL, NULL, 1, NULL),
(7, 2, 3, 3, NULL, 'Create', 'Radiologist created report for CT Trauma', '2026-01-16 14:30:00', '192.168.1.100', 'Chrome/120.0', 'Report ID: 3', NULL, NULL, 1, NULL),
(8, 4, 1, 1, NULL, 'Login', 'Technologist logged in', '2026-01-11 08:30:00', '192.168.1.102', 'Edge/120.0', 'User ID: 4', NULL, NULL, 1, NULL),
(9, 4, 1, 1, NULL, 'Download', 'Technologist downloaded study for review', '2026-01-11 09:00:00', '192.168.1.102', 'Edge/120.0', 'Study ID: 1', NULL, NULL, 1, NULL),
(10, 1, NULL, NULL, NULL, 'Login', 'System Admin login', '2026-01-10 08:00:00', '192.168.1.1', 'Chrome/120.0', 'User ID: 1', NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `backup_history`
--

CREATE TABLE `backup_history` (
  `backup_id` int(11) NOT NULL,
  `backup_name` varchar(200) NOT NULL,
  `backup_type` enum('Full','Incremental','Differential','Schema_Only','Data_Only') NOT NULL,
  `backup_location` varchar(500) NOT NULL,
  `backup_size` bigint(20) DEFAULT NULL,
  `backup_status` enum('Started','In Progress','Completed','Failed','Verified','Restored') DEFAULT 'Started',
  `start_time` datetime DEFAULT current_timestamp(),
  `end_time` datetime DEFAULT NULL,
  `initiated_by` int(11) DEFAULT NULL,
  `is_compressed` tinyint(1) DEFAULT 1,
  `is_encrypted` tinyint(1) DEFAULT 1,
  `checksum` varchar(64) DEFAULT NULL,
  `restore_date` datetime DEFAULT NULL,
  `restored_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_history`
--

INSERT INTO `backup_history` (`backup_id`, `backup_name`, `backup_type`, `backup_location`, `backup_size`, `backup_status`, `start_time`, `end_time`, `initiated_by`, `is_compressed`, `is_encrypted`, `checksum`, `restore_date`, `restored_by`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Full_Backup_20260114_0200', 'Full', '/backups/pacs/full_2026-01-14.sql.gz', 2147483648, 'Completed', '2026-01-14 02:00:00', '2026-01-14 04:30:00', 1, 1, 1, 'a1b2c3d4e5f6g7h8', NULL, NULL, 'Weekly full backup', '2026-01-14 02:00:00', '2026-09-07 06:21:51'),
(2, 'Incremental_Backup_20260115_0200', 'Incremental', '/backups/pacs/incr_2026-01-15.sql.gz', 524288000, 'Completed', '2026-01-15 02:00:00', '2026-01-15 03:00:00', 1, 1, 1, 'b2c3d4e5f6g7h8i9', NULL, NULL, 'Daily incremental backup', '2026-01-15 02:00:00', '2026-09-07 06:21:51'),
(3, 'Incremental_Backup_20260116_0200', 'Incremental', '/backups/pacs/incr_2026-01-16.sql.gz', 482344960, 'Completed', '2026-01-16 02:00:00', '2026-01-16 02:55:00', 1, 1, 1, 'c3d4e5f6g7h8i9j0', NULL, NULL, 'Daily incremental backup', '2026-01-16 02:00:00', '2026-09-07 06:21:51'),
(4, 'Schema_Backup_20260117_0300', 'Schema_Only', '/backups/pacs/schema_2026-01-17.sql.gz', 10485760, 'Completed', '2026-01-17 03:00:00', '2026-01-17 03:15:00', 1, 1, 1, 'd4e5f6g7h8i9j0k1', NULL, NULL, 'Weekly schema backup', '2026-01-17 03:00:00', '2026-09-07 06:21:51');

-- --------------------------------------------------------

--
-- Table structure for table `clinical_indications`
--

CREATE TABLE `clinical_indications` (
  `indication_id` int(11) NOT NULL,
  `indication_code` varchar(50) NOT NULL,
  `indication_name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `icd10_code` varchar(20) DEFAULT NULL,
  `snomed_ct_code` varchar(50) DEFAULT NULL,
  `modality_recommended` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clinical_indications`
--

INSERT INTO `clinical_indications` (`indication_id`, `indication_code`, `indication_name`, `description`, `icd10_code`, `snomed_ct_code`, `modality_recommended`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'CHEST-PAIN', 'Chest Pain - Suspected Cardiac', 'Patient presenting with chest pain, possible cardiac origin', 'I20.9', '29857009', 'CT, X-Ray', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(2, 'HEADACHE', 'Severe Headache - Rule Out Mass', 'Chronic severe headaches, rule out intracranial mass', 'R51', '25064002', 'MRI, CT', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(3, 'TRAUMA-CHEST', 'Chest Trauma', 'Blunt or penetrating chest trauma', 'S20.9', '127278001', 'X-Ray, CT', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(4, 'ABDOMINAL-PAIN', 'Abdominal Pain', 'Acute or chronic abdominal pain', 'R10.9', '21522001', 'CT, US', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(5, 'JOINT-PAIN', 'Joint Pain - Suspected Arthritis', 'Joint pain with suspected degenerative or inflammatory arthritis', 'M25.50', '29805009', 'X-Ray, MRI', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(6, 'SUSPECTED-STROKE', 'Suspected Cerebrovascular Accident', 'Sudden neurological deficit, rule out stroke', 'I63.9', '129305000', 'CT, MRI', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(7, 'LOW-BACK-PAIN', 'Low Back Pain', 'Chronic low back pain, suspected disc pathology', 'M54.5', '279039007', 'MRI, CT', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57'),
(8, 'BREAST-LUMP', 'Breast Lump', 'Palpable breast lump, screening', 'N63', '266065002', 'MG, US', 1, 1, '2026-09-07 08:31:57', '2026-09-07 05:31:57');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `department_code` varchar(20) NOT NULL,
  `department_password_hash` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `head_of_department` int(11) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `department_name`, `department_code`, `description`, `head_of_department`, `phone_number`, `location`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Radiology', 'RAD', 'Department of Radiology and Medical Imaging', NULL, '+254-700-111111', 'Main Hospital, 3rd Floor', 1, NULL, '2026-09-07 08:22:44', '2026-09-07 05:22:44'),
(2, 'Cardiology', 'CAR', 'Department of Cardiology', NULL, '+254-700-111222', 'Main Hospital, 2nd Floor', 1, NULL, '2026-09-07 08:22:44', '2026-09-07 05:22:44'),
(3, 'Neurology', 'NEU', 'Department of Neurology', NULL, '+254-700-111333', 'Main Hospital, 4th Floor', 1, NULL, '2026-09-07 08:22:44', '2026-09-07 05:22:44'),
(4, 'Orthopedics', 'ORT', 'Department of Orthopedics', NULL, '+254-700-111444', 'Main Hospital, 1st Floor', 1, NULL, '2026-09-07 08:22:44', '2026-09-07 05:22:44'),
(5, 'Emergency Medicine', 'EMR', 'Emergency Medicine Department', NULL, '+254-700-111555', 'Main Hospital, Ground Floor', 1, NULL, '2026-09-07 08:22:44', '2026-09-07 05:22:44');

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic_codes`
--

CREATE TABLE `diagnostic_codes` (
  `code_id` int(11) NOT NULL,
  `code_type` enum('ICD-10','SNOMED CT','LOINC','RadLex','DICOM','DRG') NOT NULL,
  `code_value` varchar(50) NOT NULL,
  `code_description` text NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `sub_category` varchar(100) DEFAULT NULL,
  `modality_association` varchar(100) DEFAULT NULL,
  `body_part_association` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `diagnostic_codes`
--

INSERT INTO `diagnostic_codes` (`code_id`, `code_type`, `code_value`, `code_description`, `category`, `sub_category`, `modality_association`, `body_part_association`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'ICD-10', 'I20.9', 'Angina pectoris, unspecified', 'Cardiovascular', 'Ischemic Heart Disease', 'CT', 'Chest', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(2, 'ICD-10', 'R51', 'Headache', 'Neurological', 'Pain', 'MRI', 'Brain', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(3, 'ICD-10', 'S22.4', 'Multiple fractures of ribs', 'Trauma', 'Fractures', 'CT', 'Chest', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(4, 'ICD-10', 'M51.2', 'Other specified intervertebral disc displacement', 'Orthopedic', 'Spine', 'MRI', 'Lumbar Spine', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(5, 'ICD-10', 'M54.5', 'Low back pain', 'Orthopedic', 'Pain', 'MRI', 'Lumbar Spine', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(6, 'ICD-10', 'M23.2', 'Derangement of meniscus due to old tear or injury', 'Orthopedic', 'Knee', 'MRI', 'Left Knee', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(7, 'SNOMED CT', '29857009', 'Chest pain', 'Symptoms', 'Cardiovascular', 'CT', 'Chest', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(8, 'SNOMED CT', '25064002', 'Headache', 'Symptoms', 'Neurological', 'MRI', 'Brain', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(9, 'SNOMED CT', '127278001', 'Blunt chest injury', 'Trauma', 'Injury', 'CT', 'Chest', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22'),
(10, 'SNOMED CT', '266065002', 'Breast lump', 'Symptoms', 'Breast', 'MG', 'Breast', 1, 1, '2026-09-07 08:56:22', '2026-09-07 05:56:22');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL,
  `equipment_name` varchar(100) NOT NULL,
  `equipment_code` varchar(50) NOT NULL,
  `modality_id` int(11) NOT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `acquisition_date` date DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `status` enum('Operational','Under Maintenance','Out of Service','Retired') DEFAULT 'Operational',
  `maintenance_schedule` date DEFAULT NULL,
  `software_version` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`equipment_id`, `equipment_name`, `equipment_code`, `modality_id`, `manufacturer`, `model`, `serial_number`, `acquisition_date`, `location`, `status`, `maintenance_schedule`, `software_version`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'CT Scanner Room 1', 'CT-ROOM-1', 1, 'GE Healthcare', 'Revolution CT', 'SN-CT-001-2023', '2023-01-15', 'Radiology Dept, Room 101', 'Operational', '2026-03-15', 'v3.2.1', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49'),
(2, 'MRI Scanner Room 2', 'MRI-ROOM-2', 2, 'Siemens', 'MAGNETOM Vida', 'SN-MRI-002-2023', '2023-03-20', 'Radiology Dept, Room 102', 'Operational', '2026-04-20', 'v2.5.0', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49'),
(3, 'X-Ray Room 3', 'XR-ROOM-3', 3, 'Philips', 'DigitalDiagnost', 'SN-XR-003-2022', '2022-11-10', 'Radiology Dept, Room 103', 'Operational', '2026-02-10', 'v4.1.0', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49'),
(4, 'Ultrasound Suite', 'US-SUITE', 4, 'GE Healthcare', 'Voluson E10', 'SN-US-004-2023', '2023-06-01', 'Radiology Dept, Room 104', 'Operational', '2026-05-01', 'v5.0.0', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49'),
(5, 'PET Scanner', 'PET-SCANNER', 5, 'Siemens', 'Biograph Vision', 'SN-PET-005-2023', '2023-08-15', 'Nuclear Medicine, Room 201', 'Under Maintenance', '2026-06-15', 'v3.1.0', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49'),
(6, 'Mammography Suite', 'MG-SUITE', 6, 'Hologic', 'Selenia Dimensions', 'SN-MG-006-2023', '2023-09-01', 'Women\'s Health, Room 301', 'Operational', '2026-07-01', 'v2.3.0', 1, '2026-09-07 08:30:49', '2026-09-07 05:30:49');

-- --------------------------------------------------------

--
-- Table structure for table `findings`
--

CREATE TABLE `findings` (
  `finding_id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `finding_code` varchar(50) DEFAULT NULL,
  `finding_description` text NOT NULL,
  `finding_category` varchar(100) DEFAULT NULL,
  `severity` enum('Normal','Minor','Moderate','Severe','Critical') NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `laterality` enum('Left','Right','Bilateral','Unspecified') DEFAULT NULL,
  `size_cm` decimal(10,2) DEFAULT NULL,
  `attenuation` varchar(50) DEFAULT NULL,
  `enhancement` varchar(50) DEFAULT NULL,
  `calcification` tinyint(1) DEFAULT 0,
  `is_positive` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `findings`
--

INSERT INTO `findings` (`finding_id`, `report_id`, `finding_code`, `finding_description`, `finding_category`, `severity`, `location`, `laterality`, `size_cm`, `attenuation`, `enhancement`, `calcification`, `is_positive`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'FIND-001', 'Mild coronary artery calcification', 'Cardiovascular', 'Minor', 'Heart', 'Unspecified', 0.50, 'Calcified', 'None', 1, 1, 2, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(2, 1, 'FIND-002', 'No significant stenosis identified', 'Cardiovascular', 'Normal', 'Heart', 'Unspecified', NULL, 'Normal', 'Normal', 0, 0, 2, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(3, 3, 'FIND-003', 'Multiple right-sided rib fractures (ribs 4-7)', 'Trauma', 'Moderate', 'Chest', 'Right', NULL, 'Fracture', 'Bone healing', 0, 1, 2, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(4, 3, 'FIND-004', 'Right pleural effusion, mild', 'Respiratory', 'Minor', 'Chest', 'Right', NULL, 'Fluid', 'None', 0, 1, 2, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(5, 3, 'FIND-005', 'Lung contusion right lower lobe', 'Respiratory', 'Moderate', 'Lung', 'Right', 2.00, 'Hematoma', 'Patchy', 0, 1, 2, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(6, 4, 'FIND-006', 'L4-L5 disc herniation with mild central canal stenosis', 'Spinal', 'Moderate', 'Lumbar Spine', 'Unspecified', 0.80, 'Herniated disc', 'None', 0, 1, 3, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(7, 4, 'FIND-007', 'L5-S1 mild disc bulging', 'Spinal', 'Minor', 'Lumbar Spine', 'Unspecified', 0.30, 'Bulging disc', 'None', 0, 1, 3, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(8, 6, 'FIND-008', 'Intrasubstance tear of the medial meniscus', 'Orthopedic', 'Moderate', 'Left Knee', 'Left', 0.50, 'Tear', 'None', 0, 1, 3, '2026-09-07 08:55:31', '2026-09-07 05:55:31'),
(9, 6, 'FIND-009', 'Mild joint effusion', 'Orthopedic', 'Minor', 'Left Knee', 'Left', NULL, 'Fluid', 'None', 0, 1, 3, '2026-09-07 08:55:31', '2026-09-07 05:55:31');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `sop_instance_uid` varchar(100) NOT NULL,
  `series_id` int(11) NOT NULL,
  `image_number` int(11) NOT NULL,
  `image_description` varchar(200) DEFAULT NULL,
  `image_date` datetime DEFAULT NULL,
  `image_time` time DEFAULT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_hash` varchar(64) DEFAULT NULL,
  `image_width` int(11) DEFAULT NULL,
  `image_height` int(11) DEFAULT NULL,
  `bits_allocated` int(11) DEFAULT NULL,
  `bits_stored` int(11) DEFAULT NULL,
  `pixel_spacing` decimal(10,4) DEFAULT NULL,
  `slice_location` decimal(10,2) DEFAULT NULL,
  `image_orientation` text DEFAULT NULL,
  `position_patient` text DEFAULT NULL,
  `window_center` decimal(10,2) DEFAULT NULL,
  `window_width` decimal(10,2) DEFAULT NULL,
  `image_quality` enum('Poor','Fair','Good','Excellent') DEFAULT 'Good',
  `compression_type` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `sop_instance_uid`, `series_id`, `image_number`, `image_description`, `image_date`, `image_time`, `file_path`, `file_size`, `file_hash`, `image_width`, `image_height`, `bits_allocated`, `bits_stored`, `pixel_spacing`, `slice_location`, `image_orientation`, `position_patient`, `window_center`, `window_width`, `image_quality`, `compression_type`, `is_deleted`, `deleted_at`, `deleted_by`, `created_by`, `created_at`, `updated_at`) VALUES
(1, '1.2.840.113619.2.55.1.3.20260111090001.1.1', 1, 1, 'CT Chest Scout AP', '2026-01-11 09:05:00', '09:05:00', '/pacs/images/studies/1/series/1/CT_001.dcm', 524288, 'hash1234567890', 512, 512, 16, 12, 0.5000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(2, '1.2.840.113619.2.55.1.3.20260111090001.1.2', 1, 2, 'CT Chest Scout Lateral', '2026-01-11 09:06:00', '09:06:00', '/pacs/images/studies/1/series/1/CT_002.dcm', 524288, 'hash1234567891', 512, 512, 16, 12, 0.5000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(3, '1.2.840.113619.2.55.1.3.20260111090001.2.1', 2, 1, 'CT Chest Axial Slice 1', '2026-01-11 09:10:00', '09:10:00', '/pacs/images/studies/1/series/2/CT_003.dcm', 1048576, 'hash1234567892', 512, 512, 16, 12, 0.5000, 0.00, NULL, NULL, 40.00, 400.00, 'Excellent', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(4, '1.2.840.113619.2.55.1.3.20260111090001.2.2', 2, 2, 'CT Chest Axial Slice 2', '2026-01-11 09:10:00', '09:10:00', '/pacs/images/studies/1/series/2/CT_004.dcm', 1048576, 'hash1234567893', 512, 512, 16, 12, 0.5000, 0.50, NULL, NULL, 40.00, 400.00, 'Excellent', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(5, '1.2.840.113619.2.55.1.3.20260114100002.1.1', 4, 1, 'MRI Brain T1 Axial Slice 1', '2026-01-14 10:05:00', '10:05:00', '/pacs/images/studies/2/series/4/MRI_001.dcm', 2097152, 'hash2234567890', 512, 512, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(6, '1.2.840.113619.2.55.1.3.20260114100002.1.2', 4, 2, 'MRI Brain T1 Axial Slice 2', '2026-01-14 10:05:00', '10:05:00', '/pacs/images/studies/2/series/4/MRI_002.dcm', 2097152, 'hash2234567891', 512, 512, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(7, '1.2.840.113619.2.55.1.3.20260115110003.2.1', 8, 1, 'CT Trauma Axial Slice 1', '2026-01-15 11:10:00', '11:10:00', '/pacs/images/studies/3/series/8/CT_005.dcm', 1572864, 'hash3234567890', 512, 512, 16, 12, 0.7500, 0.00, NULL, NULL, 50.00, 450.00, 'Good', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(8, '1.2.840.113619.2.55.1.3.20260115110003.2.2', 8, 2, 'CT Trauma Axial Slice 2', '2026-01-15 11:10:00', '11:10:00', '/pacs/images/studies/3/series/8/CT_006.dcm', 1572864, 'hash3234567891', 512, 512, 16, 12, 0.7500, 0.75, NULL, NULL, 50.00, 450.00, 'Good', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(9, '1.2.840.113619.2.55.1.3.20260120140004.1.1', 9, 1, 'MRI Spine Sagittal T1 Slice 1', '2026-01-20 14:05:00', '14:05:00', '/pacs/images/studies/4/series/9/MRI_003.dcm', 1835008, 'hash4234567890', 512, 512, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(10, '1.2.840.113619.2.55.1.3.20260122080005.1.1', 11, 1, 'Mammogram RCC', '2026-01-22 08:05:00', '08:05:00', '/pacs/images/studies/5/series/11/MG_001.dcm', 3145728, 'hash5234567890', 1024, 1024, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Excellent', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(11, '1.2.840.113619.2.55.1.3.20260122080005.2.1', 12, 1, 'Mammogram LCC', '2026-01-22 08:10:00', '08:10:00', '/pacs/images/studies/5/series/12/MG_002.dcm', 3145728, 'hash5234567891', 1024, 1024, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Excellent', NULL, 0, NULL, NULL, 4, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(12, '1.2.840.113619.2.55.1.3.20260123090006.1.1', 13, 1, 'US Liver Long Axis', '2026-01-23 09:05:00', '09:05:00', '/pacs/images/studies/6/series/13/US_001.dcm', 524288, 'hash6234567890', 640, 480, 8, 8, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Fair', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(13, '1.2.840.113619.2.55.1.3.20260130150008.1.1', 14, 1, 'MRI Knee Coronal PD Slice 1', '2026-01-30 15:05:00', '15:05:00', '/pacs/images/studies/8/series/14/MRI_004.dcm', 2097152, 'hash7234567890', 512, 512, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22'),
(14, '1.2.840.113619.2.55.1.3.20260130150008.2.1', 15, 1, 'MRI Knee Sagittal T2 Slice 1', '2026-01-30 15:15:00', '15:15:00', '/pacs/images/studies/8/series/15/MRI_005.dcm', 2097152, 'hash7234567891', 512, 512, 16, 12, 0.0000, 0.00, NULL, NULL, 0.00, 0.00, 'Good', NULL, 0, NULL, NULL, 5, '2026-09-07 08:40:22', '2026-09-07 05:40:22');

-- --------------------------------------------------------

--
-- Table structure for table `image_annotations`
--

CREATE TABLE `image_annotations` (
  `annotation_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `annotation_type` enum('Arrow','Circle','Rectangle','Line','Text','Measurement','Overlay','Region','Segmentation') NOT NULL,
  `annotation_data` text NOT NULL,
  `annotation_text` text DEFAULT NULL,
  `x_position` decimal(10,2) DEFAULT NULL,
  `y_position` decimal(10,2) DEFAULT NULL,
  `measurement_value` decimal(10,2) DEFAULT NULL,
  `measurement_unit` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `image_annotations`
--

INSERT INTO `image_annotations` (`annotation_id`, `image_id`, `user_id`, `annotation_type`, `annotation_data`, `annotation_text`, `x_position`, `y_position`, `measurement_value`, `measurement_unit`, `color`, `is_deleted`, `created_at`, `updated_at`) VALUES
(1, 3, 2, 'Arrow', '{\"x\":245,\"y\":300,\"angle\":45}', 'Coronary artery calcification', 245.00, 300.00, NULL, NULL, 'Red', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(2, 4, 2, 'Circle', '{\"x\":250,\"y\":280,\"radius\":15}', 'Potential coronary lesion', 250.00, 280.00, 1.50, 'cm', 'Yellow', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(3, 7, 2, 'Arrow', '{\"x\":200,\"y\":350,\"angle\":30}', 'Right rib fracture #4', 200.00, 350.00, NULL, NULL, 'Red', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(4, 8, 2, 'Rectangle', '{\"x\":210,\"y\":340,\"width\":30,\"height\":20}', 'Lung contusion', 210.00, 340.00, 2.00, 'cm', 'Blue', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(5, 9, 3, 'Arrow', '{\"x\":300,\"y\":250,\"angle\":-45}', 'L4-L5 disc herniation', 300.00, 250.00, NULL, NULL, 'Red', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(6, 13, 3, 'Circle', '{\"x\":150,\"y\":200,\"radius\":12}', 'Medial meniscus tear', 150.00, 200.00, 0.50, 'cm', 'Red', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41'),
(7, 14, 3, 'Arrow', '{\"x\":260,\"y\":180,\"angle\":60}', 'Joint effusion', 260.00, 180.00, NULL, NULL, 'Yellow', 0, '2026-09-07 08:58:41', '2026-09-07 05:58:41');

-- --------------------------------------------------------

--
-- Table structure for table `image_views`
--

CREATE TABLE `image_views` (
  `view_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `view_date` datetime DEFAULT current_timestamp(),
  `view_duration` int(11) DEFAULT NULL,
  `zoom_level` decimal(5,2) DEFAULT NULL,
  `contrast` decimal(5,2) DEFAULT NULL,
  `brightness` decimal(5,2) DEFAULT NULL,
  `rotation_angle` int(11) DEFAULT NULL,
  `flip_type` enum('None','Horizontal','Vertical','Both') DEFAULT NULL,
  `window_center` decimal(10,2) DEFAULT NULL,
  `window_width` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `image_views`
--

INSERT INTO `image_views` (`view_id`, `image_id`, `user_id`, `view_date`, `view_duration`, `zoom_level`, `contrast`, `brightness`, `rotation_angle`, `flip_type`, `window_center`, `window_width`) VALUES
(1, 3, 2, '2026-01-12 10:15:00', 45, 1.50, 1.00, 0.80, 0, 'None', 40.00, 400.00),
(2, 4, 2, '2026-01-12 10:20:00', 30, 1.00, 1.00, 0.90, 0, 'None', 40.00, 400.00),
(3, 5, 3, '2026-01-15 09:15:00', 60, 1.20, 1.10, 0.85, 0, 'None', 0.00, 0.00),
(4, 7, 2, '2026-01-16 14:15:00', 25, 1.00, 1.00, 0.90, 0, 'None', 50.00, 450.00),
(5, 8, 2, '2026-01-16 14:20:00', 35, 1.20, 1.05, 0.95, 0, 'None', 50.00, 450.00),
(6, 9, 3, '2026-01-21 11:15:00', 50, 1.00, 1.00, 0.80, 0, 'None', 0.00, 0.00),
(7, 10, 2, '2026-01-23 08:45:00', 40, 1.00, 0.90, 0.80, 0, 'None', 0.00, 0.00),
(8, 13, 3, '2026-01-31 10:15:00', 55, 1.30, 1.00, 0.90, 0, 'None', 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `modalities`
--

CREATE TABLE `modalities` (
  `modality_id` int(11) NOT NULL,
  `modality_code` varchar(10) NOT NULL,
  `modality_name` varchar(100) NOT NULL,
  `modality_type` enum('CT','MRI','X-Ray','Ultrasound','PET','SPECT','Mammography','Angiography','Fluoroscopy','Endoscopy','Dermatology','Ophthalmology','Histopathology','Nuclear Medicine','Interventional') NOT NULL,
  `description` text DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `installation_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modalities`
--

INSERT INTO `modalities` (`modality_id`, `modality_code`, `modality_name`, `modality_type`, `description`, `manufacturer`, `model`, `serial_number`, `installation_date`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'CT', 'Computed Tomography Scanner', 'CT', '64-slice CT scanner for detailed imaging', 'GE Healthcare', 'Revolution CT', 'CT-001-A1', '2023-01-15', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(2, 'MRI', 'Magnetic Resonance Imaging', 'MRI', '3.0 Tesla MRI system', 'Siemens', 'MAGNETOM Vida', 'MRI-002-B2', '2023-03-20', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(3, 'XR', 'X-Ray Radiography', 'X-Ray', 'Digital X-Ray system with DR technology', 'Philips', 'DigitalDiagnost', 'XR-003-C3', '2022-11-10', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(4, 'US', 'Ultrasound Imaging', 'Ultrasound', 'High-resolution ultrasound with 4D capabilities', 'GE Healthcare', 'Voluson E10', 'US-004-D4', '2023-06-01', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(5, 'PET', 'PET Scanner', 'PET', 'PET/CT hybrid system', 'Siemens', 'Biograph Vision', 'PET-005-E5', '2023-08-15', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(6, 'MG', 'Mammography', 'Mammography', 'Digital mammography with tomosynthesis', 'Hologic', 'Selenia Dimensions', 'MG-006-F6', '2023-09-01', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(7, 'FL', 'Fluoroscopy', 'Fluoroscopy', 'Digital fluoroscopy system', 'Siemens', 'Luminos Fusion', 'FL-007-G7', '2023-04-10', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39'),
(8, 'XA', 'Angiography', 'Angiography', 'Interventional angiography system', 'Philips', 'Azurion 7', 'XA-008-H8', '2023-07-20', 1, 1, '2026-09-07 08:28:39', '2026-09-07 05:28:39');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `national_id` varchar(20) DEFAULT NULL,
  `hospital_id` varchar(20) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `physical_address` text DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_phone` varchar(15) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `marital_status` enum('Single','Married','Divorced','Widowed') DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `registration_date` datetime DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `review_status` enum('Pending','Approved','Verified') NOT NULL DEFAULT 'Pending',
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Table structure for table `patient_attachments`
--

CREATE TABLE `patient_attachments` (
  `attachment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `attachment_type` enum('photo','medical_image') NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `first_name`, `last_name`, `date_of_birth`, `gender`, `national_id`, `hospital_id`, `phone_number`, `email`, `physical_address`, `emergency_contact_name`, `emergency_contact_phone`, `occupation`, `marital_status`, `nationality`, `registration_date`, `is_active`, `created_by`, `updated_at`) VALUES
(1, 'Alice', 'Mwangi', '1985-03-15', 'Female', '12345678', 'HOSP-001', '+254-700-200001', 'alice.mwangi@email.com', '123 Kenyatta Ave, Nairobi', 'Peter Mwangi', '+254-700-200002', 'Teacher', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(2, 'Bob', 'Ochieng', '1990-07-22', 'Male', '87654321', 'HOSP-002', '+254-700-200003', 'bob.ochieng@email.com', '456 Moi Ave, Kisumu', 'Mary Ochieng', '+254-700-200004', 'Engineer', 'Single', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(3, 'Carol', 'Kiprop', '1978-11-10', 'Female', '11223344', 'HOSP-003', '+254-700-200005', 'carol.kiprop@email.com', '789 Uhuru Rd, Eldoret', 'John Kiprop', '+254-700-200006', 'Nurse', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(4, 'David', 'Kamau', '1965-05-05', 'Male', '44332211', 'HOSP-004', '+254-700-200007', 'david.kamau@email.com', '321 Kenyatta Rd, Nakuru', 'Grace Kamau', '+254-700-200008', 'Driver', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(5, 'Emma', 'Njeri', '1995-09-30', 'Female', '99887766', 'HOSP-005', '+254-700-200009', 'emma.njeri@email.com', '654 Tom Mboya St, Mombasa', 'Robert Njeri', '+254-700-200010', 'Student', 'Single', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(6, 'Frank', 'Odhiambo', '1982-12-25', 'Male', '55667788', 'HOSP-006', '+254-700-200011', 'frank.odhiambo@email.com', '987 Jomo Kenyatta, Thika', 'Jane Odhiambo', '+254-700-200012', 'Mechanic', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(7, 'Grace', 'Achieng', '1970-08-14', 'Female', '66778899', 'HOSP-007', '+254-700-200013', 'grace.achieng@email.com', '147 Oginga Odinga, Kisii', 'Thomas Achieng', '+254-700-200014', 'Business Owner', 'Widowed', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(8, 'Henry', 'Mwangi', '1988-04-18', 'Male', '77889900', 'HOSP-008', '+254-700-200015', 'henry.mwangi@email.com', '258 Moi Rd, Nyeri', 'Susan Mwangi', '+254-700-200016', 'Accountant', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(9, 'Irene', 'Njoroge', '1992-06-28', 'Female', '88990011', 'HOSP-009', '+254-700-200017', 'irene.njoroge@email.com', '369 Kenyatta St, Meru', 'Peter Njoroge', '+254-700-200018', 'Lawyer', 'Single', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02'),
(10, 'James', 'Kariuki', '1960-10-02', 'Male', '99001122', 'HOSP-010', '+254-700-200019', 'james.kariuki@email.com', '741 Independence Ave, Malindi', 'Mary Kariuki', '+254-700-200020', 'Retired', 'Married', 'Kenyan', '2026-09-07 08:27:02', 1, 1, '2026-09-07 05:27:02');

-- --------------------------------------------------------

--
-- Table structure for table `patient_visits`
--

CREATE TABLE `patient_visits` (
  `visit_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_date` datetime NOT NULL,
  `visit_type` enum('Outpatient','Inpatient','Emergency','Follow-up','Screening') NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `referring_physician_id` int(11) DEFAULT NULL,
  `reason_for_visit` text NOT NULL,
  `symptoms` text DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `visit_status` enum('Scheduled','In Progress','Completed','Cancelled') DEFAULT 'Scheduled',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_visits`
--

INSERT INTO `patient_visits` (`visit_id`, `patient_id`, `visit_date`, `visit_type`, `department_id`, `referring_physician_id`, `reason_for_visit`, `symptoms`, `diagnosis`, `visit_status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-01-10 09:30:00', 'Outpatient', 1, 6, 'Persistent chest pain and shortness of breath', 'Chest pain, dyspnea, fatigue', 'Suspected coronary artery disease', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(2, 2, '2026-01-12 14:00:00', 'Outpatient', 3, 7, 'Severe headaches for 2 weeks', 'Throbbing headache, nausea, photophobia', 'Rule out intracranial pathology', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(3, 3, '2026-01-15 10:00:00', 'Emergency', 5, 6, 'Motor vehicle accident trauma', 'Chest pain, difficulty breathing', 'Multiple rib fractures', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(4, 4, '2026-01-18 11:30:00', 'Outpatient', 4, 6, 'Chronic lower back pain', 'Lower back pain radiating to legs', 'Suspected lumbar disc herniation', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(5, 5, '2026-01-20 09:00:00', 'Screening', 1, 7, 'Routine breast screening', 'Asymptomatic', 'Screening evaluation', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(6, 6, '2026-01-22 15:00:00', 'Outpatient', 2, 6, 'Abdominal pain and distension', 'Right upper quadrant pain', 'Suspected biliary disease', 'In Progress', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(7, 7, '2026-01-25 08:30:00', 'Follow-up', 3, 7, 'Follow-up after stroke', 'Right-sided weakness', 'Post-stroke evaluation', 'Scheduled', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(8, 8, '2026-01-28 13:00:00', 'Outpatient', 4, 6, 'Left knee pain and swelling', 'Knee pain, swelling, limited mobility', 'Suspected meniscal tear', 'Completed', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(9, 9, '2026-02-01 10:30:00', 'Emergency', 5, 7, 'Sudden severe headache', 'Sudden onset headache, confusion', 'Suspected subarachnoid hemorrhage', 'In Progress', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14'),
(10, 10, '2026-02-03 11:00:00', 'Outpatient', 1, 6, 'Cough and abnormal chest X-ray', 'Chronic cough, hemoptysis', 'Suspected lung mass', 'Scheduled', 1, '2026-09-07 08:33:14', '2026-09-07 05:33:14');

-- --------------------------------------------------------

--
-- Table structure for table `radiology_orders`
--

CREATE TABLE `radiology_orders` (
  `order_id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) NOT NULL,
  `ordering_physician_id` int(11) NOT NULL,
  `modality_id` int(11) NOT NULL,
  `body_part` varchar(100) NOT NULL,
  `clinical_indication` text NOT NULL,
  `priority` enum('Routine','Urgent','Stat','Emergency') DEFAULT 'Routine',
  `order_date` datetime DEFAULT current_timestamp(),
  `scheduled_date` datetime DEFAULT NULL,
  `status` enum('Ordered','Scheduled','In Progress','Completed','Cancelled','Pending','Rejected') DEFAULT 'Ordered',
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `radiology_orders`
--

INSERT INTO `radiology_orders` (`order_id`, `order_number`, `patient_id`, `visit_id`, `ordering_physician_id`, `modality_id`, `body_part`, `clinical_indication`, `priority`, `order_date`, `scheduled_date`, `status`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'ORD-2026-001', 1, 1, 6, 1, 'Chest', 'Chest pain - rule out coronary artery disease', 'Urgent', '2026-01-10 10:00:00', '2026-01-11 09:00:00', 'Completed', 'Patient has history of hypertension', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(2, 'ORD-2026-002', 2, 2, 7, 2, 'Brain', 'Severe headaches - rule out mass lesion', 'Routine', '2026-01-12 14:30:00', '2026-01-14 10:00:00', 'Completed', 'No contrast allergy known', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(3, 'ORD-2026-003', 3, 3, 6, 1, 'Chest', 'Chest trauma from MVA - multiple fractures suspected', 'Stat', '2026-01-15 10:30:00', '2026-01-15 11:00:00', 'Completed', 'Patient in ER, immediate imaging needed', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(4, 'ORD-2026-004', 4, 4, 6, 2, 'Lumbar Spine', 'Lower back pain with radiculopathy', 'Routine', '2026-01-18 12:00:00', '2026-01-20 14:00:00', 'Completed', 'History of heavy lifting at work', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(5, 'ORD-2026-005', 5, 5, 7, 6, 'Breast', 'Routine screening mammogram', 'Routine', '2026-01-20 09:30:00', '2026-01-22 08:00:00', 'Completed', 'First screening', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(6, 'ORD-2026-006', 6, 6, 6, 4, 'Abdomen', 'Right upper quadrant pain - RUQ pain', 'Urgent', '2026-01-22 15:30:00', '2026-01-23 09:00:00', 'In Progress', 'Suspected cholecystitis', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(7, 'ORD-2026-007', 7, 7, 7, 2, 'Brain', 'Post-stroke follow-up MRI', 'Routine', '2026-01-25 09:00:00', '2026-01-27 11:00:00', 'Scheduled', 'Follow-up at 3 months post-stroke', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(8, 'ORD-2026-008', 8, 8, 6, 2, 'Left Knee', 'Left knee pain - suspected meniscal tear', 'Routine', '2026-01-28 13:30:00', '2026-01-30 15:00:00', 'Completed', 'Injury during sports', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(9, 'ORD-2026-009', 9, 9, 7, 1, 'Brain', 'Sudden severe headache - rule out subarachnoid hemorrhage', 'Emergency', '2026-02-01 11:00:00', '2026-02-01 11:30:00', 'In Progress', 'Stat order, patient in ER', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13'),
(10, 'ORD-2026-010', 10, 10, 6, 1, 'Chest', 'Abnormal chest X-ray - rule out lung mass', 'Urgent', '2026-02-03 11:30:00', '2026-02-05 09:00:00', 'Scheduled', 'Smoker for 40 years', 1, '2026-09-07 08:34:13', '2026-09-07 05:34:13');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `study_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `radiologist_id` int(11) NOT NULL,
  `report_type` enum('Preliminary','Final','Addendum','Superseding') NOT NULL,
  `report_date` datetime DEFAULT current_timestamp(),
  `clinical_history` text DEFAULT NULL,
  `findings` text DEFAULT NULL,
  `impression` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL,
  `conclusion` text DEFAULT NULL,
  `report_status` enum('Draft','Pending','Finalized','Verified','Approved','Superseded','Cancelled') DEFAULT 'Draft',
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_date` datetime DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `report_template` varchar(200) DEFAULT NULL,
  `is_confidential` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`report_id`, `study_id`, `patient_id`, `radiologist_id`, `report_type`, `report_date`, `clinical_history`, `findings`, `impression`, `recommendation`, `conclusion`, `report_status`, `reviewed_by`, `reviewed_date`, `approved_by`, `approved_date`, `report_template`, `is_confidential`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'Final', '2026-01-12 10:00:00', 'Patient with history of hypertension presenting with chest pain', 'CT chest shows mild coronary artery calcification. No significant stenosis identified. Lung parenchyma clear. No pleural effusion or pneumothorax.', 'No acute cardiopulmonary abnormality identified.', 'Clinical correlation recommended. Consider risk factor modification.', 'Normal CT chest with mild coronary calcification.', 'Approved', 2, '2026-01-12 10:30:00', 2, '2026-01-12 10:30:00', NULL, 1, 2, '2026-09-07 08:54:36', '2026-09-07 05:54:36'),
(2, 2, 2, 3, 'Final', '2026-01-15 09:00:00', 'Patient with 2-week history of severe headaches', 'MRI brain shows normal intracranial structures. No evidence of mass, hemorrhage, or infarction. Ventricles normal in size and configuration. No midline shift. Pituitary gland normal.', 'Normal MRI brain study.', 'Headache likely primary in nature. Consider neurology follow-up if symptoms persist.', 'Normal MRI brain.', 'Verified', 3, '2026-01-15 09:30:00', NULL, NULL, NULL, 1, 3, '2026-09-07 08:54:36', '2026-09-07 05:54:36'),
(3, 3, 3, 2, 'Final', '2026-01-16 14:00:00', 'Patient involved in motor vehicle accident with chest trauma', 'CT chest demonstrates multiple right-sided rib fractures (ribs 4-7). Mild right pleural effusion. No pneumothorax. Lung contusion noted in right lower lobe. No hemothorax. Mediastinal structures normal. No aortic injury.', 'Multiple rib fractures with mild pleural effusion and lung contusion.', 'Monitor for pneumothorax. Pain management. Follow-up chest X-ray in 48 hours.', 'Multiple right rib fractures with mild pleural effusion.', 'Approved', 2, '2026-01-16 14:30:00', 2, '2026-01-16 14:30:00', NULL, 1, 2, '2026-09-07 08:54:36', '2026-09-07 05:54:36'),
(4, 4, 4, 3, 'Final', '2026-01-21 11:00:00', 'Patient with chronic lower back pain radiating to legs', 'MRI lumbar spine shows moderate L4-L5 disc herniation causing mild central canal stenosis. L5-S1 shows mild disc bulging. No significant nerve root compression seen. Vertebral bodies normal. No fracture.', 'L4-L5 disc herniation with mild central canal stenosis.', 'Physical therapy recommended. Consider epidural steroid injection if symptoms persist.', 'L4-L5 disc herniation, otherwise normal lumbar spine.', 'Verified', 3, '2026-01-21 11:30:00', NULL, NULL, NULL, 1, 3, '2026-09-07 08:54:36', '2026-09-07 05:54:36'),
(5, 5, 5, 2, 'Final', '2026-01-23 08:30:00', 'Routine screening mammogram. No breast symptoms reported.', 'Bilateral screening mammogram shows no suspicious masses or microcalcifications. Breast tissue density is heterogeneously dense (BI-RADS C).', 'Negative mammogram. BI-RADS 1.', 'Routine screening mammography in 1-2 years.', 'Normal screening mammogram.', 'Approved', 2, '2026-01-23 09:00:00', 2, '2026-01-23 09:00:00', NULL, 1, 2, '2026-09-07 08:54:36', '2026-09-07 05:54:36'),
(6, 8, 8, 3, 'Final', '2026-01-31 10:00:00', 'Patient with left knee pain and swelling following sports injury', 'MRI left knee shows intrasubstance tear of the medial meniscus. Mild joint effusion. ACL and PCL intact. Collateral ligaments normal. Articular cartilage normal. No fracture.', 'Medial meniscus tear with joint effusion.', 'Conservative management recommended. Consider orthopedic consultation for possible arthroscopy if symptoms persist.', 'Medial meniscus tear, otherwise normal knee MRI.', 'Verified', 3, '2026-01-31 10:30:00', NULL, NULL, NULL, 1, 3, '2026-09-07 08:54:36', '2026-09-07 05:54:36');

-- --------------------------------------------------------

--
-- Table structure for table `report_templates`
--

CREATE TABLE `report_templates` (
  `template_id` int(11) NOT NULL,
  `template_name` varchar(100) NOT NULL,
  `template_code` varchar(50) NOT NULL,
  `modality_id` int(11) DEFAULT NULL,
  `body_part` varchar(100) DEFAULT NULL,
  `template_content` text NOT NULL,
  `section_headings` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report_templates`
--

INSERT INTO `report_templates` (`template_id`, `template_name`, `template_code`, `modality_id`, `body_part`, `template_content`, `section_headings`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'CT Chest Template', 'TEMP-CT-CHE', 1, 'Chest', 'Clinical History: [CLINICAL_HISTORY]\n\nFindings:\n- Lungs: [LUNG_FINDINGS]\n- Mediastinum: [MEDIASTINAL_FINDINGS]\n- Heart: [CARDIAC_FINDINGS]\n- Chest Wall: [CHEST_WALL_FINDINGS]\n- Bones: [BONE_FINDINGS]\n\nImpression: [IMPRESSION]', 'Clinical History, Findings, Impression', 1, 1, '2026-09-07 08:59:40', '2026-09-07 05:59:40'),
(2, 'MRI Brain Template', 'TEMP-MRI-BRA', 2, 'Brain', 'Clinical History: [CLINICAL_HISTORY]\n\nFindings:\n- Brain Parenchyma: [BRAIN_FINDINGS]\n- Ventricles: [VENTRICLE_FINDINGS]\n- Supratentorial: [SUPRATENTORIAL]\n- Infratentorial: [INFRATENTORIAL]\n- Vascular: [VASCULAR_FINDINGS]\n- Extra-axial spaces: [EXTRA_AXIAL]\n\nImpression: [IMPRESSION]', 'Clinical History, Findings, Impression', 1, 1, '2026-09-07 08:59:40', '2026-09-07 05:59:40'),
(3, 'MRI Spine Template', 'TEMP-MRI-SPI', 2, 'Lumbar Spine', 'Clinical History: [CLINICAL_HISTORY]\n\nFindings:\n- Alignment: [ALIGNMENT]\n- Vertebral Bodies: [VERTEBRAL_BODIES]\n- Discs: [DISC_FINDINGS]\n- Neural Structures: [NEURAL_FINDINGS]\n- Facet Joints: [FACET_FINDINGS]\n- Paraspinal Soft Tissues: [SOFT_TISSUE]\n\nImpression: [IMPRESSION]', 'Clinical History, Findings, Impression', 1, 1, '2026-09-07 08:59:40', '2026-09-07 05:59:40'),
(4, 'Mammogram Template', 'TEMP-MG', 6, 'Breast', 'Clinical History: [CLINICAL_HISTORY]\n\nFindings:\n- Right Breast: [RIGHT_BREAST]\n- Left Breast: [LEFT_BREAST]\n- Overall Density: [BREAST_DENSITY]\n- Assessment: [BI_RADS]\n\nImpression: [IMPRESSION]', 'Clinical History, Findings, Impression', 1, 1, '2026-09-07 08:59:40', '2026-09-07 05:59:40'),
(5, 'Ultrasound Abdomen Template', 'TEMP-US-ABD', 4, 'Abdomen', 'Clinical History: [CLINICAL_HISTORY]\n\nFindings:\n- Liver: [LIVER]\n- Gallbladder: [GALLBLADDER]\n- Pancreas: [PANCREAS]\n- Spleen: [SPLEEN]\n- Kidneys: [KIDNEYS]\n- Aorta: [AORTA]\n- Peritoneal: [PERITONEAL]\n\nImpression: [IMPRESSION]', 'Clinical History, Findings, Impression', 1, 1, '2026-09-07 08:59:40', '2026-09-07 05:59:40');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `priority_level` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `is_system_role` tinyint(1) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_code`, `description`, `priority_level`, `is_active`, `is_system_role`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'System Administrator', 'SYS_ADMIN', 'Full system access with all permissions', 100, 1, 1, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(2, 'Radiologist', 'RADIOLOGIST', 'Can read studies, create reports, and diagnose', 80, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(3, 'Senior Radiologist', 'SR_RADIOLOGIST', 'Senior radiologist with approval privileges', 90, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(4, 'Technologist', 'TECHNOLOGIST', 'Can perform scans and manage equipment', 60, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(5, 'Physician', 'PHYSICIAN', 'Can order studies and view results', 70, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(6, 'Nurse', 'NURSE', 'Can assist in procedures and patient care', 40, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(7, 'Medical Records', 'MED_RECORDS', 'Can manage patient records and release information', 50, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(8, 'Billing Staff', 'BILLING', 'Can manage billing and insurance claims', 30, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41'),
(9, 'Receptionist', 'RECEPTIONIST', 'Can schedule appointments and check-in patients', 20, 1, 0, 1, '2026-09-07 09:03:41', '2026-09-07 06:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_type` enum('Read','Write','Delete','Export','Share','View','Approve','Verify','Cancel','Archive','Restore','Edit','Assign','Schedule','Modify') NOT NULL,
  `resource_type` enum('Patient','Study','Series','Image','Report','Order','Appointment','Equipment','Department','User','Modality','Audit','Archive','DiagnosticCode','ClinicalIndication','Template','Finding','Annotation') NOT NULL,
  `scope` enum('All','Department','Facility','Specific') DEFAULT 'All',
  `is_granted` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`permission_id`, `role_id`, `permission_type`, `resource_type`, `scope`, `is_granted`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Read', 'Patient', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(2, 1, 'Write', 'Patient', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(3, 1, 'Delete', 'Patient', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(4, 1, 'Read', 'Study', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(5, 1, 'Write', 'Study', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(6, 1, 'Delete', 'Study', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(7, 1, 'Read', 'Report', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(8, 1, 'Write', 'Report', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(9, 1, 'Read', 'Image', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(10, 1, 'Read', 'User', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(11, 2, 'Read', 'Patient', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(12, 2, 'Read', 'Study', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(13, 2, 'Write', 'Report', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(14, 2, 'Read', 'Image', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(15, 2, 'Read', 'Finding', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(16, 2, 'Write', 'Finding', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(17, 3, 'Approve', 'Report', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(18, 3, 'Verify', 'Report', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(19, 4, 'Read', 'Patient', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(20, 4, 'Read', 'Study', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(21, 4, 'Write', 'Study', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(22, 4, 'Read', 'Equipment', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(23, 5, 'Read', 'Patient', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(24, 5, 'Write', 'Order', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(25, 5, 'Read', 'Study', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(26, 5, 'Read', 'Report', 'Department', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(27, 7, 'Read', 'Patient', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(28, 7, 'Write', 'Patient', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05'),
(29, 7, 'Read', 'Study', 'All', 1, 1, '2026-09-07 09:06:05', '2026-09-07 06:06:05');

-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE `series` (
  `series_id` int(11) NOT NULL,
  `series_instance_uid` varchar(100) NOT NULL,
  `study_id` int(11) NOT NULL,
  `series_number` int(11) NOT NULL,
  `series_description` varchar(200) DEFAULT NULL,
  `modality_id` int(11) NOT NULL,
  `body_part` varchar(100) DEFAULT NULL,
  `laterality` enum('Left','Right','Bilateral','Unspecified') DEFAULT NULL,
  `protocol_name` varchar(100) DEFAULT NULL,
  `series_date` datetime DEFAULT NULL,
  `series_time` time DEFAULT NULL,
  `series_status` enum('In Progress','Completed','Verified','Rejected') DEFAULT 'In Progress',
  `slice_thickness` decimal(10,2) DEFAULT NULL,
  `spacing_between_slices` decimal(10,2) DEFAULT NULL,
  `image_count` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`series_id`, `series_instance_uid`, `study_id`, `series_number`, `series_description`, `modality_id`, `body_part`, `laterality`, `protocol_name`, `series_date`, `series_time`, `series_status`, `slice_thickness`, `spacing_between_slices`, `image_count`, `created_by`, `created_at`, `updated_at`) VALUES
(1, '1.2.840.113619.2.55.1.2.20260111090001.1', 1, 1, 'CT Chest - Topogram', 1, 'Chest', 'Unspecified', 'Chest CT Scout', '2026-01-11 09:05:00', '09:05:00', 'Completed', 0.00, 0.00, 2, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(2, '1.2.840.113619.2.55.1.2.20260111090001.2', 1, 2, 'CT Chest - Arterial Phase', 1, 'Chest', 'Unspecified', 'Chest CT Contrast', '2026-01-11 09:10:00', '09:10:00', 'Completed', 1.00, 1.00, 120, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(3, '1.2.840.113619.2.55.1.2.20260111090001.3', 1, 3, 'CT Chest - Venous Phase', 1, 'Chest', 'Unspecified', 'Chest CT Contrast', '2026-01-11 09:15:00', '09:15:00', 'Completed', 1.00, 1.00, 120, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(4, '1.2.840.113619.2.55.1.2.20260114100002.1', 2, 1, 'MRI Brain - T1 Axial', 2, 'Brain', 'Unspecified', 'Brain MRI', '2026-01-14 10:05:00', '10:05:00', 'Completed', 1.00, 1.00, 25, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(5, '1.2.840.113619.2.55.1.2.20260114100002.2', 2, 2, 'MRI Brain - T2 Axial', 2, 'Brain', 'Unspecified', 'Brain MRI', '2026-01-14 10:15:00', '10:15:00', 'Completed', 1.00, 1.00, 25, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(6, '1.2.840.113619.2.55.1.2.20260114100002.3', 2, 3, 'MRI Brain - FLAIR', 2, 'Brain', 'Unspecified', 'Brain MRI', '2026-01-14 10:25:00', '10:25:00', 'Completed', 1.00, 1.00, 25, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(7, '1.2.840.113619.2.55.1.2.20260115110003.1', 3, 1, 'CT Chest - Trauma Scout', 1, 'Chest', 'Unspecified', 'Trauma CT', '2026-01-15 11:05:00', '11:05:00', 'Completed', 0.00, 0.00, 2, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(8, '1.2.840.113619.2.55.1.2.20260115110003.2', 3, 2, 'CT Chest - Trauma Scan', 1, 'Chest', 'Unspecified', 'Trauma CT', '2026-01-15 11:10:00', '11:10:00', 'Completed', 0.75, 0.75, 200, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(9, '1.2.840.113619.2.55.1.2.20260120140004.1', 4, 1, 'MRI Lumbar - Sagittal T1', 2, 'Lumbar Spine', 'Unspecified', 'Spine MRI', '2026-01-20 14:05:00', '14:05:00', 'Completed', 0.50, 0.50, 15, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(10, '1.2.840.113619.2.55.1.2.20260120140004.2', 4, 2, 'MRI Lumbar - Axial T2', 2, 'Lumbar Spine', 'Unspecified', 'Spine MRI', '2026-01-20 14:15:00', '14:15:00', 'Completed', 0.50, 0.50, 20, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(11, '1.2.840.113619.2.55.1.2.20260122080005.1', 5, 1, 'Mammogram - RCC', 6, 'Breast', 'Right', 'Screening Mammo', '2026-01-22 08:05:00', '08:05:00', 'Completed', 0.00, 0.00, 2, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(12, '1.2.840.113619.2.55.1.2.20260122080005.2', 5, 2, 'Mammogram - LCC', 6, 'Breast', 'Left', 'Screening Mammo', '2026-01-22 08:10:00', '08:10:00', 'Completed', 0.00, 0.00, 2, 4, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(13, '1.2.840.113619.2.55.1.2.20260123090006.1', 6, 1, 'US Abdomen - Liver', 4, 'Abdomen', 'Unspecified', 'Abdominal US', '2026-01-23 09:05:00', '09:05:00', 'In Progress', 0.00, 0.00, 10, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(14, '1.2.840.113619.2.55.1.2.20260130150008.1', 8, 1, 'MRI Knee - Coronal PD', 2, 'Left Knee', 'Left', 'Knee MRI', '2026-01-30 15:05:00', '15:05:00', 'Completed', 0.50, 0.50, 20, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21'),
(15, '1.2.840.113619.2.55.1.2.20260130150008.2', 8, 2, 'MRI Knee - Sagittal T2', 2, 'Left Knee', 'Left', 'Knee MRI', '2026-01-30 15:15:00', '15:15:00', 'Completed', 0.50, 0.50, 25, 5, '2026-09-07 08:37:21', '2026-09-07 05:37:21');

-- --------------------------------------------------------

--
-- Table structure for table `storage_archive`
--

CREATE TABLE `storage_archive` (
  `archive_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `archive_location` varchar(500) NOT NULL,
  `archive_type` enum('Local','Offsite','Cloud','Tape','NAS','SAN','External') NOT NULL,
  `archive_date` datetime DEFAULT current_timestamp(),
  `retention_days` int(11) DEFAULT NULL,
  `retention_end_date` date DEFAULT NULL,
  `archive_status` enum('Active','Pending','Completed','Failed','Expired','Recovered') DEFAULT 'Pending',
  `compression_ratio` decimal(5,2) DEFAULT NULL,
  `checksum` varchar(64) DEFAULT NULL,
  `archived_by` int(11) DEFAULT NULL,
  `recovered_date` datetime DEFAULT NULL,
  `recovered_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `storage_archive`
--

INSERT INTO `storage_archive` (`archive_id`, `image_id`, `archive_location`, `archive_type`, `archive_date`, `retention_days`, `retention_end_date`, `archive_status`, `compression_ratio`, `checksum`, `archived_by`, `recovered_date`, `recovered_by`, `created_at`, `updated_at`) VALUES
(1, 1, '/archive/pacs/studies/1/2026/', 'Local', '2026-01-12 10:00:00', 3650, '2036-01-12', 'Completed', 0.85, 'checksum123456', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(2, 2, '/archive/pacs/studies/1/2026/', 'Local', '2026-01-12 10:00:00', 3650, '2036-01-12', 'Completed', 0.85, 'checksum123457', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(3, 3, '/archive/pacs/studies/1/2026/', 'Local', '2026-01-12 10:00:00', 3650, '2036-01-12', 'Completed', 0.80, 'checksum123458', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(4, 5, '/archive/pacs/studies/2/2026/', 'Cloud', '2026-01-15 11:00:00', 730, '2028-01-15', 'Completed', 0.75, 'checksum223459', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(5, 6, '/archive/pacs/studies/2/2026/', 'Cloud', '2026-01-15 11:00:00', 730, '2028-01-15', 'Completed', 0.75, 'checksum223460', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(6, 7, '/archive/pacs/studies/3/2026/', 'Offsite', '2026-01-16 15:00:00', 730, '2028-01-16', 'Completed', 0.82, 'checksum323461', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(7, 10, '/archive/pacs/studies/5/2026/', 'NAS', '2026-01-23 09:00:00', 3650, '2036-01-23', 'Completed', 0.70, 'checksum523462', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50'),
(8, 13, '/archive/pacs/studies/8/2026/', 'Local', '2026-01-31 11:00:00', 1095, '2029-01-31', 'Completed', 0.78, 'checksum723463', 1, NULL, NULL, '2026-09-07 09:00:50', '2026-09-07 06:00:50');

-- --------------------------------------------------------

--
-- Table structure for table `studies`
--

CREATE TABLE `studies` (
  `study_id` int(11) NOT NULL,
  `study_instance_uid` varchar(100) NOT NULL,
  `accession_number` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `modality_id` int(11) NOT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `study_date` datetime NOT NULL,
  `study_time` time NOT NULL,
  `study_description` varchar(200) DEFAULT NULL,
  `body_part_examined` varchar(100) DEFAULT NULL,
  `study_status` enum('Scheduled','In Progress','Completed','Verified','Reported','Rejected','Cancelled') DEFAULT 'Scheduled',
  `study_reason` text DEFAULT NULL,
  `protocol_used` varchar(200) DEFAULT NULL,
  `contrast_used` tinyint(1) DEFAULT 0,
  `contrast_type` varchar(50) DEFAULT NULL,
  `dose_quantity` decimal(10,2) DEFAULT NULL,
  `dose_unit` varchar(10) DEFAULT NULL,
  `performed_by` int(11) DEFAULT NULL,
  `verified_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studies`
--

INSERT INTO `studies` (`study_id`, `study_instance_uid`, `accession_number`, `order_id`, `patient_id`, `modality_id`, `equipment_id`, `study_date`, `study_time`, `study_description`, `body_part_examined`, `study_status`, `study_reason`, `protocol_used`, `contrast_used`, `contrast_type`, `dose_quantity`, `dose_unit`, `performed_by`, `verified_by`, `created_by`, `created_at`, `updated_at`) VALUES
(1, '1.2.840.113619.2.55.1.1.20260111090001', 'ACC-2026-001', 1, 1, 1, 1, '2026-01-11 09:00:00', '09:00:00', 'CT Chest with Contrast', 'Chest', 'Verified', 'Chest pain, rule out CAD', 'CT Chest Protocol v3', 1, 'Omnipaque 350', 100.00, 'ml', 4, 2, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(2, '1.2.840.113619.2.55.1.1.20260114100002', 'ACC-2026-002', 2, 2, 2, 2, '2026-01-14 10:00:00', '10:00:00', 'MRI Brain without Contrast', 'Brain', 'Verified', 'Severe headaches', 'MRI Brain Protocol v2', 0, NULL, NULL, NULL, 5, 3, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(3, '1.2.840.113619.2.55.1.1.20260115110003', 'ACC-2026-003', 3, 3, 1, 1, '2026-01-15 11:00:00', '11:00:00', 'CT Chest Trauma', 'Chest', 'Reported', 'MVA trauma', 'CT Trauma Protocol', 1, 'Isovue 370', 80.00, 'ml', 4, 2, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(4, '1.2.840.113619.2.55.1.1.20260120140004', 'ACC-2026-004', 4, 4, 2, 2, '2026-01-20 14:00:00', '14:00:00', 'MRI Lumbar Spine', 'Lumbar Spine', 'Completed', 'Lower back pain with radiculopathy', 'MRI Spine Protocol', 0, NULL, NULL, NULL, 5, 3, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(5, '1.2.840.113619.2.55.1.1.20260122080005', 'ACC-2026-005', 5, 5, 6, 6, '2026-01-22 08:00:00', '08:00:00', 'Screening Mammogram Bilateral', 'Breast', 'Verified', 'Routine screening', 'Mammography Protocol', 0, NULL, NULL, NULL, 4, 2, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(6, '1.2.840.113619.2.55.1.1.20260123090006', 'ACC-2026-006', 6, 6, 4, 4, '2026-01-23 09:00:00', '09:00:00', 'Ultrasound Abdomen', 'Abdomen', 'In Progress', 'RUQ pain', 'US Abdomen Protocol', 0, NULL, NULL, NULL, 5, NULL, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(7, '1.2.840.113619.2.55.1.1.20260127110007', 'ACC-2026-007', 7, 7, 2, 2, '2026-01-27 11:00:00', '11:00:00', 'MRI Brain Follow-up', 'Brain', 'Scheduled', 'Post-stroke follow-up', 'MRI Brain Follow-up Protocol', 1, 'Gadovist', 15.00, 'ml', NULL, NULL, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(8, '1.2.840.113619.2.55.1.1.20260130150008', 'ACC-2026-008', 8, 8, 2, 2, '2026-01-30 15:00:00', '15:00:00', 'MRI Left Knee', 'Left Knee', 'Completed', 'Knee pain, suspected meniscal tear', 'MRI Knee Protocol', 0, NULL, NULL, NULL, 5, 3, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(9, '1.2.840.113619.2.55.1.1.20260201113009', 'ACC-2026-009', 9, 9, 1, 1, '2026-02-01 11:30:00', '11:30:00', 'CT Brain (Head)', 'Brain', 'In Progress', 'Sudden severe headache', 'CT Head Protocol', 0, NULL, NULL, NULL, 4, NULL, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20'),
(10, '1.2.840.113619.2.55.1.1.20260205090010', 'ACC-2026-010', 10, 10, 1, 1, '2026-02-05 09:00:00', '09:00:00', 'CT Chest with Contrast', 'Chest', 'Scheduled', 'Abnormal CXR, suspected mass', 'CT Chest Protocol v3', 1, 'Omnipaque 350', 100.00, 'ml', NULL, NULL, 1, '2026-09-07 08:36:20', '2026-09-07 05:36:20');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_category` enum('General','Security','Storage','DICOM','HL7','Report','Printing','AI/ML','API','Performance','Backup','Audit','Billing','Integration') NOT NULL DEFAULT 'General',
  `setting_type` enum('String','Integer','Boolean','Float','JSON','Text','Password') NOT NULL DEFAULT 'String',
  `is_system` tinyint(1) DEFAULT 0,
  `is_encrypted` tinyint(1) DEFAULT 0,
  `description` text DEFAULT NULL,
  `last_modified_by` int(11) DEFAULT NULL,
  `last_modified_at` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_id`, `setting_key`, `setting_value`, `setting_category`, `setting_type`, `is_system`, `is_encrypted`, `description`, `last_modified_by`, `last_modified_at`, `created_at`, `updated_at`) VALUES
(1, 'system_name', 'PACS/RIS System v3.0', 'General', 'String', 1, 0, 'System display name', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(2, 'default_retention_days', '3650', 'Storage', 'Integer', 1, 0, 'Default image retention period in days', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(3, 'max_upload_size', '1073741824', 'Storage', 'Integer', 1, 0, 'Maximum file upload size in bytes (1GB)', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(4, 'enable_2fa', 'true', 'Security', 'Boolean', 1, 0, 'Enable Two-Factor Authentication for all users', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(5, 'session_timeout_minutes', '60', 'Security', 'Integer', 1, 0, 'Session timeout in minutes', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(6, 'backup_schedule', '0 2 * * *', 'Backup', 'String', 1, 0, 'Cron schedule for automated backups', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(7, 'backup_retention_days', '30', 'Backup', 'Integer', 1, 0, 'Number of days to keep backup files', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(8, 'dicom_aetitle', 'PACS_SERVER', 'DICOM', 'String', 1, 0, 'DICOM Application Entity Title', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(9, 'dicom_port', '104', 'DICOM', 'Integer', 1, 0, 'DICOM SCP port', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(10, 'enable_audit_logging', 'true', 'Audit', 'Boolean', 1, 0, 'Enable audit logging for all system actions', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(11, 'report_timezone', 'Africa/Nairobi', 'Report', 'String', 1, 0, 'Default timezone for report timestamps', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(12, 'enable_ai_analysis', 'false', 'AI/ML', 'Boolean', 1, 0, 'Enable AI-based image analysis features', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(13, 'max_login_attempts', '5', 'Security', 'Integer', 1, 0, 'Maximum login attempts before lockout', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(14, 'lockout_duration_minutes', '30', 'Security', 'Integer', 1, 0, 'Account lockout duration in minutes', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12'),
(15, 'password_expiry_days', '90', 'Security', 'Integer', 1, 0, 'Password expiry period in days', 1, '2026-09-07 09:19:12', '2026-09-07 09:19:12', '2026-09-07 06:19:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('System Admin','Radiologist','Technologist','Physician','Nurse','Medical Records','Billing','Receptionist','Patient') NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `role`, `email`, `first_name`, `last_name`, `phone_number`, `department_id`, `is_active`, `last_login`, `password_reset_token`, `token_expiry`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$hashed_password_here', 'System Admin', 'admin@pacs.com', 'John', 'Admin', '+254-700-000001', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(2, 'dr_smith', '$2y$10$hashed_password_here', 'Radiologist', 'smith@pacs.com', 'Sarah', 'Smith', '+254-700-000002', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(3, 'dr_johnson', '$2y$10$hashed_password_here', 'Radiologist', 'johnson@pacs.com', 'Michael', 'Johnson', '+254-700-000003', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(4, 'tech_jones', '$2y$10$hashed_password_here', 'Technologist', 'jones@pacs.com', 'Robert', 'Jones', '+254-700-000004', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(5, 'tech_williams', '$2y$10$hashed_password_here', 'Technologist', 'williams@pacs.com', 'Lisa', 'Williams', '+254-700-000005', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(6, 'dr_brown', '$2y$10$hashed_password_here', 'Physician', 'brown@pacs.com', 'James', 'Brown', '+254-700-000006', 2, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(7, 'dr_davis', '$2y$10$hashed_password_here', 'Physician', 'davis@pacs.com', 'Mary', 'Davis', '+254-700-000007', 3, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(8, 'nurse_wilson', '$2y$10$hashed_password_here', 'Nurse', 'wilson@pacs.com', 'Patricia', 'Wilson', '+254-700-000008', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(9, 'reception_miller', '$2y$10$hashed_password_here', 'Receptionist', 'miller@pacs.com', 'Jennifer', 'Miller', '+254-700-000009', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(10, 'records_taylor', '$2y$10$hashed_password_here', 'Medical Records', 'taylor@pacs.com', 'Susan', 'Taylor', '+254-700-000010', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39'),
(11, 'billing_anderson', '$2y$10$hashed_password_here', 'Billing', 'anderson@pacs.com', 'David', 'Anderson', '+254-700-000011', 1, 1, NULL, NULL, NULL, 1, '2026-09-07 08:24:57', '2026-09-07 05:25:39');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT current_timestamp(),
  `last_activity` datetime DEFAULT current_timestamp(),
  `logout_time` datetime DEFAULT NULL,
  `session_status` enum('Active','Expired','Terminated','Logged Out') DEFAULT 'Active',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`session_id`, `user_id`, `session_token`, `ip_address`, `user_agent`, `login_time`, `last_activity`, `logout_time`, `session_status`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'token_admin_20260110', '192.168.1.1', 'Chrome/120.0', '2026-01-10 08:00:00', '2026-01-10 17:00:00', NULL, 'Logged Out', 1, '2026-09-07 09:07:13', '2026-09-07 06:07:13'),
(2, 2, 'token_smith_20260112', '192.168.1.100', 'Chrome/120.0', '2026-01-12 08:30:00', '2026-01-12 16:00:00', NULL, 'Logged Out', 1, '2026-09-07 09:07:13', '2026-09-07 06:07:13'),
(3, 3, 'token_johnson_20260115', '192.168.1.101', 'Firefox/121.0', '2026-01-15 08:00:00', '2026-01-15 17:30:00', NULL, 'Logged Out', 1, '2026-09-07 09:07:13', '2026-09-07 06:07:13'),
(4, 4, 'token_jones_20260111', '192.168.1.102', 'Edge/120.0', '2026-01-11 07:30:00', '2026-01-11 15:30:00', NULL, 'Logged Out', 1, '2026-09-07 09:07:13', '2026-09-07 06:07:13'),
(5, 5, 'token_williams_20260114', '192.168.1.103', 'Chrome/120.0', '2026-01-14 08:00:00', '2026-01-14 16:00:00', NULL, 'Active', 1, '2026-09-07 09:07:13', '2026-09-07 06:07:13');

-- --------------------------------------------------------
--
-- Database helper functions
--

DELIMITER $$

CREATE FUNCTION get_patient_full_name(p_patient_id INT)
RETURNS VARCHAR(101)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_full_name VARCHAR(101);
    SELECT CONCAT(first_name, ' ', last_name)
    INTO v_full_name
    FROM patients
    WHERE patient_id = p_patient_id;
    RETURN v_full_name;
END$$

CREATE FUNCTION get_patient_count_by_department(p_department_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM users
    WHERE department_id = p_department_id AND is_active = 1;
    RETURN v_count;
END$$

CREATE FUNCTION get_study_count_by_patient(p_patient_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM studies
    WHERE patient_id = p_patient_id;
    RETURN v_count;
END$$

CREATE FUNCTION get_modality_name(p_modality_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_modality_name VARCHAR(100);
    SELECT modality_name
    INTO v_modality_name
    FROM modalities
    WHERE modality_id = p_modality_id;
    RETURN v_modality_name;
END$$

CREATE FUNCTION get_role_name(p_role_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_role_name VARCHAR(50);
    SELECT role_name
    INTO v_role_name
    FROM roles
    WHERE role_id = p_role_id;
    RETURN v_role_name;
END$$

CREATE PROCEDURE create_patient(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_date_of_birth DATE,
    IN p_gender ENUM('Male','Female','Other'),
    IN p_national_id VARCHAR(20),
    IN p_hospital_id VARCHAR(20),
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_physical_address TEXT,
    IN p_emergency_contact_name VARCHAR(100),
    IN p_emergency_contact_phone VARCHAR(15),
    IN p_occupation VARCHAR(100),
    IN p_marital_status ENUM('Single','Married','Divorced','Widowed'),
    IN p_nationality VARCHAR(50),
    IN p_created_by INT
)
BEGIN
    INSERT INTO patients (
        first_name, last_name, date_of_birth, gender, national_id, hospital_id,
        phone_number, email, physical_address, emergency_contact_name,
        emergency_contact_phone, occupation, marital_status, nationality,
        registration_date, is_active, created_by, updated_at
    )
    VALUES (
        p_first_name, p_last_name, p_date_of_birth, p_gender, p_national_id, p_hospital_id,
        p_phone_number, p_email, p_physical_address, p_emergency_contact_name,
        p_emergency_contact_phone, p_occupation, p_marital_status, p_nationality,
        NOW(), 1, p_created_by, NOW()
    );
END$$

CREATE PROCEDURE read_patient(IN p_patient_id INT)
BEGIN
    SELECT *
    FROM patients
    WHERE patient_id = p_patient_id;
END$$

CREATE PROCEDURE update_patient(
    IN p_patient_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_date_of_birth DATE,
    IN p_gender ENUM('Male','Female','Other'),
    IN p_national_id VARCHAR(20),
    IN p_hospital_id VARCHAR(20),
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_physical_address TEXT,
    IN p_emergency_contact_name VARCHAR(100),
    IN p_emergency_contact_phone VARCHAR(15),
    IN p_occupation VARCHAR(100),
    IN p_marital_status ENUM('Single','Married','Divorced','Widowed'),
    IN p_nationality VARCHAR(50)
)
BEGIN
    UPDATE patients
    SET
        first_name = p_first_name,
        last_name = p_last_name,
        date_of_birth = p_date_of_birth,
        gender = p_gender,
        national_id = p_national_id,
        hospital_id = p_hospital_id,
        phone_number = p_phone_number,
        email = p_email,
        physical_address = p_physical_address,
        emergency_contact_name = p_emergency_contact_name,
        emergency_contact_phone = p_emergency_contact_phone,
        occupation = p_occupation,
        marital_status = p_marital_status,
        nationality = p_nationality,
        updated_at = NOW()
    WHERE patient_id = p_patient_id;
END$$

CREATE PROCEDURE remove_patient(IN p_patient_id INT)
BEGIN
    DELETE FROM patients
    WHERE patient_id = p_patient_id;
END$$

CREATE PROCEDURE delete_patient(IN p_patient_id INT)
BEGIN
    DELETE FROM patients
    WHERE patient_id = p_patient_id;
END$$

CREATE PROCEDURE create_user(
    IN p_username VARCHAR(50),
    IN p_password_hash VARCHAR(255),
    IN p_role ENUM('System Admin','Radiologist','Technologist','Physician','Nurse','Medical Records','Billing','Receptionist','Patient'),
    IN p_email VARCHAR(100),
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_phone_number VARCHAR(15),
    IN p_department_id INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO users (
        username, password_hash, role, email, first_name, last_name,
        phone_number, department_id, is_active, created_by, created_at, updated_at
    )
    VALUES (
        p_username, p_password_hash, p_role, p_email, p_first_name, p_last_name,
        p_phone_number, p_department_id, 1, p_created_by, NOW(), NOW()
    );
END$$

CREATE PROCEDURE read_user(IN p_user_id INT)
BEGIN
    SELECT *
    FROM users
    WHERE user_id = p_user_id;
END$$

CREATE PROCEDURE update_user(
    IN p_user_id INT,
    IN p_username VARCHAR(50),
    IN p_role ENUM('System Admin','Radiologist','Technologist','Physician','Nurse','Medical Records','Billing','Receptionist','Patient'),
    IN p_email VARCHAR(100),
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_phone_number VARCHAR(15),
    IN p_department_id INT,
    IN p_is_active TINYINT(1)
)
BEGIN
    UPDATE users
    SET
        username = p_username,
        role = p_role,
        email = p_email,
        first_name = p_first_name,
        last_name = p_last_name,
        phone_number = p_phone_number,
        department_id = p_department_id,
        is_active = p_is_active,
        updated_at = NOW()
    WHERE user_id = p_user_id;
END$$

CREATE PROCEDURE remove_user(IN p_user_id INT)
BEGIN
    DELETE FROM users
    WHERE user_id = p_user_id;
END$$

CREATE PROCEDURE delete_user(IN p_user_id INT)
BEGIN
    DELETE FROM users
    WHERE user_id = p_user_id;
END$$

DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment_scheduling`
--
ALTER TABLE `appointment_scheduling`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `study_id` (`study_id`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `radiologist_id` (`radiologist_id`),
  ADD KEY `technician_id` (`technician_id`),
  ADD KEY `canceled_by` (`canceled_by`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `study_id` (`study_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexes for table `clinical_indications`
--
ALTER TABLE `clinical_indications`
  ADD PRIMARY KEY (`indication_id`),
  ADD UNIQUE KEY `indication_code` (`indication_code`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `department_name` (`department_name`),
  ADD UNIQUE KEY `department_code` (`department_code`),
  ADD KEY `head_of_department` (`head_of_department`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `diagnostic_codes`
--
ALTER TABLE `diagnostic_codes`
  ADD PRIMARY KEY (`code_id`),
  ADD UNIQUE KEY `unique_code` (`code_type`,`code_value`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`equipment_id`),
  ADD UNIQUE KEY `equipment_code` (`equipment_code`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `findings`
--
ALTER TABLE `findings`
  ADD PRIMARY KEY (`finding_id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`),
  ADD UNIQUE KEY `sop_instance_uid` (`sop_instance_uid`),
  ADD KEY `series_id` (`series_id`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `image_annotations`
--
ALTER TABLE `image_annotations`
  ADD PRIMARY KEY (`annotation_id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `image_views`
--
ALTER TABLE `image_views`
  ADD PRIMARY KEY (`view_id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `modalities`
--
ALTER TABLE `modalities`
  ADD PRIMARY KEY (`modality_id`),
  ADD UNIQUE KEY `modality_code` (`modality_code`),
  ADD UNIQUE KEY `modality_name` (`modality_name`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `hospital_id` (`hospital_id`),
  ADD UNIQUE KEY `national_id` (`national_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `patient_attachments`
--
ALTER TABLE `patient_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `patient_attachments_patient_type` (`patient_id`, `attachment_type`);

--
-- Indexes for table `patient_visits`
--
ALTER TABLE `patient_visits`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `referring_physician_id` (`referring_physician_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `radiology_orders`
--
ALTER TABLE `radiology_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `visit_id` (`visit_id`),
  ADD KEY `ordering_physician_id` (`ordering_physician_id`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `study_id` (`study_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `radiologist_id` (`radiologist_id`),
  ADD KEY `reviewed_by` (`reviewed_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `report_templates`
--
ALTER TABLE `report_templates`
  ADD PRIMARY KEY (`template_id`),
  ADD UNIQUE KEY `template_code` (`template_code`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`series_id`),
  ADD UNIQUE KEY `series_instance_uid` (`series_instance_uid`),
  ADD KEY `study_id` (`study_id`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `storage_archive`
--
ALTER TABLE `storage_archive`
  ADD PRIMARY KEY (`archive_id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `archived_by` (`archived_by`),
  ADD KEY `recovered_by` (`recovered_by`);

--
-- Indexes for table `studies`
--
ALTER TABLE `studies`
  ADD PRIMARY KEY (`study_id`),
  ADD UNIQUE KEY `study_instance_uid` (`study_instance_uid`),
  ADD UNIQUE KEY `accession_number` (`accession_number`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `equipment_id` (`equipment_id`),
  ADD KEY `performed_by` (`performed_by`),
  ADD KEY `verified_by` (`verified_by`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `created_by` (`created_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment_scheduling`
--
ALTER TABLE `appointment_scheduling`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `clinical_indications`
--
ALTER TABLE `clinical_indications`
  MODIFY `indication_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `diagnostic_codes`
--
ALTER TABLE `diagnostic_codes`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `findings`
--
ALTER TABLE `findings`
  MODIFY `finding_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `image_annotations`
--
ALTER TABLE `image_annotations`
  MODIFY `annotation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `image_views`
--
ALTER TABLE `image_views`
  MODIFY `view_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `modalities`
--
ALTER TABLE `modalities`
  MODIFY `modality_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `patient_attachments`
--
ALTER TABLE `patient_attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_visits`
--
ALTER TABLE `patient_visits`
  MODIFY `visit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `radiology_orders`
--
ALTER TABLE `radiology_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `report_templates`
--
ALTER TABLE `report_templates`
  MODIFY `template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `series`
--
ALTER TABLE `series`
  MODIFY `series_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `storage_archive`
--
ALTER TABLE `storage_archive`
  MODIFY `archive_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `studies`
--
ALTER TABLE `studies`
  MODIFY `study_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_scheduling`
--
ALTER TABLE `appointment_scheduling`
  ADD CONSTRAINT `appointment_scheduling_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `radiology_orders` (`order_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_3` FOREIGN KEY (`study_id`) REFERENCES `studies` (`study_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_4` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_5` FOREIGN KEY (`radiologist_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_6` FOREIGN KEY (`technician_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_7` FOREIGN KEY (`canceled_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `appointment_scheduling_ibfk_8` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `audit_logs_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `audit_logs_ibfk_3` FOREIGN KEY (`study_id`) REFERENCES `studies` (`study_id`),
  ADD CONSTRAINT `audit_logs_ibfk_4` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`);

--
-- Constraints for table `clinical_indications`
--
ALTER TABLE `clinical_indications`
  ADD CONSTRAINT `clinical_indications_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`head_of_department`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `diagnostic_codes`
--
ALTER TABLE `diagnostic_codes`
  ADD CONSTRAINT `diagnostic_codes_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `findings`
--
ALTER TABLE `findings`
  ADD CONSTRAINT `findings_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`),
  ADD CONSTRAINT `findings_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`),
  ADD CONSTRAINT `images_ibfk_2` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `images_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `image_annotations`
--
ALTER TABLE `image_annotations`
  ADD CONSTRAINT `image_annotations_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `image_annotations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `image_views`
--
ALTER TABLE `image_views`
  ADD CONSTRAINT `image_views_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `image_views_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `modalities`
--
ALTER TABLE `modalities`
  ADD CONSTRAINT `modalities_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `patient_attachments`
--
ALTER TABLE `patient_attachments`
  ADD CONSTRAINT `patient_attachments_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE;

--
-- Constraints for table `patient_visits`
--
ALTER TABLE `patient_visits`
  ADD CONSTRAINT `patient_visits_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `patient_visits_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `patient_visits_ibfk_3` FOREIGN KEY (`referring_physician_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `patient_visits_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `radiology_orders`
--
ALTER TABLE `radiology_orders`
  ADD CONSTRAINT `radiology_orders_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `radiology_orders_ibfk_2` FOREIGN KEY (`visit_id`) REFERENCES `patient_visits` (`visit_id`),
  ADD CONSTRAINT `radiology_orders_ibfk_3` FOREIGN KEY (`ordering_physician_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `radiology_orders_ibfk_4` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `radiology_orders_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`study_id`) REFERENCES `studies` (`study_id`),
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`radiologist_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reports_ibfk_4` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reports_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `reports_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `report_templates`
--
ALTER TABLE `report_templates`
  ADD CONSTRAINT `report_templates_ibfk_1` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `report_templates_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `series`
--
ALTER TABLE `series`
  ADD CONSTRAINT `series_ibfk_1` FOREIGN KEY (`study_id`) REFERENCES `studies` (`study_id`),
  ADD CONSTRAINT `series_ibfk_2` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `series_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `storage_archive`
--
ALTER TABLE `storage_archive`
  ADD CONSTRAINT `storage_archive_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`),
  ADD CONSTRAINT `storage_archive_ibfk_2` FOREIGN KEY (`archived_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `storage_archive_ibfk_3` FOREIGN KEY (`recovered_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `studies`
--
ALTER TABLE `studies`
  ADD CONSTRAINT `studies_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `radiology_orders` (`order_id`),
  ADD CONSTRAINT `studies_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `studies_ibfk_3` FOREIGN KEY (`modality_id`) REFERENCES `modalities` (`modality_id`),
  ADD CONSTRAINT `studies_ibfk_4` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`),
  ADD CONSTRAINT `studies_ibfk_5` FOREIGN KEY (`performed_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `studies_ibfk_6` FOREIGN KEY (`verified_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `studies_ibfk_7` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `uq_users_patient_id` (`patient_id`),
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `users_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
