STAT=`netstat -na | grep 8080 | awk '{print $6}'`
echo $STAT
if [ "$STAT" = "LISTEN" ]; then
echo "tomcat on 8080 is listening..."
elif [ "$STAT" = "" ]; then 
echo "tomcat not running on 8080, starting tomcat"
## only if you defined CATALINA_HOME in JAVA ENV ##
cd /usr/local/tomcat/bin
./startup.sh
fi
RESULT=`netstat -na | grep 8080 | awk '{print $6}' | wc -l`
echo "Response code " $RESULT
if [ "$RESULT" = 0 ]; then
echo "tomcat still not listening on 8080..."
elif [ "$RESULT" != 0 ]; then
echo "tomcat is now running on 8080..."
fi
