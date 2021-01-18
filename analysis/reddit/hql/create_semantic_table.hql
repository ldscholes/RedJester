CREATE TABLE IF NOT EXISTS reddit_semantic LIKE reddit_comments;
ALTER TABLE reddit_semantic ADD COLUMNS (semantic_score int);
