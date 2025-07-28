# Base Image
FROM base

USER spark-user
WORKDIR /home/spark-user


# Copy Hadoop configuration files
COPY config/worker/hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml

# Start SSH and Hadoop services at runtime
USER root


COPY config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
