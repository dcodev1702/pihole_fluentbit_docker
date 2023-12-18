# Pihole : Fluent-bit : Docker Compose : Azure Log Analytics
Pi-Hole and Fluent Bit (w/ Azure Log Ingestion API) using Docker Compose

## Optional : Build container image
```console
docker build --no-cache -t pihole-unbound .
```

## Ubuntu Setup (22.04 | 23.04)
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

* Create Data Collection Endpoint (e.g. pihole-dns-dce)
![FC2DB7E0-A2E6-41DD-877C-28170A039645](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/940ebe50-09b8-4553-9846-2dd640e4e4b9)

* Create App Registration & SECRET (e.g. pihole-dns). This has to be assigned the Monitoring Metrics Publisher' role to the Data Collection Rule (DCR)
![image](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/c3898425-0fc3-46db-818e-23c78a1eaa77)

* The Client App ID and Client App Secret has to be saved so you can use it for the fluent-bit.conf - Log Ingestion API section of the configuration
![image](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/6fe4e51e-9ddd-4c36-8208-f80923a9a49b)

* Create a Custom Log (DCR based) from Log Analytics -> Tables
![4BF3DB0D-B223-4125-BEF7-E3FB77A70524](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/34202dd6-df13-4078-8335-9482b2179e04)

![E23BC197-BAA5-4D5A-A35E-4ECABC6790CD](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/94972096-dd76-4719-b8e7-ccdd48f2b7f8)

* VERY IMPORTANT STEP: Assign The App in Entra ID to the Log Analytics Workspace with 'Monitoring Metrics Publisher'
  * You will not be able to autenticate to the Data Collection Rule and send logs to the table w/o completing this step!!!
  
![CEB55ACA-48BC-40C9-BAA1-8E244B894EF8](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/5913ffe1-20c6-466c-87fa-491d1025a05f)

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

Review docker-compose.yml and modify as required
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

Login to Pi-Hole
![0BF4816E-7C3D-4F9C-BC83-05BFCBDEEDAB](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/14e606d8-4a25-48a1-b410-3331a3057a93)


Configure Pi-Hole with Unbound (127.0.0.1#5335)
![53CE6A36-8729-4BBF-831B-92429249925C_1_201_a](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/e67b67e2-444a-4d84-8951-73ffafa63490)


Fluent Bit configured with Azure Log Ingestion API [OUTPUT]
![1C94B134-3A4F-4281-BF58-9C564C836D52](https://github.com/dcodev1702/pihole_fluentbit_docker/assets/32214072/e7922b04-48f7-4bd0-a15d-41cd2a57d429)


