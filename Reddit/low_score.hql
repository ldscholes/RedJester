select min(score) from reddit_comments;
select author, body from reddit_comments where score = <value from above>;
