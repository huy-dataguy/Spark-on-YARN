# Base Image
FROM ubuntu:22.04

# Set root password
RUN echo "root:root" | chpasswd

# Update and install required packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openjdk-11-jdk wget ssh openssh-server dos2unix vim sudo telnet iputils-ping && \
    apt-get clean



# Create user spark-user
RUN adduser --disabled-password --gecos "" spark-user && \
    echo "spark-user:spark-user" | chpasswd && \
    usermod -aG sudo spark-user && \
    echo "spark-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER spark-user

WORKDIR /home/spark-user
# Install Hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz && \
    tar -xzf hadoop-3.4.1.tar.gz && \
    mv hadoop-3.4.1 hadoop && \
    rm hadoop-3.4.1.tar.gz

# Install SPARK

RUN wget https://dlcdn.apache.org/spark/spark-3.5.6/spark-3.5.6-bin-without-hadoop.tgz && \
    tar -xvzf spark-3.5.6-bin-without-hadoop.tgz && \
    mv spark-3.5.6-bin-without-hadoop spark && \
    rm spark-3.5.6-bin-without-hadoop.tgz

# Setup env
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64'>>~/.bashrc
RUN echo 'export HADOOP_HOME=/home/spark-user/hadoop'>>~/.bashrc
RUN echo 'export SPARK_HOME=/home/spark-user/spark'>>~/.bashrc
RUN echo 'export PATH=$PATH:$HADOOP_HOME/sbin' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> ~/.bashrc

RUN echo 'export PATH=$PATH:$SPARK_HOME/bin'>>~/.bashrc
RUN echo 'export PATH=$PATH:$SPARK_HOME/sbin'>>~/.bashrc
RUN echo 'export PATH=$PATH:$SPARK_HOME/jars'>>~/.bashrc



RUN echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME'>>~/.bashrc
RUN echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME'>>~/.bashrc
RUN echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME'>>~/.bashrc
RUN echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop'>>~/.bashrc
RUN echo 'export HADOOP_YARN_HOME=$HADOOP_HOME'>>~/.bashrc
RUN echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native'>>~/.bashrc
RUN echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"'>>~/.bashrc

RUN echo 'export SPARK_DIST_CLASSPATH="$(hadoop classpath)"'>>~/.bashrc

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64'>> hadoop/etc/hadoop/hadoop-env.sh


# create ssh for all server with the same key

RUN mkdir -p /home/spark-user/.ssh && \
    ssh-keygen -t rsa -P '' -f /home/spark-user/.ssh/id_rsa && \
    cat /home/spark-user/.ssh/id_rsa.pub >> /home/spark-user/.ssh/authorized_keys && \
    chmod 600 /home/spark-user/.ssh/authorized_keys && \
    chown -R spark-user:spark-user /home/spark-user/.ssh

USER spark-user

WORKDIR /home/spark-user
# copy file config hadoop to container
COPY    config/base/core-site.xml /home/spark-user/hadoop/etc/hadoop/core-site.xml 
COPY    config/base/mapred-site.xml /home/spark-user/hadoop/etc/hadoop/mapred-site.xml 
COPY    config/base/yarn-site.xml /home/spark-user/hadoop/etc/hadoop/yarn-site.xml

