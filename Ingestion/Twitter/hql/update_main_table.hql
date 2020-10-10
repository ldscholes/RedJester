SELECT COUNT(*) FROM tweets limit 1; 
SELECT COUNT(*) FROM twitter_update limit 1; 
INSERT INTO TABLE tweets
  SELECT * FROM twitter_update; 
SELECT COUNT(*) FROM tweets limit 1; 
