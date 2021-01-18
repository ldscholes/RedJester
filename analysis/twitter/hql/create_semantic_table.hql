CREATE TABLE IF NOT EXISTS twitter_semantic LIKE tweets;
ALTER TABLE twitter ADD COLUMNS (semantic_score int);
