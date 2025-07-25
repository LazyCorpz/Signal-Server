import assert from 'node:assert';

assert.ok(
    process.env.AUTH_DB_NAME,
    'MongoDB container name is missing from env'
);
export const AUTH_DB = process.env.AUTH_DB_NAME;

assert.ok(
    process.env.MONGO_CONTAINER_NAME,
    'MongoDB container name is missing from env'
);
export const MONGO_CONTAINER_NAME = process.env.MONGO_CONTAINER_NAME;

assert.ok(
    process.env.ME_CONFIG_MONGODB_ADMINUSERNAME,
    'Root MongoDB username is missing from env'
);
export const ROOT_USERNAME = process.env.ME_CONFIG_MONGODB_ADMINUSERNAME;

assert.ok(
    process.env.ME_CONFIG_MONGODB_ADMINPASSWORD,
    'Root MongoDB password is missing from env'
);
export const ROOT_PASSWORD = process.env.ME_CONFIG_MONGODB_ADMINPASSWORD;
