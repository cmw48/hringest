#!/bin/bash
# get today's date
FILEDATE=`/bin/date +%y%m%d`
echo $FILEDATE
DUMPFILENAME='newhrdump'$FILEDATE'.sql'
echo $DUMPFILENAME
#cd ~/newHR/dbdumps
#mysqldump -u vivouser -pvivouser12 newhr_cmw48 > $DUMPFILENAME

MUSER="vivouser"
RUSER="root"
MDB="newhr_cmw48"
#MPASS="$1"
MPASS='gMpg5wj3EM8xucVqke'
RPASS="$2"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)
 
if [ $# -ne 2 ]
then
	echo "Usage: $0 {MySQL-User-Password} {MySQL-RootUser-Password}"
	echo "Manipulates HR data in tables."
	exit 1
fi

#mysqldump -u $RUSER -p$RPASS $MDB > /vivo/cmw48/newHR/dbdumps/$DUMPFILENAME

mysqldump -p$MPASS $MDB > /vivo/cmw48/newHR/dbdumps/$DUMPFILENAME

if [ -f /vivo/cmw48/newHR/dbdumps/$DUMPFILENAME ] 
then
        echo 'backed up existing db...'
else
        echo 'problem with backup of existing db, exiting.'
        exit 1
fi


 
TABLES=$($MYSQL -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
 
for t in $TABLES
do
	echo "Deleting $t table from $MDB database..."
	$MYSQL -p$MPASS $MDB -e "drop table $t"
done
#mysql -u $MUSER -p$MPASS $MDB < /home/cmw48/newHR/createfiles/createacadtable
#mysql -u $MUSER -p$MPASS $MDB < /home/cmw48/newHR/createfiles/createbillingtable
#mysql -u $MUSER -p$MPASS $MDB < /home/cmw48/newHR/createfiles/createdegreetable
#mysql -u $MUSER -p$MPASS $MDB < /home/cmw48/newHR/createfiles/createemerttable
mysql -p$MPASS $MDB < /vivo/cmw48/newHR/createfiles/createjobtable
mysql -p$MPASS $MDB < /vivo/cmw48/newHR/createfiles/createpersontable
mysql -p$MPASS $MDB < /vivo/cmw48/newHR/createfiles/createseparatetable
echo "created tables."
mysql -p$MPASS newhr_cmw48 < /vivo/cmw48/ingestScripts/grantall.txt
echo "granted permissions."
#mysqlimport --ignore --ignore-lines=1 -u $RUSER -p$RPASS newhr_cmw48 /home/cmw48/newHR/hr$FILEDATE/vivoacademic
#mysqlimport --ignore --ignore-lines=1 -u $RUSER -p$RPASS newhr_cmw48 /home/cmw48/newHR/hr$FILEDATE/vivobilling
#mysqlimport --ignore-lines=1 -u $RUSER -p$RPASS newhr_cmw48 /home/cmw48/newHR/hr$FILEDATE/vivodegree
#mysqlimport --ignore-lines=1 -u $RUSER -p$RPASS newhr_cmw48 /home/cmw48/newHR/hr$FILEDATE/vivoemeritus
mysqlimport --ignore-lines=1 -p$MPASS newhr_cmw48 /vivo/cmw48/newHR/hr$FILEDATE/vivojob
#mysqlimport --ignore-lines=1 -p$MPASS newhr_cmw48 /vivo/cmw48/newHR/hr$FILEDATE/vivoperson
#LOAD XML LOCAL INFILE 'vivoperson.xml'INTO TABLE vivoperson ROWS IDENTIFIED BY '<person>';
mysqlimport --ignore-lines=1 -p$MPASS newhr_cmw48 /vivo/cmw48/newHR/hr$FILEDATE/vivoseparate
#TODO  incorporate --ignore-lines=1 to pull in data without deleting header rows
echo "imported all tables."
mysql -p$MPASS newhr_cmw48 < /vivo/cmw48/ingestScripts/updatetables.txt
echo "performed table updates."
#need a way to delete header rows or remove from mysql
echo "indexes added."
