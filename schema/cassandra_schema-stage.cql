CREATE KEYSPACE caliopen_stage WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': '3'}  AND durable_writes = true;

CREATE TYPE caliopen_stage.email (
    address text,
    email_id uuid,
    is_primary boolean,
    label text,
    type text
);

CREATE TYPE caliopen_stage.external_references (
    ancestors_ids frozen<list<text>>,
    message_id text,
    parent_id text
);

CREATE TYPE caliopen_stage.identity (
    identifier text,
    type text
);

CREATE TYPE caliopen_stage.im (
    address text,
    im_id uuid,
    is_primary boolean,
    label text,
    protocol text,
    type text
);

CREATE TYPE caliopen_stage.message_attachment (
    content_type text,
    file_name text,
    is_inline boolean,
    size int,
    url text,
    mime_boundary text,
    temp_id uuid
);

CREATE TYPE caliopen_stage.organization (
    deleted boolean,
    department text,
    is_primary boolean,
    job_description text,
    label text,
    name text,
    organization_id uuid,
    title text,
    type text
);

CREATE TYPE caliopen_stage.participant (
    address text,
    contact_ids frozen<list<uuid>>,
    participant_id uuid,
    label text,
    protocol text,
    type text
);

CREATE TYPE caliopen_stage.phone (
    is_primary boolean,
    number text,
    phone_id uuid,
    type text,
    uri text,
    normalized_number text
);

CREATE TYPE caliopen_stage.pimodel (
    technic int,
    comportment int,
    context int,
    version int,
    date_update timestamp
);

CREATE TYPE caliopen_stage.postal_address (
    address_id uuid,
    city text,
    country text,
    is_primary boolean,
    label text,
    postal_code text,
    region text,
    street text,
    type text
);

CREATE TYPE caliopen_stage.social_identity (
    social_id uuid,
    name text,
    type text,
    infos frozen<map<text, text>>
);

