#! /bin/sh -e

sudo chmod 0 /usr/libexec/packagekitd || true

sudo yum install -y yum-aliases yum-security zsh
sudo yum install -y vim || true

sudo yum up yum -y || true
sudo yum up yum-utils -y || true

sudo yum install -y git-core

