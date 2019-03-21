CREATE TABLE caliopen.message_external_ref_lookup (
    user_id uuid,
    external_msg_id text,
    identity_id uuid,
    message_id uuid,
    PRIMARY KEY (user_id, external_msg_id, identity_id)
) WITH CLUSTERING ORDER BY (external_msg_id ASC, identity_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

ALTER TABLE caliopen.public_key ADD emails list<text>;
