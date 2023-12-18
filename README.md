# Pihole : Fluent-bit : Docker Compose : Azure Log Analytics
Pi-Hole and Fluent Bit (w/ Azure Log Ingestion API) using Docker Compose

## Ubuntu Setup
* systemd-resolvd has to be re-configured so it doesn't manager Ubuntu and Pi-Hole & Unbound
can use port 53 (UDP/TCP)
```console
sudo vi /etc/systemd/resolvd.conf
```
* ADD LOCAL IP ADDRESS TO DNS
* CHANGE 'DNSStubListener' from 'yes' to 'no' and write/quit
  
![85BE3754-8BA3-4FA4-A8E2-9D36147B1871](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/fb8ad910-cb8b-43b2-a013-2f57a8c3b314)

* Now restart the systemd-resolvd.service
```console
sudo systemctl restart systemd-resolved.service
```

![60B9D0F2-8E2C-4D13-AEF7-BDA13F6D7F70](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/200eb2ab-ddf2-42bf-956e-56255656aeda)

* Modify environment variables as required (e.g. IP Address, Password, etc)
![290B0AA2-1E3A-47AB-B16A-C5EB9C2EB204](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/0207d30f-975f-4e39-b1bd-596e26040f9b)

* Modify fluent-bit.conf with the required Azure information
  * Entra ID <br />
    -- Client ID <br />
    -- Client Secret <br />
    -- Tenant ID <br />
  * Data Collection Rule <br />
    -- DCR ID <br />
  * Data Collection Endpoint <br />
    -- Data Ingestion Endpoint URL <br />

![3618473B-FD56-40A9-890B-8174D99943D3](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/1d3a9e9b-340e-420f-b37f-121f4458d6ff)

* Review docker-compose.yml and modify as required
```console
docker-compose up -d
```

Supplemental Docker commands
```console
docker-compose down -v
```

```console
docker logs -f fluent-bit
```
