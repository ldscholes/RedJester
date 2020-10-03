CREATE TABLE IF NOT EXISTS reddit_comments( 
author string,  
author_flair_css_class string,  
author_flair_text string,  
body string,  
can_gild string,  
controversiality string,  
created_utc int,  
distinguished string,  
edited string,  
gilded string,  
id string,  
is_submitter string,  
link_id string,  
parent_id string,  
permalink string,  
retrieved_on int,  
score int,  
stickied string,  
subreddit string,  
subreddit_id string)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;
