# Base Image
FROM base

USER spark-user
WORKDIR /home/spark-user

# Copy Hadoop configuration files
COPY    config/master/hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml
COPY    config/master/workers hadoop/etc/hadoop/workers

# format hdfs
RUN /home/spark-user/hadoop/bin/hdfs namenode -format
# Start SSH and Hadoop services
USER root


COPY config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]