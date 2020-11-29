# CSV to MySQL and routing flow file to Kafka based on condition.
This folder contains NiFi template file, MySQL script file to create database and table, and sample input CSV file.
The purpose of the template file is to parse the CSV file and store its data to the database. Consider the CSV files contain sensor readings like temperature, pressure, etc. First of all, we will split the CSV file and convert it to JSON using *SplictRecord*, then convert the JSON to SQL and push to MySQL using NiFi processors *CunvertJSONToSQL* and *PutSQL*. As a second step, we will use *ExtractJsonPath* processor to extract some content from the JSON on which we want to apply some conditions. We will then use processor *RouteOnAttribute* to route the flow file to Kafka based on our custom condition. In this example, we will route the data to Kafka for those data having temperatures greater than 70°c.
## Importing template file to NiFi
To use a template the first step is to import the template into the running instance of NiFi. You can import templates into the canvas using the *Operate Palette*. From the Operate Palette, click the "Upload Template" button, this will open an Upload Template dialog. Find and choose the template file to be imported to the instance of NiFi.
In our case clone the repository or download the template file *logger_data_parsing_template.xml*, and import it to the NiFi canvas.


## Updating template custom properties and starting the process.
### Update template custom properties
In this example, we create a custom property file '*conf/logger-data-parsing.properties*' to add property values for NiFi processors. Ensure that:
- Each custom property contains a distinct property value so that it is not overridden by existing environment properties, system properties, or FlowFile attributes.
- Each node in a clustered environment is configured with the same custom properties(applicable for the clustered environments).
- Update *nifi.variable.registry.properties* in *nifi.properties* file with the location of the custom property file(s)
- Restart your NiFi instance(s) for the updates to be picked up.
### Create database and table
You can find script.sql file in this folder which can be used to create database 'logger_data_db' and table 'logger_data' in MySQL.
### Kafka single node setup
For this demo, we will use a single machine with one broker and replication factor also as 1.
#### Prerequisites
- have java >= 1.8 installed.
- get binary distribution of Kafka from [here](https://kafka.apache.org/downloads).
#### Setup
Extract the contents of the kafka archive to a convenient place and `cd` into it. The below steps will help to start zookeeper, kafka broker, and topic.

##### Zookeeper
- Edit the config file config/server.properties and change the dataDir entry to someplace that does not get wiped after a reboot. Eg:dataDir=/home/user/tmp/zookeeper
- Start the zookeeper instance with
`$ bin/zookeeper-server-start.sh config/zookeeper.properties`

For windows, `.bat` files are available under "bin/windows".
##### Kafka brokers
- In the config folder there would be a server.properties file. This is the kafka server's config file.
- Run the broker like
`$  bin/kafka-server-start.sh config/server.properties`

##### Create a Kafka topic which is configured in the NiFi
`$ bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic <topicname>`
In our case *topicname* is "high-alarm".
### Start the process group to run nifi processes
You can start individual processes in NiFi one by one for testing the flow or start the entire process group to run the application.
After starting the application you can check the table for new values and based on the condition JSON data will be routed to the Kafka topic. You can view the data by running the client project provided in this folder or using *kafka-console-consumer* To run *kafka-console-consumer*:
`$ bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic <topicname> --from-beginning` 
