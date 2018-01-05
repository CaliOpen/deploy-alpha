-- migrate from a 0 0.7.0 to a 0.8.0 caliopen cassandra schema
ALTER TABLE caliopen.message DROP column tags;
ALTER TABLE caliopen.contact DROP column tags;

ALTER TABLE caliopen.message ADD column tags list<text>;
ALTER TABLE caliopen.contact ADD column tags list<text>;

DROP type caliopen.resource_tag;

DROP TABLE caliopen.user_tag;

CREATE TABLE caliopen.user_tag (
    user_id uuid,
    name text,
    date_insert timestamp,
    importance_level int,
    label text,
    type text,
    PRIMARY KEY (user_id, name)
) WITH CLUSTERING ORDER BY (name ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL","rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
