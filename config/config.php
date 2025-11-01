<?php
// CVE Monitor v3.0 - Configuration

define('DB_PATH', __DIR__ . '/../database/cve_monitor.db');
define('TIMEZONE', 'UTC');
define('DEBUG_MODE', true);
define('MAX_EXECUTION_TIME', 60);
define('CACHE_DIR', __DIR__ . '/../cache/');
define('EXPORT_DIR', __DIR__ . '/../public/exports/');
define('LOG_DIR', __DIR__ . '/../logs/');

// API Configurations
define('NVD_API_URL', 'https://services.nvd.nist.gov/rest/json/cves/2.0');
define('GITHUB_API_URL', 'https://api.github.com/graphql');

// Default search parameters
define('DEFAULT_SEARCH_HOURS', 24);
define('MAX_RESULTS_PER_API', 2000);

// Create necessary directories
if (!file_exists(CACHE_DIR)) mkdir(CACHE_DIR, 0755, true);
if (!file_exists(EXPORT_DIR)) mkdir(EXPORT_DIR, 0755, true);
if (!file_exists(LOG_DIR)) mkdir(LOG_DIR, 0755, true);

date_default_timezone_set(TIMEZONE);
ini_set('max_execution_time', MAX_EXECUTION_TIME);