#! /bin/sh -e

cd
for i in tmp work work/external/go-lang/src/github.com; do

        if [ ! -d $i ]; then
                mkdir -p $i
        fi

done
