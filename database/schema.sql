-- CVE Monitor v3.0 Database Schema
-- SQLite Database Structure

-- Table: cves
CREATE TABLE IF NOT EXISTS cves (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cve_id VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    cvss_score REAL DEFAULT 0.0,
    severity VARCHAR(20),
    published_date DATE,
    vendor VARCHAR(255),
    product VARCHAR(255),
    references TEXT,
    raw_data TEXT,
    priority_score REAL DEFAULT 0.0,
    is_priority INTEGER DEFAULT 0,
    source VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_cve_id ON cves(cve_id);
CREATE INDEX idx_vendor ON cves(vendor);
CREATE INDEX idx_severity ON cves(severity);
CREATE INDEX idx_published ON cves(published_date);
CREATE INDEX idx_priority ON cves(is_priority, priority_score);

-- Table: priority_vendors
CREATE TABLE IF NOT EXISTS priority_vendors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vendor_name VARCHAR(255) UNIQUE NOT NULL,
    priority_level INTEGER DEFAULT 5,
    enabled INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_vendor_enabled ON priority_vendors(enabled, priority_level);

-- Insert default priority vendors
INSERT INTO priority_vendors (vendor_name, priority_level, enabled) VALUES
('Fortinet', 10, 1),
('Cisco', 10, 1),
('Palo Alto Networks', 10, 1),
('Microsoft', 9, 1),
('VMware', 9, 1),
('Juniper', 8, 1),
('Check Point', 8, 1),
('F5 Networks', 8, 1),
('Citrix', 7, 1),
('SonicWall', 7, 1);

-- Table: scheduled_tasks
CREATE TABLE IF NOT EXISTS scheduled_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_name VARCHAR(255) UNIQUE NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    last_run TIMESTAMP,
    next_run TIMESTAMP,
    enabled INTEGER DEFAULT 1,
    config TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default scheduled tasks
INSERT INTO scheduled_tasks (task_name, frequency, next_run, enabled, config) VALUES
('daily_check', 'daily', datetime('now', '+1 day'), 1, '{"hours":24,"send_email":true}'),
('weekly_report', 'weekly', datetime('now', '+7 days'), 1, '{"day":"monday","send_email":true}'),
('monthly_summary', 'monthly', datetime('now', '+30 days'), 1, '{"day":1,"send_email":true}');

-- Table: search_history
CREATE TABLE IF NOT EXISTS search_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    search_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_cves INTEGER DEFAULT 0,
    priority_cves INTEGER DEFAULT 0,
    execution_time REAL DEFAULT 0.0,
    source VARCHAR(50),
    export_path TEXT
);

CREATE INDEX idx_search_date ON search_history(search_date);

-- Table: config
CREATE TABLE IF NOT EXISTS config (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    config_key VARCHAR(255) UNIQUE NOT NULL,
    config_value TEXT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default configuration
INSERT INTO config (config_key, config_value, description) VALUES
('smtp_host', '', 'SMTP server hostname'),
('smtp_port', '587', 'SMTP server port'),
('smtp_username', '', 'SMTP authentication username'),
('smtp_password', '', 'SMTP authentication password'),
('smtp_from_email', '', 'Email sender address'),
('smtp_from_name', 'CVE Monitor', 'Email sender name'),
('smtp_encryption', 'tls', 'SMTP encryption type (tls/ssl)'),
('nvd_api_key', '', 'NVD API key for rate limit increase'),
('github_token', '', 'GitHub Personal Access Token'),
('search_hours', '24', 'Hours to look back for CVEs'),
('timezone', 'UTC', 'System timezone'),
('cache_enabled', '1', 'Enable caching'),
('cache_duration', '3600', 'Cache duration in seconds');

CREATE INDEX idx_config_key ON config(config_key);