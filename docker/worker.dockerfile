# Base Image
FROM base

USER spark-user
WORKDIR /home/spark-user


# Copy Hadoop configuration files
COPY config/worker/hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml

# Start SSH and Hadoop services at runtime
CMD ["/bin/bash", "-c", "service ssh start && su - spark-user && bash"]
