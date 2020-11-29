# NiFi Examples
This repository will contain nifi example templates with required files(if any) for running them. Follow the link to find the complete official docuemntation for [Apache NiFi.](https://nifi.apache.org/docs.html)

## How to start Apache NiFi
NiFi can be started by simply downloding binary file or using docker image.

### Download and run NiFi 
Download the NiFi binary file from [Apache Nifi's official website.](https://nifi.apache.org/download.html)
- Choose nifi-x.y.z-bin.zip (eg, nifi-1.12.1-bin.zip).
- Extract to a specific folder (eg. \home\username\nifi).
- Find and execute run-nifi.bat or run.sh in “your nifi folder\bin\” based on the operating environment.
### Run a NiFi container
NiFi Docker images are hosted on Docker Hub, [Apache NiFi Docker Image](https://hub.docker.com/r/apache/nifi/)
You can use the below command to download and run the latest version of NiFi with default configurtions. You can also check the official [Apache NiFi Docker Image](https://hub.docker.com/r/apache/nifi/) for more configuratios.
```
docker run -d -h nifi -p 8080:8080 --name nifi_latest --memory=4g -v /docker/apache/nifi apache/nifi:latest
```
When you start NiFi, you land on its web interface. The web UI is the blueprint on which you design and control your data pipeline. You can access the web interface by [http://localhost:8080/nifi](http://localhost:8080/nifi)

## Examples
- [csv-to-mysql-and-kafka](https://github.com/VishnuGurudathan/nifi-examples/tree/main/csv-to-mysql-and-kafka) - Parse and save data from CSV file to database and route flow to Kafka based on some condition.
