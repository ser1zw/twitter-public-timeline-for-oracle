/*
  Install script for SQL*Plus

  Usage:
    Run the following command in the shell on your DB server.

    $ sqlplus YOUR-USER-NAME/YOUR-PASSWORD@localhost:1521/XE @install.sql
*/
@src/TWITTER_STATUS_TYPE
@src/TWITTER_STATUSES
@src/GET_TWITTER_PUBLIC_TIMELINE
@src/TWITTER_PUBLIC_TIMELINE
EXIT;

