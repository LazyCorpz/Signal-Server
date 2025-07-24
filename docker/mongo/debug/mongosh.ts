import child_process from 'node:child_process';
import { ROOT_USERNAME, ROOT_PASSWORD } from './env';

function quoteString(s: string, quote: `'` | `"` = `'`): string {
    // https://stackoverflow.com/a/1315213
    return quote + s.replaceAll(/(['"])/g, `${quote}\\$1${quote}`) + quote;
}

const cmd = `mongosh --port 27017 -u ${quoteString(ROOT_USERNAME)} -p ${quoteString(ROOT_PASSWORD)} --authenticationDatabase 'admin'`;

child_process.execSync(`docker exec -it signal-mongo ${cmd}`, {
    stdio: 'inherit'
});
