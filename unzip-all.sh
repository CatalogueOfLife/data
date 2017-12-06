#!/bin/bash

cd AC2017
for zip in *.zip ; do
    dir=${zip%.zip}
    echo $zip
    mkdir "$dir"
    unzip -d "$dir" "$zip"
    rm $zip
done