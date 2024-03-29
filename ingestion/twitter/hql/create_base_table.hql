ADD JAR hdfs:///user/root/json-serde-1.3.8-jar-with-dependencies.jar;
set hive.support.sql11.reserved.keywords=false;
DROP TABLE twitter_update;
CREATE EXTERNAL TABLE if NOT EXISTS twitter_update(
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
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '/apps/hive/warehouse/twitter_update';

