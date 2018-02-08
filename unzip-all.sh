#!/bin/bash

cd AC2017b
for zip in *.zip ; do
    dir=${zip%.zip}
    echo $zip
    mkdir "$dir"
    unzip -d "$dir" "$zip"
    #rm $zip
done