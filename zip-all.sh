#!/bin/bash

cd AC2017
for dir in * ; do
    echo $dir
    zip -r $dir $dir
    #rmdir -Rf $dir
done