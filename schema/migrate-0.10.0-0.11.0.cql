ALTER table caliopen.raw_message ADD delivered boolean;

ALTER table caliopen.user add date_delete timestamp;

DROP table remote_identity;

CREATE TABLE caliopen.remote_identity (
    user_id uuid,
    remote_id uuid,
    credentials map<text, text>,
    display_name text,
    infos map<text, text>,
    last_check timestamp,
    status text,
    type text,
    PRIMARY KEY (user_id, remote_id)
) WITH CLUSTERING ORDER BY (remote_id ASC)
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
