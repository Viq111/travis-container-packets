#!/bin/sh
set -e
add_to_paths()
{
	if [ -d $1/bin ]; then
		echo "Adding $1/bin to path"
		export PATH=$1/bin:$PATH
	fi
	if [ -d $1/include ]; then
		export C_INCLUDE_PATH=$1/include:$C_INCLUDE_PATH;
		export CPLUS_INCLUDE_PATH=$1/include:$CPLUS_INCLUDE_PATH;
	fi
	if [ -d $1/lib ]; then
		export LIBRARY_PATH=$1/lib:$LIBRARY_PATH;
	fi
	if [ -d $1/lib64 ]; then
		export LIBRARY_PATH=$1/lib64:$LIBRARY_PATH;
	fi
}

export BASE_DIR=$(pwd)/svn
mkdir -p $BASE_DIR
export LD_LIBRARY_PATH=$BASE_DIR:$LD_LIBRARY_PATH

# Build Scons for serf
wget http://downloads.sourceforge.net/scons/scons-2.3.4.tar.gz
tar -xzf scons-2.3.4.tar.gz
rm scons-2.3.4.tar.gz
cd scons-2.3.4/
python setup.py install --prefix=$BASE_DIR --standard-lib --optimize=1 --install-data=$BASE_DIR/share
cd ..
rm -rf scons-2.3.4/
add_to_paths $BASE_DIR
export PYTHONPATH=$BASE_DIR/lib/python2.7/site-packages

# Build openssl for serf
wget https://openssl.org/source/openssl-1.0.2.tar.gz
tar -xzf openssl-1.0.2.tar.gz
rm openssl-1.0.2.tar.gz
wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.2-fix_parallel_build-1.patch
cd openssl-1.0.2/
patch -Np1 -i ../openssl-1.0.2-fix_parallel_build-1.patch
./config --prefix=$BASE_DIR --openssldir=$BASE_DIR/ssl --libdir=lib shared zlib-dynamic
make
make MANDIR=$BASE_DIR/man MANSUFFIX=ssl install
cd ..
rm -rf openssl-1.0.2/
rm openssl-1.0.2-fix_parallel_build-1.patch

# Build Apache APR (for APR-util)
wget http://archive.apache.org/dist/apr/apr-1.5.1.tar.bz2
tar -xjf apr-1.5.1.tar.bz2
rm apr-1.5.1.tar.bz2
cd apr-1.5.1/
./configure --prefix=$BASE_DIR --disable-static --with-installbuilddir=$BASE_DIR/share/apr-1/build
make -j4
make install
cd ..
rm -rf apr-1.5.1

# Build Apache APR-Util (for svn)
wget http://archive.apache.org/dist/apr/apr-util-1.5.4.tar.bz2
tar -xjf apr-util-1.5.4.tar.bz2
rm apr-util-1.5.4.tar.bz2
cd apr-util-1.5.4/
./configure --prefix=$BASE_DIR --with-apr=$BASE_DIR --with-openssl=$BASE_DIR --with-crypto
make
make install
cd ..
rm -r apr-util-1.5.4/

# Build Sqlite (for svn)
wget http://sqlite.org/2015/sqlite-autoconf-3080802.tar.gz
tar -xzf sqlite-autoconf-3080802.tar.gz
rm sqlite-autoconf-3080802.tar.gz
cd sqlite-autoconf-3080802/
./configure --prefix=$BASE_DIR --disable-static CFLAGS="-g -O2 -DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 -DSQLITE_ENABLE_UNLOCK_NOTIFY=1 -DSQLITE_SECURE_DELETE=1"
make
make install
cd ..
rm -rf sqlite-autoconf-3080802/

# Build serf for svn
wget http://serf.googlecode.com/svn/src_releases/serf-1.3.8.tar.bz2
tar -xjf serf-1.3.8.tar.bz2
rm serf-1.3.8.tar.bz2
cd serf-1.3.8/
sed -i "/Append/s:RPATH=libdir,::"   SConstruct &&
sed -i "/Default/s:lib_static,::"    SConstruct &&
sed -i "/Alias/s:install_static,::"  SConstruct &&
sed -i -e "s#default_incdir='/usr'#default_incdir='$BASE_DIR'#g"  SConstruct &&
sed -i -e "s#default_prefix='/usr/local'#default_prefix='$BASE_DIR'#g"  SConstruct &&
sed -i -e "s#default_libdir='$PREFIX/lib'#default_libdir='$BASE_DIR/lib'#g"  SConstruct &&
scons PREFIX=$BASE_DIR
scons PREFIX=$BASE_DIR install
cd ..
rm -rf serf-1.3.8/

# Build svn (for clang)
wget http://www.apache.org/dist/subversion/subversion-1.8.11.tar.bz2
tar -xjf subversion-1.8.11.tar.bz2
rm subversion-1.8.11.tar.bz2
cd subversion-1.8.11/
./configure --prefix=$BASE_DIR --disable-static --with-apr=$BASE_DIR --with-apr-util=$BASE_DIR --with-sqlite=$BASE_DIR --with-serf=$BASE_DIR
make
make install
cd ..
rm -r subversion-1.8.11/
