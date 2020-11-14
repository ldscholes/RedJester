SELECT COUNT(*) FROM reddit_comments limit 1; 
SELECT COUNT(*) FROM reddit_update limit 1; 
INSERT INTO TABLE reddit_comments
  SELECT * FROM reddit_update; 
SELECT COUNT(*) FROM reddit_comments limit 1; 
