/*
  Uninstall script for SQL*Plus

  Usage:
    Run the following command in the shell on your DB server.

    $ sqlplus YOUR-USER-NAME/YOUR-PASSWORD@localhost:1521/XE @uninstall.sql
*/
DROP VIEW TWITTER_PUBLIC_TIMELINE;
DROP FUNCTION GET_TWITTER_PUBLIC_TIMELINE;
DROP TYPE TWITTER_STATUSES;
DROP TYPE TWITTER_STATUS_TYPE;
EXIT

