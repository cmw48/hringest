#!/bin/bash
# get today's date

getopts d: opt;

if [ $opt = 'd' ]
 then
  case $opt in
    d)
      FILEDATE=$OPTARG
      echo "-d was triggered, newfiledate: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      FILEDATE=`/bin/date +%y%m%d`
      FILENAMEDATE=`/bin/date +%y-%m-%d`
      echo " -d requires an argument. -d YYMMDD" >&2
      exit 1
      ;;
  esac
 else
  FILEDATE=`/bin/date +%y%m%d`
  FILENAMEDATE=`/bin/date +%y-%m-%d`
  echo "using today's date: $FILEDATE" >&2

fi

BASEDIR="/vivo/hringest/newhr"
FILENAMEDATE=`/bin/date +%y-%m-%d`
FILENAMEEND="20$FILENAMEDATE"
PERSONFILENAME="personHR$FILENAMEEND.xml"
DIRNAME="$BASEDIR/hr$FILEDATE"
TERMFILEBASE="$DIRNAME/terminations"
TERMFILENAME="termsHR20*"
TERMFILES=$TERMFILEBASE$TERMFILENAME
JOBFILENAME="jobHR$FILENAMEEND.xml"
echo "file directory - $DIRNAME"
echo "filename = $JOBFILENAME" 
echo "$PERSONFILENAME"
echo "$TERMFILENAME"

cd $DIRNAME
echo 'transforming job data...'
java -jar $BASEDIR/saxon/saxon9he.jar $JOBFILENAME  $BASEDIR/hrxsl/vivojobAlignToD2R.xsl > vivojob$FILEDATE.xml
sleep 10
java -jar $BASEDIR/saxon/saxon9he.jar vivojob$FILEDATE.xml  $BASEDIR/hrxsl/vivojobToMySql.xsl > vivojob$FILEDATE.sql
echo 'transforming person data...'
java -jar $BASEDIR/saxon/saxon9he.jar $PERSONFILENAME  $BASEDIR/hrxsl/vivopersonAlignToD2R.xsl > vivoperson$FILEDATE.xml
sleep 10
java -jar $BASEDIR/saxon/saxon9he.jar vivoperson$FILEDATE.xml  $BASEDIR/hrxsl/vivopersonToMySql.xsl > vivoperson$FILEDATE.sql
echo 'transforming termination data...'

MPASS='gMpg5wj3EM8xucVqke'
echo 'loading mySQL database...'

cd $TERMFILEBASE
for f in *

 do echo "Processing termination file $f.."
    java -jar $BASEDIR/saxon/saxon9he.jar $f  $BASEDIR/hrxsl/vivotermAlignToD2R.xsl > $DIRNAME/d2r$f
    sleep 10
    java -jar $BASEDIR/saxon/saxon9he.jar $DIRNAME/d2r$f $BASEDIR/hrxsl/vivotermToMySql.xsl > $DIRNAME/sql$f
    sleep 10
    echo 'processing vivoterm data...'
    mysql -p$MPASS newhr_cmw48 < $DIRNAME/sql$f
    sleep 10
done 
cd ..

echo 'processing vivoperson data...'
mysql -p$MPASS newhr_cmw48 < $DIRNAME/vivoperson$FILEDATE.sql
sleep 10
echo 'processing vivojob data...'
mysql -p$MPASS newhr_cmw48 < $DIRNAME/vivojob$FILEDATE.sql
sleep 10
echo 'hr load request complete.'
