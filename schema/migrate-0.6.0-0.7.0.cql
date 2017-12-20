-- migrate from a 0 0.6.0 to a 0.7.0 caliopen cassandra schema
ALTER table message ADD is_received BOOLEAN;
