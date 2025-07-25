// Validates and exports env vars
const assert = require('node:assert');

/**
 * Asserts that the given environment variable exists
 * @param {string} name The environment variable name
 * @returns {string} The environment variable value
 */
function getFromEnv(name) {
    const envVar = process.env[name];
    
    assert.ok(envVar, `${name} is missing from env`);
    
    return envVar;
}

const ADMIN_USERNAME = getFromEnv('MONGO_INITDB_ROOT_USERNAME');
const ADMIN_PASSWORD = getFromEnv('MONGO_INITDB_ROOT_PASSWORD');
const DB_NAME = getFromEnv('MONGO_INITDB_DATABASE');
const USER_USERNAME = getFromEnv('MONGO_INITDB_USERNAME');
const USER_PASSWORD = getFromEnv('MONGO_INITDB_PASSWORD');

const COLLECTION_ENV_KEYS = [
    'ACCOUNTS_COL_NAME',
    'PHONE_NUMBER_COL_NAME',
    'PHONE_NUMBER_IDENTIFIER_COL_NAME',
    'USERNAMES_COL_NAME',
    'USED_LINK_DEVICE_TOKENS_COL_NAME',
    'APPLE_DEVICE_CHECKS_COL_NAME',
    'APPLE_DEVICE_CHECK_PUBLIC_KEYS_COL_NAME',
    'BACKUPS_COL_NAME',
    'CLIENT_RELEASES_COL_NAME',
    'DELETED_ACCOUNTS_COL_NAME',
    'DELETED_ACCOUNTS_LOCK_COL_NAME',
    'ISSUED_RECEIPTS_COL_NAME',
    'EC_KEYS_COL_NAME',
    'EC_SIGNED_PRE_KEYS_COL_NAME',
    'PQ_KEYS_COL_NAME',
    'PQ_LAST_RESORT_KEYS_COL_NAME',
    'MESSAGES_COL_NAME',
    'ONE_TIME_DONATIONS_COL_NAME',
    'PHONE_NUMBER_IDENTIFIERS_COL_NAME',
    'PROFILES_COL_NAME',
    'PUSH_CHALLENGE_COL_NAME',
    'PUSH_NOTIFICATION_EXPERIMENT_SAMPLES_COL_NAME',
    'REDEEMED_RECEIPTS_COL_NAME',
    'REGISTRATION_RECOVERY_COL_NAME',
    'REMOTE_CONFIG_COL_NAME',
    'REPORT_MESSAGE_COL_NAME',
    'SCHEDULED_JOBS_COL_NAME',
    'SUBSCRIPTIONS_COL_NAME',
    'CLIENT_PUBLIC_KEYS_COL_NAME',
    'VERIFICATION_SESSIONS_COL_NAME',
];
const COLLECTION_NAMES = COLLECTION_ENV_KEYS.map((key) => getFromEnv(key));

module.exports = {
    db: DB_NAME,
    collections: COLLECTION_NAMES,
    admin: {
        username: ADMIN_USERNAME,
        password: ADMIN_PASSWORD
    },
    user: {
        username: USER_USERNAME,
        password: USER_PASSWORD
    }
};
