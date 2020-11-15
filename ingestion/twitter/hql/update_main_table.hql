ADD JAR hdfs:///user/root/json-serde-1.3.8-jar-with-dependencies.jar;
set hive.support.sql11.reserved.keywords=false;
SELECT COUNT(*) FROM tweets limit 1; 
SELECT COUNT(*) FROM twitter_update limit 1; 
INSERT INTO TABLE tweets
  SELECT * FROM twitter_update; 
SELECT COUNT(*) FROM tweets limit 1; 
