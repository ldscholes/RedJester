#!/bin/bash
hive -e "SELECT created_utc, subreddit, author, score, body FROM BKCaseStudy WHERE to_DATE(FROM_UNIXTIME(created_utc)) = '2019-09-29'" > bk_rc_2019_09_29.csv
