CREATE KEYSPACE caliopen WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}  AND durable_writes = true;

CREATE TYPE caliopen.email (
    address text,
    email_id uuid,
    is_primary boolean,
    label text,
    type text
);

CREATE TYPE caliopen.external_references (
    ancestors_ids frozen<list<text>>,
    message_id text,
    parent_id text
);

CREATE TYPE caliopen.im (
    address text,
    im_id uuid,
    is_primary boolean,
    label text,
    protocol text,
    type text
);

CREATE TYPE caliopen.message_attachment (
    content_type text,
    file_name text,
    is_inline boolean,
    size int,
    temp_id uuid,
    url text,
    mime_boundary text
);

CREATE TYPE caliopen.organization (
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

CREATE TYPE caliopen.participant (
    address text,
    contact_ids frozen<list<uuid>>,
    label text,
    protocol text,
    type text
);

CREATE TYPE caliopen.phone (
    is_primary boolean,
    number text,
    normalized_number text,
    phone_id uuid,
    type text,
    uri text
);

CREATE TYPE caliopen.pimodel (
    technic int,
    comportment int,
    context int,
    version int,
    date_update timestamp
);

CREATE TYPE caliopen.postal_address (
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

CREATE TYPE caliopen.social_identity (
    social_id uuid,
    name text,
    type text,
    infos frozen<map<text, text>>
);

CREATE TABLE caliopen.identity_lookup (
    identifier text,
    protocol text,
    user_id uuid,
    identity_id uuid,
    PRIMARY KEY (identifier, protocol, user_id)
) WITH CLUSTERING ORDER BY (protocol ASC, user_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.message (
    user_id uuid,
    message_id uuid,
    attachments list<frozen<message_attachment>>,
    body_html text,
    body_plain text,
    date timestamp,
    date_delete timestamp,
    date_insert timestamp,
    date_sort timestamp,
    discussion_id uuid,
    external_references frozen<external_references>,
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
    user_identities list<uuid>,
    PRIMARY KEY (user_id, message_id)
) WITH CLUSTERING ORDER BY (message_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.reserved_name (
    name text PRIMARY KEY
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.user_identity (
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
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.filter_rule (
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
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

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
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.discussion (
    user_id uuid,
    discussion_id uuid,
    date_insert timestamp,
    excerpt text,
    importance_level int,
    PRIMARY KEY (user_id, discussion_id)
) WITH CLUSTERING ORDER BY (discussion_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.contact_lookup (
    user_id uuid,
    value text,
    type text,
    contact_ids list<uuid>,
    PRIMARY KEY (user_id, value, type)
) WITH CLUSTERING ORDER BY (value ASC, type ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.discussion_thread_lookup (
    user_id uuid,
    external_root_msg_id text,
    discussion_id uuid,
    PRIMARY KEY (user_id, external_root_msg_id)
) WITH CLUSTERING ORDER BY (external_root_msg_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
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
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.discussion_list_lookup (
    user_id uuid,
    list_id text,
    discussion_id uuid,
    PRIMARY KEY (user_id, list_id)
) WITH CLUSTERING ORDER BY (list_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.user_name (
    name text PRIMARY KEY,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.raw_message (
    raw_msg_id uuid PRIMARY KEY,
    delivered boolean,
    raw_data blob,
    raw_size int,
    uri text
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.user (
    user_id uuid PRIMARY KEY,
    contact_id uuid,
    date_delete timestamp,
    date_insert timestamp,
    family_name text,
    given_name text,
    main_user_id uuid,
    name text,
    params map<text, text>,
    password text,
    pi frozen<pimodel>,
    privacy_features map<text, text>,
    recovery_email text,
    shard_id text
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

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
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.user_recovery_email (
    recovery_email text PRIMARY KEY,
    user_id uuid
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
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
    size varint,
    "use" text,
    x varint,
    y varint,
    PRIMARY KEY (user_id, resource_id, key_id)
) WITH CLUSTERING ORDER BY (resource_id ASC, key_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
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
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

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
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.settings (
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
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.contact (
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
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.identity_type_lookup (
    type text,
    user_id uuid,
    identity_id uuid,
    PRIMARY KEY (type, user_id, identity_id)
) WITH CLUSTERING ORDER BY (user_id ASC, identity_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.user_raw_lookup (
    user_id uuid,
    raw_msg_id uuid,
    PRIMARY KEY (user_id, raw_msg_id)
) WITH CLUSTERING ORDER BY (raw_msg_id ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';

CREATE TABLE caliopen.discussion_global_lookup (
    user_id uuid,
    hashed text,
    discussion_id uuid,
    PRIMARY KEY (user_id, hashed)
) WITH CLUSTERING ORDER BY (hashed ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
