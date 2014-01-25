#!/bin/bash
# get today's date
FILEDATE=`/bin/date +%y%m%d`

while getopts ":d:" opt; do
  case $opt in
    a)
      echo "-d was triggered, newfiledate: $FILEDATE" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      FILEDATE=`/bin/date +%y%m%d`
      echo " no argument. using today's date: $FILEDATE" >&2
      exit 1
      ;;
  esac
done
exit 1


BACKUPFILE="/vivo/cmw48/vivoNightly$FILEDATE"
BACKUPFILENAME="$BACKUPFILE.sql"
echo $BACKUPFILENAME
 
STAT=`netstat -na | grep 8080 | awk '{print $6}'`
echo $STAT
if [ "$STAT" = "LISTEN" ]; then
echo "tomcat on 8080 is listening..."
elif [ "$STAT" = "" ]; then 
echo "tomcat not running on 8080."
## only if you defined CATALINA_HOME in JAVA ENV ##
##cd /usr/local/tomcat/bin
##./startup.sh
fi
RESULT=`netstat -na | grep 8080 | awk '{print $6}' | wc -l`
echo $RESULT
if [ "$RESULT" = 0 ]; then
echo "tomcat still not listening on 8080..."
elif [ "$RESULT" != 0 ]; then
echo "tomcat is running on 8080, shutting down..."
cd /usr/local/tomcat/bin
./shutdown.sh
fi

MPASS='gMpg5wj3EM8xucVqke'
echo 'clearing existing mySQL database...'
mysql -u root -p$MPASS < /vivo/cmw48/ingestScripts/reloadVivomigrate.sql
echo 'loading nightly backup...'
sleep 10
mysql -u root -p$MPASS vivom01 < $BACKUPFILENAME
echo 'backup load request complete.'
sleep 10
cd /usr/local/tomcat/bin
./startup.sh
echo 'tomcat started.'