CREATE TABLE caliopen_stage.identity_lookup (
    identifier text,
    protocol text,
    user_id uuid,
    identity_id uuid,
    PRIMARY KEY (identifier, protocol, user_id)
) WITH CLUSTERING ORDER BY (protocol ASC, user_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
    AND comment = ''
    AND compaction = {'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.message (
    user_id uuid,
    message_id uuid,
    attachments list<frozen<message_attachment>>,
    body_html text,
    body_plain text,
    date timestamp,
    date_delete timestamp,
    date_insert timestamp,
    date_sort timestamp,
    discussion_id text,
    external_references frozen<external_references>,
    identities list<frozen<identity>>,
    importance_level int,
    is_answered boolean,
    is_draft boolean,
    is_received boolean,
    is_unread boolean,
    parent_id uuid,
    participants list<frozen<participant>>,
    pi frozen<pimodel>,
    privacy_features map<text, text>,
    protocol text,
    raw_msg_id uuid,
    subject text,
    tagnames list<text>,
    type text,
    user_identities list<uuid>,
    PRIMARY KEY (user_id, message_id)
) WITH CLUSTERING ORDER BY (message_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.local_identity (
    identifier text PRIMARY KEY,
    display_name text,
    status text,
    type text,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.discussion_recipient_lookup (
    user_id uuid,
    recipient_name text,
    discussion_id uuid,
    PRIMARY KEY (user_id, recipient_name)
) WITH CLUSTERING ORDER BY (recipient_name ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.reserved_name (
    name text PRIMARY KEY
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user_identity (
    user_id uuid,
    identity_id uuid,
    credentials map<text, text>,
    display_name text,
    identifier text,
    infos map<text, text>,
    last_check timestamp,
    protocol text,
    status text,
    type text,
    PRIMARY KEY (user_id, identity_id)
) WITH CLUSTERING ORDER BY (identity_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
    AND comment = ''
    AND compaction = {'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.filter_rule (
    user_id uuid,
    rule_id uuid,
    date_insert timestamp,
    filter_expr text,
    name text,
    position int,
    stop_condition boolean,
    PRIMARY KEY (user_id, rule_id)
) WITH CLUSTERING ORDER BY (rule_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.notification (
    user_id uuid,
    notif_id timeuuid,
    body blob,
    emitter text,
    reference text,
    type ascii,
    PRIMARY KEY (user_id, notif_id)
) WITH CLUSTERING ORDER BY (notif_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.contact_lookup (
    user_id uuid,
    value text,
    type text,
    contact_id uuid,
    PRIMARY KEY (user_id, value, type)
) WITH CLUSTERING ORDER BY (value ASC, type ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.notification_ttl (
    ttl_code ascii PRIMARY KEY,
    description text,
    ttl_duration int
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user_name (
    name text PRIMARY KEY,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.device_connection_log (
    user_id uuid,
    resource_id uuid,
    date_insert timestamp,
    country text,
    ip_address text,
    type text,
    PRIMARY KEY (user_id, resource_id, date_insert)
) WITH CLUSTERING ORDER BY (resource_id ASC, date_insert ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.raw_message (
    raw_msg_id uuid PRIMARY KEY,
    delivered boolean,
    raw_data blob,
    raw_size int,
    uri text
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.message_external_ref_lookup (
    user_id uuid,
    external_msg_id text,
    identity_id uuid,
    message_id uuid,
    PRIMARY KEY (user_id, external_msg_id, identity_id)
) WITH CLUSTERING ORDER BY (external_msg_id ASC, identity_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user (
    user_id uuid PRIMARY KEY,
    contact_id uuid,
    date_delete timestamp,
    date_insert timestamp,
    family_name text,
    given_name text,
    local_identities list<text>,
    main_user_id uuid,
    name text,
    params map<text, text>,
    password text,
    pi frozen<pimodel>,
    privacy_features map<text, text>,
    recovery_email text,
    shard_id text
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.device (
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
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user_recovery_email (
    recovery_email text PRIMARY KEY,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.public_key (
    user_id uuid,
    resource_id uuid,
    key_id uuid,
    alg text,
    crv text,
    date_insert timestamp,
    date_update timestamp,
    emails list<text>,
    expire_date timestamp,
    fingerprint text,
    key text,
    kty text,
    label text,
    resource_type text,
    size varint,
    "use" text,
    x varint,
    y varint,
    PRIMARY KEY (user_id, resource_id, key_id)
) WITH CLUSTERING ORDER BY (resource_id ASC, key_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.device_location (
    user_id uuid,
    device_id uuid,
    address text,
    country text,
    type text,
    PRIMARY KEY (user_id, device_id, address)
) WITH CLUSTERING ORDER BY (device_id ASC, address ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user_tag (
    user_id uuid,
    name text,
    date_insert timestamp,
    importance_level int,
    label text,
    type text,
    PRIMARY KEY (user_id, name)
) WITH CLUSTERING ORDER BY (name ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.settings (
    user_id uuid PRIMARY KEY,
    contact_display_format text,
    contact_display_order text,
    default_locale text,
    message_display_format text,
    notification_delay_disappear int,
    notification_enabled boolean,
    notification_message_preview text,
    notification_sound_enabled boolean
) WITH bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.remote_identity (
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
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.contact (
    user_id uuid,
    contact_id uuid,
    additional_name text,
    addresses list<frozen<postal_address>>,
    avatar text,
    date_insert timestamp,
    date_update timestamp,
    deleted timestamp,
    emails list<frozen<email>>,
    family_name text,
    given_name text,
    groups list<text>,
    identities list<frozen<social_identity>>,
    ims list<frozen<im>>,
    infos map<text, text>,
    name_prefix text,
    name_suffix text,
    organizations list<frozen<organization>>,
    phones list<frozen<phone>>,
    pi frozen<pimodel>,
    privacy_features map<text, text>,
    tagnames list<text>,
    title text,
    PRIMARY KEY (user_id, contact_id)
) WITH CLUSTERING ORDER BY (contact_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.identity_type_lookup (
    type text,
    user_id uuid,
    identity_id uuid,
    PRIMARY KEY (type, user_id, identity_id)
) WITH CLUSTERING ORDER BY (user_id ASC, identity_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
    AND comment = ''
    AND compaction = {'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.user_raw_lookup (
    user_id uuid,
    raw_msg_id uuid,
    PRIMARY KEY (user_id, raw_msg_id)
) WITH CLUSTERING ORDER BY (raw_msg_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.participant_hash (
    user_id uuid,
    kind text,
    key text,
    value text,
    components list<text>,
    date_insert timestamp,
    PRIMARY KEY (user_id, kind, key, value)
) WITH CLUSTERING ORDER BY (kind ASC, key ASC, value ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen_stage.hash_lookup (
    user_id uuid,
    uri text,
    hash text,
    date_insert timestamp,
    hash_components list<text>,
    PRIMARY KEY (user_id, uri, hash)
) WITH CLUSTERING ORDER BY (uri ASC, hash ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = '{"keys":"ALL", "rows_per_partition":"ALL"}'
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
