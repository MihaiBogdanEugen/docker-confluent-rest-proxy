FROM mbe1224/confluent-osp-base:jesse-slim-8u144-2.11.11-3.3.0

ENV COMPONENT=kafka-rest

# default listener
EXPOSE 8082

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-${COMPONENT}=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && chmod -R ag+w /etc/${COMPONENT} \
    && mkdir -p /etc/confluent/docker \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/admin.properties.template" -O "/etc/confluent/docker/admin.properties.template" \
    && echo "bd56fc2112f10142544b5777f28f87110e4ed508286de625386d66eb43e12496" "/etc/confluent/docker/admin.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/apply-mesos-overrides" -O "/etc/confluent/docker/apply-mesos-overrides" \
    && echo "126b51bca84a50759a554d2c032c08158e9189c8da6ec1edfde153289048c396" "/etc/confluent/docker/apply-mesos-overrides" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && echo "b3ab69096af25a86d8090bd5e40feab14b1268e84fa5ca2b90fddba7e8325e17" "/etc/confluent/docker/configure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && echo "e73f2959f8fd411068196bc2a12d147b458e8f35fb1445cbd035762c84fb7481" "/etc/confluent/docker/ensure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && echo "047d5c09430951fc92e9eca1e3ab26592fe44cfb3795273653013b1b7d327703" "/etc/confluent/docker/launch" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && echo "253a208c671a9b3afe63340ca9bd9c740aec1ee9a67604081f122498111d08f5" "/etc/confluent/docker/log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && echo "8499f919a9fc31f7cac5b5fd8998fabeea7debc3518e02cbe2854faa2ca73b31" "/etc/confluent/docker/run" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.3.x-quickstart-fix/debian/kafka-rest/include/etc/confluent/docker/kafka-rest.properties.template" -O "/etc/confluent/docker/kafka-rest.properties.template" \
    && echo "979116770bdfa471b5276edf2b4a1666f7a14f3e089ec8d7a3ad0051ef05e212" "/etc/confluent/docker/kafka-rest.properties.template" | sha256sum -c -


CMD ["/etc/confluent/docker/run"]