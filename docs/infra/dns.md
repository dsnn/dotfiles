# DNS

The custom dns server is hosted as a docker container in my homelab.
For now it is hosted on the `srv-docker-01`.

- Copy the configuration and docker compose with the ansible playbook `dns-server.yaml`

- Start the container manually

tsig-key is generated with the command:

```console
docker exec dns-server tsig-keygen -a hmac-sha256
```
