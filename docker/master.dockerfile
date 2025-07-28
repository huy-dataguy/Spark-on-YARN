# Base Image
FROM base

USER spark-user
WORKDIR /home/spark-user

# Copy Hadoop configuration files
COPY    config/master/hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml && \
        config/master/workers hadoop/etc/hadoop/workers


# Format HDFS
USER spark-user
RUN hdfs namenode -format

# Start SSH and Hadoop services
CMD ["/bin/bash", "-c", "service ssh start && su - spark-user && bash"]
