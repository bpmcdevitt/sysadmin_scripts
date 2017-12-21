#!/usr/bin/env bash
# rfc commandline shell script
# requirements curl - https://curl.haxx.se/download.html

base_url="https://www.rfc-editor.org/in-notes"
index_local="/home/booboy/bin/mygit/rfc/rfc-index.txt"
index_remote="$base_url/rfc-index.txt"

function usage {
    echo    "Index File: $index_local"
    echo -e " - if there is no index file, please run the index command to download the file. \n"
    echo    "Usage: $0 <index>"  
    echo -e "- returns the index of rfc. \n"
    echo    "Usage: $0 <rfc number>"
    echo -e "- returns rfc number. \n"
}

if [ "$#" -ne "1" ]; then
    usage
    exit
fi

rfc_number="$1"

if [[ "$rfc_number" == "$(grep ^$rfc_number $index_local | awk ' { print $1 } ')" ]] ; then
    rfc_number="$rfc_number"
    request="$base_url"'/''rfc'"${rfc_number}.txt"
else
    rfc_number=""
    rfc_number_invalid="Sorry, That RFC does not exist yet."
fi

case "$1" in 
        "help")
                usage;;
        "--help")
                usage;;
        "index")
            curl "$index_remote" 2> /dev/null;;
        "$rfc_number")
            curl "$request" 2> /dev/null;;
        *)
            echo "$rfc_number_invalid";;
esac
