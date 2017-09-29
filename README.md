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

- apiv1:
	- 1 machine to run python ReST API (api v1)

- lmtp:
	- 1 machine to run caliopen lmtp service

- apiv2:
	- 1 machine to run go ReST API (api v2)

- client:
	- 1 machine to run the web client

- prometheus:
	- 1 machine to run prometheus service

- monitor:
	- 1 machine for external monitoring of the whole platform

- gw:
	- 1 machine to act as an ipv4 gateway to external world
