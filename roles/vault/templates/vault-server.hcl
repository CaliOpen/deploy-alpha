storage "cassandra" {
  hosts            = "localhost"
  consistency      = "LOCAL_QUORUM"
  protocol_version = 3
  keyspace         = "vault"
  table            = "secret"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}