#!/bin/bash
yum install autoconf cpio curl-devel expat-devel gcc gettext-devel make openssl-devel perl-ExtUtils-MakeMaker zlib-devel -y
wget -O https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.4.3.tar.gz
sudo yum install wget -y
wget  https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.4.12.tar.gz
tar -xzvf git-2.4.12.tar.gz
cd git-2.4.12/
make configure
./configure --prefix=/usr/local/git
make && make install
ln -sf /usr/local/git/bin/* /usr/bin/
git --version

