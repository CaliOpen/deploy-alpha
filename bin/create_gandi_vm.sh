#!/bin/sh

# Vlan and its ipv4 gateway
gandi vlan create --name alpha_vlan --datacenter FR-SD3 --subnet 192.168.1.0/24 --gateway 192.168.1.254
gandi vm create --memory 1024 --hostname gw1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.254 --ip-version 4

# Store machines
gandi vm create --memory 3072 --hostname store1 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.10 --ip-version 6
gandi vm create --memory 3072 --hostname store2 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.11 --ip-version 6
gandi vm create --memory 3072 --hostname store3 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.12 --ip-version 6
gandi vm create --memory 3072 --hostname store4 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.13 --ip-version 6
gandi vm create --memory 3072 --hostname store5 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.14 --ip-version 6

# Cache
gandi vm create --memory 1024 --hostname cache1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.50 --ip-version 6
# object store
gandi vm create --memory 1024 --hostname object-store1 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.70 --ip-version 6
# MQ
gandi vm create --memory 1024 --hostname mq1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.60 --ip-version 6

# Monitoring
gandi vm create --memory 2048 --hostname prometheus1 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.200 --ip-version 6
gandi vm create --memory 1024 --hostname monitor1 --image "Debian 8" --size 50G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.201 --ip-version 4

# Api machines
gandi vm create --memory 1024 --hostname apiv1-1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.100 --ip-version 4
gandi vm create --memory 1024 --hostname apiv2-1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.110 --ip-version 4

# LMTP
gandi vm create --memory 1024 --hostname lmtp1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.20 --ip-version 6

# web client machine
gandi vm create --memory 1024 --hostname web-client1 --image "Debian 8" --size 10G --datacenter FR-SD3 --vlan alpha_vlan --ip 192.168.1.120 --ip-version 4
