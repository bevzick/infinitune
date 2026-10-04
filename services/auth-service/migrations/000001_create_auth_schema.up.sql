CREATE TYPE account_status AS ENUM (
    'active',
    'blocked',
    'deleted'
);


CREATE TABLE users_auth (
    id              UUID            PRIMARY KEY,
    email           VARCHAR(254)    NOT NULL,
    password_hash   TEXT    NOT NULL,
    status          account_status  NOT NULL DEFAULT 'active',
    email_verified  BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    last_login_at   TIMESTAMPTZ,

    CONSTRAINT chk_users_auth_email_not_blank
        CHECK (
            char_length(trim(email)) >= 3
        ),
    CONSTRAINT chk_users_auth_password_hash_not_blank
        CHECK (
            char_length(password_hash) > 0
        ),
    CONSTRAINT chk_users_auth_updated_at
        CHECK (
            updated_at >= created_at
        ),
    CONSTRAINT chk_users_auth_last_login
        CHECK (
            last_login_at IS NULL
            OR
            last_login_at >= created_at
        )
);

CREATE UNIQUE INDEX ux_users_auth_email_lower
ON users_auth (LOWER(email));


CREATE TABLE roles (
    id           SMALLSERIAL  PRIMARY KEY,
    name         VARCHAR(30)  NOT NULL UNIQUE,
    description  TEXT,
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_roles_name
        CHECK (
            name ~ '^[a-z][a-z0-9_]{1,29}$'
        ),
    CONSTRAINT chk_roles_description_length
        CHECK (
            description IS NULL
            OR
            char_length(description) <= 500
        )
);


CREATE TABLE user_roles (
    user_id     UUID         NOT NULL
        REFERENCES users_auth(id) ON DELETE CASCADE,
    role_id     SMALLINT     NOT NULL
        REFERENCES roles(id)      ON DELETE RESTRICT,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),

    PRIMARY KEY (user_id, role_id)
);
