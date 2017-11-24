-- migrate from a 0 0.5.5 to a 0.6.0 caliopen cassandra schema

ALTER TYPE caliopen.phone ADD normalized_number text;

CREATE TABLE caliopen.user_recovery_email (
    recovery_email text PRIMARY KEY,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
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
