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

