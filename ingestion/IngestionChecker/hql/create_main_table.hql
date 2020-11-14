CREATE TABLE IF NOT EXISTS ingestion_checker( 
source string,  
filename string,  
size int,
hash string)
STORED AS TEXTFILE;
