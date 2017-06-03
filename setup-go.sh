#! /bin/sh -e

if [ -x setup-dirs.sh ]; then
        ./setup-dirs.sh
fi

for i in uitime ; do
        if [ ! -d $i ]; then
                go get github.com/james-antill/$i
        fi
done

