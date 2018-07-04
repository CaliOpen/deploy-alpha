CREATE KEYSPACE "vault" WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': '3'}  AND durable_writes = true;

CREATE TABLE "vault"."entries" (
    bucket text,
    key text,
    value blob,
    PRIMARY KEY (bucket, key)
) WITH CLUSTERING ORDER BY (key ASC);