"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = ({ env }) => ({
    connection: {
        client: 'postgres',
        connection: {
            host: env('DATABASE_HOST', '103.82.38.96'),
            port: env.int('DATABASE_PORT', 5441),
            database: env('DATABASE_NAME', 'volunteer-cms-strapi-db'),
            user: env('DATABASE_USERNAME', 'admin'),
            password: env('DATABASE_PASSWORD', 'admin'),
            ssl: env.bool('DATABASE_SSL', false)
                ? {
                    rejectUnauthorized: env.bool('DATABASE_SSL_REJECT_UNAUTHORIZED', true),
                }
                : false,
        },
        pool: { min: 2, max: 10 },
    },
});
