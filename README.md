# Travis-Container packets
A repository to compile and store packets for Travis container-based architecture

## Available packets

| Name | latest version | status |
| ---- | ------------ | ------ |
| Boost | 1.57.0 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=boost)](https://travis-ci.org/Viq111/travis-container-packets) |
| Boost-min | 1.57.0 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=boost-min)](https://travis-ci.org/Viq111/travis-container-packets) |
| Clang | 3.4.2 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=clang)](https://travis-ci.org/Viq111/travis-container-packets) |
| Clang+libc++ | 3.4.2 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=libcxx)](https://travis-ci.org/Viq111/travis-container-packets) |
| CMake | 3.1.2 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=cmake-3)](https://travis-ci.org/Viq111/travis-container-packets) |
| GCC | 4.8.2 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=gcc-4.8)](https://travis-ci.org/Viq111/travis-container-packets) |


## How to use

In your travis file, you can add the following commands to download, install and set paths:

### Boost

```yml
install:
  # Get boost
  - wget https://github.com/Viq111/travis-container-packets/releases/download/boost-1.57.0/boost.tar.bz2
  - tar -xjf boost.tar.bz2
  - rm boost.tar.bz2
  - export BOOST_ROOT=$(pwd)/boost
```

### Boost-min

Contains: `chrono`, `date_time`, `iostreams`, `thread`

```yml
install:
  # Get boost
  - wget https://github.com/Viq111/travis-container-packets/releases/download/boost-min-1.57.0/boost.tar.bz2
  - tar -xjf boost.tar.bz2
  - rm boost.tar.bz2
  - export BOOST_ROOT=$(pwd)/boost
```

### Clang

Currently, I am not able to build Clang directly from source, so I use the prebuilt binaries from [llvm](http://llvm.org/releases/download.html).
See `Clang+libc++` to use Clang on travis-ci.

### Clang+libc++

```yml
compiler:
  - clang
before_install:
  # Get Clang 3.4
  - if [ "$CXX" == "clang++" ]; then wget https://github.com/Viq111/travis-container-packets/releases/download/clang%2Blibcxx-3.4.2/clang_libcxx.tar.bz2; fi
  - if [ "$CXX" == "clang++" ]; then tar -xjf clang_libcxx.tar.bz2; fi
  - if [ "$CXX" == "clang++" ]; then rm clang_libcxx.tar.bz2 && mv clang_libcxx clang; fi
  - if [ "$CXX" == "clang++" ]; then export PATH=$(pwd)/clang/bin:$PATH; fi
  - if [ "$CXX" == "clang++" ]; then export LIBRARY_PATH=$(pwd)/clang/lib:$LIBRARY_PATH; fi
  - if [ "$CXX" == "clang++" ]; then export LD_LIBRARY_PATH=$(pwd)/clang/lib:$LD_LIBRARY_PATH; fi
  - if [ "$CXX" == "clang++" ]; then export CPLUS_INCLUDE_PATH=$(pwd)/clang/include/c++/v1:$CPLUS_INCLUDE_PATH; fi
  - if [ "$CXX" == "clang++" ]; then export CXXFLAGS="-stdlib=libc++"; fi
```

### CMake

```yml
before_install:
  # Get CMake 3.1
  - wget https://github.com/Viq111/travis-container-packets/releases/download/cmake-3.1.2/cmake.tar.bz2
  - tar -xjf cmake.tar.bz2
  - rm cmake.tar.bz2
  - export PATH=$(pwd)/cmake/bin:$PATH
```

If you prefer CMake 2.8, you can use it with the same code but the url: `https://github.com/Viq111/travis-container-packets/releases/download/cmake-2.8.12/cmake.tar.bz2`

### GCC

```yml
before_install:
  # Get GCC 4.8
  - if [ "$CXX" == "g++" ]; then wget https://github.com/Viq111/travis-container-packets/releases/download/gcc-4.8.2/gcc.tar.bz2; fi
  - if [ "$CXX" == "g++" ]; then tar -xjf gcc.tar.bz2; fi
  - if [ "$CXX" == "g++" ]; then rm gcc.tar.bz2; fi
  - if [ "$CXX" == "g++" ]; then export PATH=$(pwd)/gcc/bin:$PATH; fi
  - if [ "$CXX" == "g++" ]; then export LIBRARY_PATH=$(pwd)/gcc/lib64:$LIBRARY_PATH; fi
  - if [ "$CXX" == "g++" ]; then export LD_LIBRARY_PATH=$(pwd)/gcc/lib64:$LD_LIBRARY_PATH; fi
  - if [ "$CXX" == "g++" ]; then export CPLUS_INCLUDE_PATH=$(pwd)/gcc/include/c++/4.8.2:$CPLUS_INCLUDE_PATH; fi
```

