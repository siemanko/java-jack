#!/bin/bash
set -o nounset
set -o errexit
DIR="$( pushd  "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd && popd > /dev/null)"
TIME_LIMIT=3


pushd $DIR
pwd
if [ -a $1.java ]
then 
	javac $1.java
	for t in $(ls tests/$1*.in | sort -V)
	do
		filename=$(basename "$t")
		extension="${filename##*.}"
		filename="${filename%.*}"
		RET=0
		./time-limit.sh $TIME_LIMIT java $1 < $t > output.temp || RET=$?
		if [[ $RET == 124 ]]
		then 
			echo "TEST $filename... $(tput setaf 1)TIME LIMIT EXCEEDED ($TIME_LIMIT s)$(tput sgr0)"
			continue
		fi
		if [[ $RET != 0 ]]
		then
			echo "TEST $filename... $(tput setaf 1)RUNTIME ERROR (code $RET)$(tput sgr0)"
			continue
		fi
		if diff -bs output.temp tests/$filename.out > /dev/null 2>&1
		then
			echo "TEST $filename... $(tput setaf 2)CORRECT$(tput sgr0)"
		else
			echo "TEST $filename... $(tput setaf 1)WRONG ANSWER$(tput sgr0)" 
		fi
	done
	if [ -a output.temp ]; then rm output.temp; fi
fi
popd
