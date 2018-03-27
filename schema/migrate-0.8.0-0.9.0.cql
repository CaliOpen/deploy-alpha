
// Remove unused or bad structure TYPE and TABLES
DROP TYPE caliopen.device_location;
DROP TABLE caliopen.public_key;
DROP TABLE caliopen.device_public_key;
DROP TABLE caliopen.device;

ALTER TYPE caliopen.message_attachment ADD temp_id uuid;

// Recreate never used tables to new design

CREATE TABLE caliopen.device (
    user_id uuid,
    device_id uuid,
    date_insert timestamp,
    date_revoked timestamp,
    ip_creation text,
    name text,
    pi frozen<pimodel>,
    privacy_features map<text, text>,
    status text,
    type text,
    user_agent text,
    PRIMARY KEY (user_id, device_id)
) WITH CLUSTERING ORDER BY (device_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.public_key (
    user_id uuid,
    resource_id uuid,
    key_id uuid,
    alg text,
    crv text,
    date_insert timestamp,
    date_update timestamp,
    expire_date timestamp,
    fingerprint text,
    key text,
    kty text,
    label text,
    resource_type text,
    'use' text,
    x varint,
    y varint,
    PRIMARY KEY (user_id, resource_id, key_id)
) WITH CLUSTERING ORDER BY (resource_id ASC, key_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.device_location (
    user_id uuid,
    device_id uuid,
    address text,
    country text,
    type text,
    PRIMARY KEY (user_id, device_id, address)
) WITH CLUSTERING ORDER BY (device_id ASC, address ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

// Create new tables

CREATE TABLE caliopen.notification (
    user_id uuid,
    notif_id timeuuid,
    body blob,
    emitter text,
    reference text,
    type ascii,
    PRIMARY KEY (user_id, notif_id)
) WITH CLUSTERING ORDER BY (notif_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.notification_ttl (
    ttl_code ascii PRIMARY KEY,
    description text,
    ttl_duration int
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';


// More dangerous operations
ALTER TABLE caliopen.contact DROP deleted;
ALTER TABLE caliopen.contact ADD deleted timestamp;

// Configure notification TTLs
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('short-lived', 'short lieved'), 60);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('mid-lived', 'mid lieved', 3600);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('long-lived', 'long lieved', 43200);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('short-term', 'short term', 86400);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('mid-term', 'mid term', 172800);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('long-term', 'long term', 1728000);
INSERT INTO caliopen.notification_ttl (ttl_code, description, ttl_duration) values ('forever', 'forever', 0);
