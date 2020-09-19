SELECT COUNT(*) FROM reddit_comments; 
SELECT COUNT(*) FROM reddit_update; 
INSERT INTO TABLE reddit_comments
  SELECT * FROM reddit_update; 
SELECT COUNT(*) FROM reddit_comments; 
