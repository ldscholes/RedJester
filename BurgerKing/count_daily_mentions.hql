--count_daily_mentions
SELECT DAY(FROM_UNIXTIME(created_utc)) AS comment_day, COUNT(*) AS mentions FROM BKCaseStudy GROUP BY DAY(FROM_UNIXTIME(created_utc));
