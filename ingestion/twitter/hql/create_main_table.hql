ADD JAR hdfs:///user/root/json-serde-1.3.8-jar-with-dependencies.jar;
set hive.support.sql11.reserved.keywords=false;
CREATE TABLE IF NOT EXISTS tweets( 
text STRING,
entities STRUCT<
 hashtags:ARRAY<STRUCT<text:STRING>>>,
 user STRUCT<
 screen_name:STRING,
 friends_count:INT,
 followers_count:INT,
 location:STRING,
 verified:BOOLEAN>
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;
