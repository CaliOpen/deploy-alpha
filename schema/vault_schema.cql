CREATE KEYSPACE vault WITH REPLICATION = {
'class': 'SimpleStrategy',
'replication_factor': 1
};

CREATE TABLE vault.secret (
    bucket text,
    key text,
    value blob,
    PRIMARY KEY (bucket, key)
) WITH CLUSTERING ORDER BY (key ASC);