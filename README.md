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

![60B9D0F2-8E2C-4D13-AEF7-BDA13F6D7F70](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/200eb2ab-ddf2-42bf-956e-56255656aeda)

* Now restart the systemd-resolvd.service
```console
sudo systemctl restart systemd-resolved.service
```
