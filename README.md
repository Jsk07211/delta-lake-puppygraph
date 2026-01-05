## Unity Catalog Preparation
### Starting Server
▶️ Build Unity Catalog from Open Source

```
git clone https://github.com/unitycatalog/unitycatalog
cd unitycatalog
build/sbt package
```
▶️ Run the following command under the same `unitycatalog` folder to start a Unity Catalog server at port `9000`

### Data Preparation
This tutorial is designed to be comprehensive and standalone, so it includes steps to populate local tables with Unity Catalog

Set Up Unity Catalog
```
docker compose up -d
chmod +x create.sh
./create.sh 
docker compose exec spark bash -lc '/opt/spark/bin/spark-sql -f /sql/load_to_delta.sql' 2>&1 debug.log
```

docker compose down --remove-orphans

# Working Version
```
cd ..
git clone https://github.com/unitycatalog/unitycatalog
cd unitycatalog
build/sbt clean package publishLocal

cp ../delta-lake-puppygraph/create_tables.sh unitycatalog/
./bin/start-uc-server -p 9000
```

In a separate terminal:
```
cd /path/to/unitycatalog
./create_tables.sh
```
```
mkdir spark
curl -O https://dlcdn.apache.org/spark/spark-3.5.7/spark-3.5.7-bin-hadoop3.tgz && \
    tar -xf spark-3.5.7-bin-hadoop3.tgz -C spark --strip-components=1 && \
    rm spark-3.5.7-bin-hadoop3.tgz

./bin/spark-sql \
  --packages \
    io.delta:delta-spark_2.12:3.2.0,io.unitycatalog:unitycatalog-spark_2.12:0.2.1 \
  --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension \
  --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog \
  --conf spark.sql.catalog.puppygraph=io.unitycatalog.spark.UCSingleCatalog \
  --conf spark.sql.catalog.puppygraph.uri=http://localhost:9000
```

Run `create_tables.sh` in unitycatalog dir, and `load.sql` via spark (`./bin/spark-sql -f load.sql`)
* TODO: Create a script to generate `load.sql`