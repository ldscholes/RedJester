--Display the specified columns for all the rows from the Burger King table if 
--the comment was created on the 29th of September 2019 

SELECT created_utc,
subreddit, 
author, 
score, 
body 
FROM BKCaseStudy 
WHERE 
to_DATE(FROM_UNIXTIME(created_utc)) = '2019-09-29'; 