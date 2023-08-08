#!/bin/bash
set -e

VERSION="2.32.7"

# Check and install dependencies
sudo yum install autoconf cpio curl-devel expat-devel gcc gettext-devel make openssl-devel perl-ExtUtils-MakeMaker zlib-devel -y
sudo yum install wget -y

# Download and install Git
wget  https://mirrors.edge.kernel.org/pub/software/scm/git/git-$VERSION.tar.gz
tar -xzvf git-$VERSION.tar.gz
cd git-$VERSION/
make configure
./configure --prefix=/usr/local/git
make && sudo make install

# Create symbolic links
sudo ln -sf /usr/local/git/bin/* /usr/bin/

# Display Git version
git --version

# Clean up
cd ..
rm -rf git-$VERSION git-$VERSION.tar.gz

