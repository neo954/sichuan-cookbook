#!/bin/bash

LATEX_TOC="$1"
declare -i chapter=0

echo '<ul class="toc no-parts">'

while read -r line
do
	if [[ $line =~ cftpagenumbers ]]
	then
		continue
	elif [[ $line =~ "{chapter}" ]]
	then
		if [ "$chapter" = 1 ]
		then
			echo '</ul></li>'
		fi
		chapter=1
		line="${line##*\[s\]\{}"
		line="${line%%\}*}"
		echo "<li>${line}</li>"
		echo '<li><ul class="toc no-parts">'
	elif [[ $line =~ "{section}" ]]
	then
		line="${line##*\{\}}"
		line="${line%%\}*}"
		echo "  <li>${line}</li>"
	fi
done < "${LATEX_TOC}"

echo '</ul></li>'
echo '</ul>'
