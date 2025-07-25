/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-call */

// This and all other JS files should be treated as CommonJS:
// https://www.mongodb.com/docs/mongodb-shell/write-scripts/

// Top-level .js and .sh files should be treated as mongo initdb entrypoints:
// https://github.com/docker-library/mongo/blob/5f119ebb61a188e9872d89ff0e682422576ac0bf/8.0/docker-entrypoint.sh#L386-L393

const assert = require('node:assert');
const env = require('./src/env.cjs');

assert.ok(
    typeof db !== 'undefined',
    'db is not defined. Are you mixing JS and mongosh? See: https://www.mongodb.com/docs/mongodb-shell/write-scripts/'
);

// Authenticating
db.getSiblingDB('admin').auth(env.admin.username, env.admin.password);

// Disabling telemetry for all users
disableTelemetry();

// Creating user with minimal permissions
// NOTE: For better IAM, this could be divided into separate users per db(s)
db.createUser({
    user: env.user.username,
    pwd: env.user.password,
    roles: [
        {
            role: 'readWrite',
            db: env.db
        }
    ]
});

// Creating db collections
/** @type {unknown} */
const newDb = db.getSiblingDB(env.db);

for (const name of env.collections) {
    newDb.createCollection(name);
}
