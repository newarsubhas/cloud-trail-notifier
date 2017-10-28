#!/bin/bash

dir=$PWD
file=$dir/build.zip

echo "Building zip file."
result=`zip -r $file CloudTrailNotifier.js config.json node_modules`
if [ $? -ne 0 ]; then
	echo $result
	echo "Error building zip."
	exit 1
fi

echo "Build located @ $file"