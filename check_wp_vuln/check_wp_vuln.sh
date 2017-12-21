#!/usr/bin/env bash
# query wpvuln db for vulnerabilities

function plugin {

	curl https://wpvulndb.com/api/v2/plugins/$1 2> /dev/null | \
	python -m json.tool 

	}

function theme {

	curl https://wpvulndb.com/api/v2/themes/$1 2> /dev/null | \
	python -m json.tool 
	
	}

function all {

	curl https://wpvulndb.com/api/v2/wordpresses/$1 2> /dev/null | \
	python -m json.tool
	
	}

function usage {
	
echo "Usage: $(basename $0) <options> <plugin/theme/wpversion>"
echo "options:"
echo " --help			display this help page"
echo " --plugin		query api for a specific plugin"
echo " --theme 		query api for specific theme"
echo " --all			retrieve all vulnerabilities in a specific wp version number"

}


if [ -z $1 ]; then
  usage
  exit
elif [ $# -gt 2 ]; then
  echo "too many arguments"
  echo " "
  usage
  exit
fi

case "$1" in
  '--help')
    usage
    ;;

  '--plugin')
    plugin $2
    ;;

  '--theme')
    theme $2
    ;;

  '--all')
    all $2
    ;;
esac
