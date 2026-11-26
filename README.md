# PACS — Picture Archiving and Communication System

A PHP web application for the supplied MariaDB PACS database. The site provides role-verified sign-in, a dashboard, patient directory and detail views, imaging study and report lists, and account settings.

## Requirements

- XAMPP (Apache and MySQL/MariaDB)
- PHP 8.0+ with PDO MySQL
- The supplied `picture_db (1).sql` database dump

## Setup with XAMPP

1. Start Apache and MySQL in the XAMPP Control Panel.
2. In phpMyAdmin, create a database named `picture_db` and import `picture_db (1).sql`.
3. Check `config/database.php`. It defaults to the standard XAMPP connection (`127.0.0.1:3306`, user `root`, empty password). Override with `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, or `DB_NAME` environment variables if needed.
4. The example users in the SQL dump have placeholder password hashes. Set a real password for an existing account from a terminal at the repository root:

   ```powershell
   C:\xampp\php\php.exe website\setup_admin.php admin
   ```

   Choose a strong password of at least 6 characters. The setup utility only runs from the command line; use the same command with another existing username to set up additional accounts.
5. Open [http://localhost/PictureProject/](http://localhost/PictureProject/) and sign in. Select the role assigned to the account in the sign-in role switcher.

For an existing database, apply `website/migrations/001_department_passwords.sql`, `website/migrations/002_patient_user_link.sql`, and `website/migrations/003_patient_attachments_and_review.sql` once each. On a fresh install, these changes are included in the supplied SQL dump.

## Web features

- Session-based sign-in, sign-out, and one-hour inactivity timeout
- Role-aware navigation and server-side authorization checks
- Role selector validated against the signed-in user's database role
- Searchable patient directory, patient details, and patient record creation
- Patient photo and DICOM/JPEG/PNG attachments stored outside the web root and served only to authorized staff
- Patient review status starts as Pending and must be manually set to Approved or Verified by staff other than System Admin and Patient
- Imaging worklist with status and modality filters
- Nurse/technologist image attachment for existing studies, with protected image retrieval
- Physician/radiologist review queue and patient-facing published feedback
- Searchable report list with report impressions and status
- Profile/contact updates and password changes
- System Admin user management with role and department assignment
- System Admin-configured shared passwords for department accounts
- Authenticated PHP JSON API used by frontend pages for data operations
- CSRF-protected state-changing forms and prepared SQL statements
- Signed-in page source viewer with a fixed front-end page and asset allowlist

The supplied schema stores one role per user. Selecting a different role at sign-in does not grant access; the selected role must match the database account. System Admins link Patient accounts to an existing patient record during account registration; patient portals only show published, non-confidential reports for that linked record.

Department passwords are shared among all users assigned to the department and are managed by a System Admin from User management. Shared credentials make it harder to attribute actions to an individual; use unique accounts/passwords where individual accountability is required.

The page source viewer is available to signed-in users and uses a fixed allowlist of front-end pages and assets. It does not expose database settings or the backend API implementation.

Nurses and technologists can attach DICOM, JPEG, or PNG files (up to 20 MB) to an existing study. Uploads are stored outside the web root in the operating system temporary directory by default; set `PACS_IMAGE_STORAGE` to a persistent private directory for production. JPEG/PNG images can be previewed, while DICOM files are downloaded for use with a dedicated viewer. This file-attachment workflow does not connect directly to imaging hardware and is not a substitute for a validated clinical DICOM workstation.

Patient records can also be created with an optional JPEG/PNG photo (up to 5 MB) and a DICOM, JPEG, or PNG medical image (up to 20 MB). Patient attachments use the same private `PACS_IMAGE_STORAGE` directory. Medical images attached during registration are linked to the patient record; scans associated with an imaging study should continue to be uploaded from the Imaging studies page.

## Project layout

```text
config/database.php                 PDO connection
index.php                           Web application entry point
website/assets/                     Shared CSS and JavaScript
website/frontend/                   PHP pages, including System Admin user management
website/backend/api/web.php         Authenticated JSON API used by frontend pages
website/includes/                   Session, security, and layout helpers
website/setup_admin.php             CLI-only password setup utility
picture_db (1).sql                  Supplied schema and sample data
pacs-app/                           Existing Expo mobile project
```
