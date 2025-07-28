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

- Go inside **master container's CLI** 

💡 **Start the HDFS - YARN services:**  
```sh
  start-dfs.sh
  start-yarn.sh
```

<img width="1314" height="379" alt="image" src="https://github.com/user-attachments/assets/7af37d5d-9d81-4f67-984b-e9abea9fc385" />


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
<img width="1333" height="150" alt="image" src="https://github.com/user-attachments/assets/7227c0a0-cb5c-41dc-b16e-ee1e7a507ec8" />

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

<img width="1919" height="578" alt="image" src="https://github.com/user-attachments/assets/110664fa-a831-431f-8792-015af185464f" />
<img width="1919" height="928" alt="image" src="https://github.com/user-attachments/assets/013cf97f-8e88-482c-9726-b1bb5216deb0" />

---

## 📞 **Contact**  
📧 Email: [quochuy.working@gmail.com](mailto:quochuy.working@gmail.com)

💬 Feel free to contribute and improve this project! 🚀
