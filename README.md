# [Confluent Open Source Platform](https://www.confluent.io/product/confluent-open-source/) [REST Proxy] Docker image using [Oracle JDK] #

### Supported tags and respective Dockerfile links: ###

* ```jesse-slim-8u144-2.11.11-3.2.2``` _\([jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-rest-proxy:jesse-slim-8u144-2.11.11-3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-osp-rest-proxy:jesse-slim-8u144-2.11.11-3.2.2)
* ```jesse-slim-8u144-2.11.11-3.3.0```, ```latest``` _\([jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-rest-proxy:jesse-slim-8u144-2.11.11-3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-osp-rest-proxy:jesse-slim-8u144-2.11.11-3.3.0)

#### All tag names follow the naming convention: ####

```debian_image_tag``` + '-' + ```java_version``` + '-' + ```scala_version``` + '-' + ```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle Java SE Development Kit (JDK) 8u144 addded, without MissionControl, VisualVM, JavaFX and JRE
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')]
    - [Docker utility belt script ('dub')]
- [Confluent Schema Registry] added

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```jesse-slim-8u144-2.11.11-3.2.2``` follows branch [3.2.x], and 
- tags ```jesse-slim-8u144-2.11.11-3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-osp-base]), it has [Schema Registry] added on top of it, installed using the following Confluent Debian package:
- ```confluent-schema-registry-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-osp-rest-proxy .
```

Run the container
```shell
docker run -d \
    --net=host \
    --name=kafka-rest \
    -e KAFKA_REST_ZOOKEEPER_CONNECT=localhost:32181 \
    -e KAFKA_REST_LISTENERS=http://localhost:8082 \
    -e KAFKA_REST_SCHEMA_REGISTRY_URL=http://localhost:8081 \
    mbe1224/confluent-osp-rest-proxy
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | KAFKA\_REST\_CUB\_KAFKA\_MIN\_BROKERS | 1 | Expected number of brokers in the cluster | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 2 | KAFKA\_REST\_CUB\_KAFKA\_TIMEOUT | 40 | Time in secs to wait for the number of Kafka nodes to be available. | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 3 | KAFKA\_REST\_CUB\_ZK\_TIMEOUT | 40 | Time in secondss to wait for the Zookeeper to be available | Check the [Confluent utility belt script ('cub')] - ```check_zookeeper_ready``` for more details |
| 4 | KAFKA\_REST\_HOST\_NAME | - | The host name used to generate absolute URLs in responses | Required |
| 5 | KAFKA\_REST\_ID | - | Unique ID for this REST server instance | This is used in generating unique IDs for consumers that do not specify their ID. The ID is empty by default, which makes a single server setup easier to get up and running, but is not safe for multi-server deployments where automatic consumer IDs are used |
| 6 | KAFKA\_REST\_JMX\_OPTS | - | JMX options used for monitoring | KAFKA\_REST\_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property |
| 7 | KAFKA\_REST\_LISTENERS | 8082 | Port for incomming connections | - |
| 8 | KAFKA\_REST\_LOG4J\_LOGGERS | - | - | - |
| 9 | KAFKA\_REST\_LOG4J\_ROOT\_LOGLEVEL | INFO | - | - |
| 10 | KAFKA\_REST\_PORT | - | Port for incomming connections | Deprecated, use KAFKA\_REST\_LISTENERS instead |
| 11 | KAFKA\_REST\_ZOOKEEPER\_CONNECT | - | Specifies the ZooKeeper connection string in the form hostname:port where host and port are the host and port of a ZooKeeper server | To allow connecting through other ZooKeeper nodes when that ZooKeeper machine is down you can also specify multiple hosts in the form hostname1:port1,hostname2:port2,hostname3:port3 |

Apart from these, one can use any of the properties specified in the [Configuration Options] by replacing "." with "\_" and appending "KAFKA\_REST\_" before the property name. For example, instead of ```schema.registry.url``` use ```KAFKA_REST_SCHEMA_REGISTRY_URL```.

### Dual licensed under: ###

* [Apache License]
* [Oracle Binary Code License Agreement]

   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [REST Proxy]: <http://docs.confluent.io/current/kafka-rest/docs/index.html>   
   [Confluent REST Proxy]: <http://docs.confluent.io/current/kafka-rest/docs/index.html>   
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-rest-proxy/blob/jesse-slim-8u144-2.11.11-3.2.2/Dockerfile>
   [jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-rest-proxy/blob/jesse-slim-8u144-2.11.11-3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-osp-base]: <https://hub.docker.com/r/mbe1224/confluent-osp-base/>
   [Configuration Options]: <http://docs.confluent.io/current/kafka-rest/docs/config.html>
   [Apache License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-rest-proxy/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-rest-proxy/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>