SELECT COUNT(*) FROM reddit_semantic limit 1; 
SELECT COUNT(*) FROM reddit_comments where id NOT IN (select id from reddit_semantic) limit 1; 
INSERT INTO TABLE reddit_semantic
  SELECT * FROM reddit_comments where id NOT IN (select id from reddit_semantic) ; 
SELECT COUNT(*) FROM reddit_semantic limit 1; 