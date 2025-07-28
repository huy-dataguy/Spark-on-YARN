## 🏢 Spark on YARN Architecture Client Mode
  ![image](https://github.com/user-attachments/assets/f0823592-32f3-43a9-9f48-9b5456fb685c)

## 🚀 **Installation Guide**  

#### **Step 1: Clone the Repository**  
```sh
  git clone https://github.com/huy-dataguy/Spark-on-YARN.git
  cd Spark-on-YARN
```

#### **Step 2: Build Image Base**  
> **⏳ Note:** The first build may take a few minutes as no cached layers exist.

```sh
  docker build -t base -f docker/base.dockerfile .
```

#### **Step 3: Build and Start Cluster**  
- build image (build in the first time or after make changes in dockerfile)

```sh
  docker compose -f docker/compose.yaml build
```

- run container

```sh
  docker compose -f docker/compose.yaml up -d
```


#### **Step 4: Verify the Installation**  

- 1. Go inside **master container's CLI** 

💡 **Start the HDFS - YARN services:**  
```sh
  start-dfs.sh
  start-yarn.sh
```
  ![image](https://github.com/user-attachments/assets/65e9f6c1-082a-4471-8ba2-39a3a99c9585)
  ![livedatanote](https://github.com/user-attachments/assets/b0c60eaf-86a1-4b6d-a939-c3241cc6d699)
  ![yarn](https://github.com/user-attachments/assets/da3a7da5-100b-465f-8d1d-4f57ac9574a5)


#### **Step 5: Run Spark Submit on Yarn Client Mode** 

Create folder store spark logs
```sh
  hdfs dfs -mkdir /spark-logs
```
Run spark on yarn
```sh
  spark-submit \
  --class org.apache.spark.examples.SparkPi \
  $SPARK_HOME/examples/jars/spark-examples_*.jar 10
```
If success you will see answear **Pi = 3,14159**
  
---

## 🌐 Interact with the Web UI  

You can access the following web interfaces to monitor and manage your Hadoop cluster:  

- **YARN Resource Manager UI** → [http://localhost:9004](http://localhost:9004)  
  Provides an overview of cluster resource usage, running applications, and job details.  

- **NameNode UI** → [http://localhost:9870](http://localhost:9870)  
  Displays HDFS file system details, block distribution, and overall health status.

- **Spark Web UI** → [http://localhost:4040](http://localhost:4040)
  Provides an interface to monitor running Spark jobs, stages, and tasks.
  Note: Because you are using YARN client mode, the Spark UI will automatically redirect to the master node's web UI.
---

## 📞 **Contact**  
📧 Email: [quochuy.working@gmail.com](mailto:quochuy.working@gmail.com)

💬 Feel free to contribute and improve this project! 🚀
