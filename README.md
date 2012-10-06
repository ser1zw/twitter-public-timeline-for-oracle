# Twitter Public timeline for Oracle

Provides a view for Oracle database that fetches and returns tweets from Twitter public timeline.
You can `SELECT` Twitter public timeline as below:

```sql
SELECT created_at, screen_name, text FROM TWITTER_PUBLIC_TIMELINE WHERE LOWER(text) LIKE '%http%';
```

Note that this library will not work on [Twitter API v1.1](https://dev.twitter.com/docs/api/1.1/overview) because of [dropping XML support](https://dev.twitter.com/docs/api/1.1/overview#JSON_support_only) and [requiring authentication with OAuth](https://dev.twitter.com/docs/api/1.1/overview#Authentication_required_on_all_endpoints).  
This library gets timeline with XML API and is not authenticated.


## Requirement
* Oracle Database 11g Release 2
  * Tested on 11g R2 Express Edition for Linux x64

## Install
### 1. Setup UTL_HTTP package

Execute **$ORACLE\_HOME/rdbms/admin/utlhttp.sql** to enable UTL\_HTTP package.  
Run the following commands in the shell on your DB server.
<pre>
$ cd $ORACLE_HOME/rdbms/admin
$ sqlplus SYS/YOUR-PASSWORD@localhost:1521/XE AS SYSDBA @utlhttp.sql
</pre>

### 2. Setup the network Access Control List (ACL)

On Oracle 11g, the network access configuration is required to use UTL\_HTTP package.  
  
The following code is an example to grant the connect and resolve privileges for host **api.twitter.com** to user **SCOTT**.  
Replace **'SCOTT'** to your user name and run the following codes in SQL*Plus.

```sql
DECLARE
  user VARCHAR2(30) := 'SCOTT'; -- *Enter your user name*
BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL('www.xml', 'WWW ACL', user, TRUE, 'connect');
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE('www.xml', user, TRUE, 'resolve');
  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL('www.xml', 'api.twitter.com');
END;
```

For more information, see [this document](http://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_networkacl_adm.htm).


### 3. Install Twitter Public timeline for Oracle

Execute **install.sql**.  
Run the following commands in the shell on your DB server.
<pre>
$ sqlplus YOUR-USER-NAME/YOUR-PASSWORD@localhost:1521/XE @install.sql
</pre>


## Usage
Query to **TWITTER\_PUBLIC\_TIMELINE** view.

```sql
SELECT created_at, screen_name, text FROM TWITTER_PUBLIC_TIMELINE;
```

Columns of **TWITTER\_PUBLIC\_TIMELINE** is the following.
<table>
  <tr><td>ID</td><td>NUMBER</td></tr>
  <tr><td>CREATED_AT</td><td>TIMESTAMP(6)</td></tr>
  <tr><td>TEXT</td><td>VARCHAR2(1000)</td></tr>
  <tr><td>SOURCE</td><td>VARCHAR2(1000)</td></tr>
  <tr><td>TRUNCATED</td><td>VARCHAR2(5)</td></tr>
  <tr><td>FAVORITED</td><td>VARCHAR2(5)</td></tr>
  <tr><td>IN_REPLY_TO_STATUS_ID</td><td>NUMBER</td></tr>
  <tr><td>IN_REPLY_TO_USER_ID</td><td>NUMBER</td></tr>
  <tr><td>IN_REPLY_TO_SCREEN_NAME</td><td>VARCHAR2(100)</td></tr>
  <tr><td>RETWEET_COUNT</td><td>NUMBER</td></tr>
  <tr><td>RETWEETED</td><td>VARCHAR2(5)</td></tr>
  <tr><td>USER_ID</td><td>NUMBER</td></tr>
  <tr><td>USER_NAME</td><td>VARCHAR2(100)</td></tr>
  <tr><td>SCREEN_NAME</td><td>VARCHAR2(100)</td></tr>
</table>

## Uninstall
Run **uninstall.sql**.  
<pre>
$ sqlplus YOUR-USER-NAME/YOUR-PASSWORD@localhost:1521/XE @uninstall.sql
</pre>


## License
This project is released under the MIT license:  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)

