#!/usr/bin/env bash
# make a quick dump of all databases into one .sql file

FILENAME="$1" 

usage()
{
	echo "Usage:" "$0" "<filename.sql>" 

}

if [ $# != 1 ]; then
usage
exit
else	
	mysqldump --all-databases > $FILENAME
fi 
