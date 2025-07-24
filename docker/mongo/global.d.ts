// Global variable type information:
// https://www.mongodb.com/docs/manual/reference/method/
declare global {
    // eslint-disable-next-line no-var, @typescript-eslint/no-explicit-any
    var db: any;
    const disableTelemetry: () => void;
}

export {};
