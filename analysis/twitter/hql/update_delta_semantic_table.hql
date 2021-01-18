SELECT COUNT(*) FROM twitter_semantic limit 1; 
SELECT COUNT(*) FROM twitter_comments where id NOT IN (select id from twitter_semantic) limit 1; 
INSERT INTO TABLE twitter_semantic SELECT *, 0 as semantic_score from twitter_comments where id NOT IN (select id from twitter_semantic); 
SELECT COUNT(*) FROM twitter_semantic limit 1; 
