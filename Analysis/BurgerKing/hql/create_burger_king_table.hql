--Create a new table called BKCaseStudy by populating it with records from
--the comments table, where the body has a string inside it similar to
--Whopper and the comment was made in September 2019.


CREATE TABLE BKCaseStudy as 
 SELECT * FROM reddit_comments
WHERE body LIKE '%Whopper%'
OR body LIKE '%WHOPPER%' 
OR body LIKE '%whopper%' 
AND 
created_utc BETWEEN UNIX_TIMESTAMP('2019/09/01', 'yyyy/MM/dd')
 AND 
UNIX_TIMESTAMP('2019/09/30', 'yyyy/MM/dd');

