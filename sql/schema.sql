CREATE TABLE users (
      id                 SERIAL          PRIMARY KEY
    , username           VARCHAR( 64 )   UNIQUE
    , encrypted_password VARCHAR( 512 )
    , time_created       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
    , openid             VARCHAR( 1024 ) UNIQUE
    , admin              BOOLEAN         NOT NULL DEFAULT FALSE
    , CONSTRAINT identifiable CHECK (
        (
            username IS NOT NULL
            AND encrypted_password IS NOT NULL
        ) OR openid IS NOT NULL
    )
);

