Caliopen Alpha infrastructure
=============================

Services
--------

- store:
	- 5 machines for a real cluster
	- running cassandra and elasticsearch

- object-store:
	- 1 machine to run minio

- mq:
	- 1 machine to run nats MQ service

- cache:
	- 1 machine to run redis

- lmtp:
	- 1 machine to run caliopen lmtp service

- api:
	- 2 machine to run ReST API go version (apiv2) and python one (apiv1)

- client:
	- 1 machine to run the web client

- prometheus:
	- 1 machine to run prometheus service

- monitor:
	- 1 machine for external monitoring of the whole platform

- gw:
	- 1 machine to act as an ipv4 gateway to external world


Setup
-----

1 - create machines: ./bin/create_gandi_vm.sh, you need a valid .gandi.config.yaml file and gandicli installed)
2 - setup ansible inventory: ./bin/make_hosts.sh, this make your `hosts` file
3 - ssh on all machines to validate their ssh keys
4 - edit the `hosts` file to define at least caliopen_domain_name global variable (credentials must be edited !)
5 - get a SSL/TLS certificate (*) and it's private key (**) for all roles that need such (client, apiv1, monitor)

(*) can use a wildcard certificate and put same files in all roles
(**) this repository contain the encrypted private key for alpha.caliopen.org domain. Encryption is done using ansible vault.

Deployment
----------

Infrastructure
~~~~~~~~~~~~~~

ansible-playbook -i hosts deploy-gateway.yaml
ansible-playbook -i hosts deploy-prometheus.yaml
ansible-playbook -i hosts deploy-monitor.yaml

Storage layer must be setup first
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ansible-playbook -i hosts deploy-store.yaml
ansible-playbook -i hosts deploy-object-store.yaml
ansible-playbook -i hosts deploy-cache.yaml
ansible-playbook -i hosts deploy-mq.yaml

Setup cassandra keyspace
~~~~~~~~~~~~~~~~~~~~~~~~

- copy the schema/cassandra-schema-alpha.cql to /var/tmp on a store machine.
- log to the same store machine
- check cluster status `nodetool status`
- cqlsh -k caliopen 192.168.1.100 < /var/tmp/cassandra-schema-alpha.cql


Install caliopen services
~~~~~~~~~~~~~~~~~~~~~~~~~

ansible-playbook -i hosts deploy-lmtp.yaml
ansible-playbook -i hosts deploy-api.yaml
ansible-playbook -i hosts deploy-worker.yaml
ansible-playbook -i hosts deploy-web-client.yaml
