CREATE OR REPLACE FUNCTION GET_TWITTER_PUBLIC_TIMELINE
RETURN TWITTER_STATUSES PIPELINED
/*
  GET_TWITTER_PUBLIC_TIMELINE

  Get Twitter posts from Twitter Public Timeline and return them as a table.
*/
IS
  url VARCHAR2(4000) := 'http://api.twitter.com/1/statuses/public_timeline.xml';
  request UTL_HTTP.REQ;
  response UTL_HTTP.RESP;
  buff VARCHAR2(4000);
  response_data CLOB;

  CURSOR TW_STATUS(xmlbody CLOB)
  IS
    SELECT
      X.*
    FROM
      XMLTABLE('/statuses/status'
        PASSING XMLTYPE(xmlbody)
        COLUMNS
          id VARCHAR2(100) PATH 'id',
          created_at VARCHAR2(100) PATH 'created_at',
          text VARCHAR2(1000) PATH 'text',
          source VARCHAR2(1000) PATH 'source',
          truncated VARCHAR2(5) PATH 'truncated',
          favorited VARCHAR2(5) PATH 'favorited',
          in_reply_to_status_id VARCHAR2(100) PATH 'in_reply_to_status_id',
          in_reply_to_user_id VARCHAR2(100) PATH 'in_reply_to_user_id',
          in_reply_to_screen_name VARCHAR2(100) PATH 'in_reply_to_screen_name',
          retweet_count VARCHAR2(100) PATH 'retweet_count',
          retweeted VARCHAR2(5) PATH 'retweeted',
          user_id VARCHAR2(100) PATH 'user/id',
          user_name VARCHAR2(100) PATH 'user/name',
          screen_name VARCHAR2(100) PATH 'user/screen_name'
      ) X;

BEGIN
  UTL_HTTP.SET_RESPONSE_ERROR_CHECK(FALSE);
  request := UTL_HTTP.BEGIN_REQUEST(url, 'GET');
  UTL_HTTP.SET_HEADER(request, 'User-Agent', 'Mozilla/4.0');
  response := UTL_HTTP.GET_RESPONSE(request);

  IF response.status_code = 200 THEN
    BEGIN
      response_data := EMPTY_CLOB;
      LOOP
        UTL_HTTP.READ_TEXT(response, buff, LENGTH(buff));
        response_data := response_data || buff;
      END LOOP;
      UTL_HTTP.END_RESPONSE(response);
    EXCEPTION
      WHEN UTL_HTTP.END_OF_BODY THEN
        UTL_HTTP.END_RESPONSE(response);
      WHEN OTHERS THEN
        UTL_HTTP.END_RESPONSE(response);
        RAISE;
    END;
  ELSE
    UTL_HTTP.END_RESPONSE(response);
    RETURN;
  END IF;

  FOR rec IN TW_STATUS(response_data) LOOP
    PIPE ROW(TWITTER_STATUS_TYPE(
      TO_NUMBER(rec.id),
      TO_TIMESTAMP_TZ(rec.created_at, 'Dy Mon DD HH24:MI:SS TZHTZM YYYY', 'NLS_DATE_LANGUAGE = AMERICAN'),
      rec.text,
      rec.source,
      rec.truncated,
      rec.favorited,
      TO_NUMBER(rec.in_reply_to_status_id),
      TO_NUMBER(rec.in_reply_to_user_id),
      rec.in_reply_to_screen_name,
      TO_NUMBER(rec.retweet_count),
      rec.retweeted,
      TO_NUMBER(rec.user_id),
      rec.user_name,
      rec.screen_name
    ));
  END LOOP;

  RETURN;
END GET_TWITTER_PUBLIC_TIMELINE;
/

