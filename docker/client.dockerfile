# Base Image
FROM base

USER spark-user
WORKDIR /home/spark-user

# Copy spark configuration files
COPY config/client/spark-defaults.conf spark/conf/spark-defaults.conf


# Start SSH and Hadoop services
CMD ["/bin/bash", "-c", "service ssh start && su - spark-user && bash"]
