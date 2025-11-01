-- SQLite schema for CVE Monitor v3.0

-- Table for storing CVEs
CREATE TABLE cves (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cve_id TEXT NOT NULL,
    description TEXT,
    published_date DATETIME,
    modified_date DATETIME
);

-- Table for storing priority vendors
CREATE TABLE priority_vendors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vendor_name TEXT NOT NULL UNIQUE
);

-- Initial data for priority vendors
INSERT INTO priority_vendors (vendor_name) VALUES
('Fortinet'),
('Cisco'),
('Palo Alto Networks'),
('Microsoft'),
('VMware'),
('Juniper'),
('Check Point'),
('F5 Networks'),
('Citrix'),
('SonicWall');

-- Table for scheduling tasks
CREATE TABLE scheduled_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_name TEXT NOT NULL,
    schedule_time DATETIME,
    status TEXT
);

-- Table for storing search history
CREATE TABLE search_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    search_query TEXT NOT NULL,
    search_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table for configuration settings
CREATE TABLE config (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    setting_name TEXT NOT NULL UNIQUE,
    setting_value TEXT
);
