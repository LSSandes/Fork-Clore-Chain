echo 'Please read  https://gitlab.com/cloreai-public/blockchain/blob/main/doc/build-osx.md '
echo 'Run this script under macOS  '

CLORE_ROOT=$(pwd)
# build db4
CFLAGS="-Wno-error=implicit-function-declaration"  ./contrib/install_db4.sh .

BDB_PREFIX="${CLORE_ROOT}/db4"

# Configure Clore Core to use our own-built instance of BDB
cd $CLORE_ROOT
./autogen.sh
./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" --enable-cxx --disable-shared --disable-tests --disable-gui-tests
make -j4
make deploy
