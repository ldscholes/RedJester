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
