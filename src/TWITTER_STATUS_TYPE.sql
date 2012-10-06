CREATE OR REPLACE TYPE TWITTER_STATUS_TYPE AS OBJECT (
  id INTEGER,
  created_at TIMESTAMP,
  text VARCHAR2(1000),
  source VARCHAR2(1000),
  truncated VARCHAR2(5),
  favorited VARCHAR2(5),
  in_reply_to_status_id INTEGER,
  in_reply_to_user_id INTEGER,
  in_reply_to_screen_name VARCHAR2(100),
  retweet_count INTEGER,
  retweeted VARCHAR2(5),
  user_id INTEGER,
  user_name VARCHAR2(100),
  screen_name VARCHAR2(100)
);
/

