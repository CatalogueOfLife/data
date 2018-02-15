#!/bin/bash

cd AC2017b

echo "Remove existing ZIPs"
for zip in *.zip ; do
    rm $zip
done

for dir in * ; do
    echo $dir
    # copy eml from dataset
    rm "$dir/dataset/col.xml"
    for i in "$dir/dataset/*.xml"; do 
        mv $i "$dir/eml.xml";
    done
    rmdir "$dir/dataset"
    # overwrite with eml from previous dir if existing
    cp "../AC2017/$dir/$dir/eml.xml" "$dir/";
    zip -r $dir $dir
    #rmdir -Rf $dir
done