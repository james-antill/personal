#! /bin/sh -e

if [ -x setup-dirs.sh ]; then
        ./setup-dirs.sh
fi

cd
cd work
if [ ! -d personal-config ]; then
        git clone https://github.com/james-antill/personal personal-config
fi

for i in CAShe mtree yum yum-utils vstr ustr and-httpd ; do
        if [ ! -d $i ]; then
                git clone https://github.com/james-antill/$i
        fi
done

