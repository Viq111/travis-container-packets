#!/bin/sh
set -e
export BASE_DIR=$(pwd)/build
mkdir -p $BASE_DIR
export LD_LIBRARY_PATH=$BASE_DIR:$LD_LIBRARY_PATH
mkdir $BASE_DIR/apr
mkdir $BASE_DIR/apr-util
mkdir $BASE_DIR/sqlite
mkdir $BASE_DIR/svn
# Build Apache APR (for APR-util)
wget http://archive.apache.org/dist/apr/apr-1.5.1.tar.bz2
tar -xjf apr-1.5.1.tar.bz2
rm apr-1.5.1.tar.bz2
cd apr-1.5.1/
./configure --prefix=$(readlink -f $BASE_DIR/apr) --disable-static
make -j4
make install
cd ..
rm -rf apr-1.5.1
# Build Apache APR-Util (for svn)
wget http://archive.apache.org/dist/apr/apr-util-1.5.4.tar.bz2
tar -xjf apr-util-1.5.4.tar.bz2
rm apr-util-1.5.4.tar.bz2
cd apr-util-1.5.4/
./configure --prefix=$BASE_DIR/apr-util --with-apr=$BASE_DIR/apr --disable-static
make
make install
cd ..
rm -r apr-util-1.5.4/
# Build Sqlite (for svn)
wget http://sqlite.org/2015/sqlite-autoconf-3080802.tar.gz
tar -xzf sqlite-autoconf-3080802.tar.gz
rm sqlite-autoconf-3080802.tar.gz
cd sqlite-autoconf-3080802/
./configure --prefix=$BASE_DIR/sqlite
make
make install
cd ..
rm -r sqlite-autoconf-3080802/
# Build svn (for clang)
wget http://www.apache.org/dist/subversion/subversion-1.8.11.tar.bz2
tar -xjf subversion-1.8.11.tar.bz2
rm subversion-1.8.11.tar.bz2
cd subversion-1.8.11/
./configure --prefix=$BASE_DIR/svn --with-apr=$BASE_DIR/apr --with-apr-util=$BASE_DIR/apr-util --with-sqlite=$BASE_DIR/sqlite
make
make install
cd ..
rm -r subversion-1.8.11/