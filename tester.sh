#!/bin/bash
set -o nounset
set -o errexit
DIR="$( pushd  "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd && popd > /dev/null)"
TIME_LIMIT=3


pushd $DIR
filename=$(basename "$1")
code_type="${filename##*.}"
exercise_name="${filename%.*}"
echo "problem name: $exercise_name"

if [[ $code_type == "java" ]]
then
	echo "detected language: Java"
	javac $exercise_name.java
elif [[ $code_type == "py" ]]
then
	echo "detected language: Python"
	# no compilation needed
else
	echo "unsupported filetype"
	exit 1
fi
	
for t in $(ls tests/$exercise_name*.in | sort -V)
do
	filename=$(basename "$t")
	extension="${filename##*.}"
	filename="${filename%.*}"
	RET=0
	if [[ $code_type == "java" ]]
	then 
		./time-limit.sh $TIME_LIMIT java $exercise_name < $t > output.temp || RET=$?
	elif [[ $code_type == "py" ]]
	then 
 		./time-limit.sh $TIME_LIMIT python $exercise_name.py < $t > output.temp || RET=$?
	else
		echo "time should not happen. Blame Szymon!"
	fi
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



popd
