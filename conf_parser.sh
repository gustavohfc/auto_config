#!/bin/bash

source_file="$2/source_conf"
conf_link="$2/conf_link"
conf_file_path=`readlink $2/conf_link | cut -f 1 -d / --complement`

echo $source_file
echo $conf_link
echo $conf_file_path

exit 0
