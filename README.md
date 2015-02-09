# Travis-Container packets
A repository to compile and store packets for Travis container-based architecture

## Availables packets

| Name | last version | status |
| ---- | ------------ | ------ |
| Boost | 1.57.0 | In progress |
| Boost-min | 1.57.0 | In progress |
| Clang | 3.4 | In progress |
| CMake | 3.1.2 | [![Build Status](https://travis-ci.org/Viq111/travis-container-packets.svg?branch=cmake-3)](https://travis-ci.org/Viq111/travis-container-packets) |
| GCC | 4.8.2 | In progress |


## How to use

In your travis file, you can add the following commands to download, install and set paths:

### Boost

```
ToDo
```

### Boost-min

Contains: `chrono`, `date_time`, `iostreams`, `thread`

```
ToDo
```

### Clang

```
ToDo
```

### CMake

```
before_install:
  # Get CMake 3.1
  - wget https://github.com/Viq111/travis-container-packets/releases/download/cmake-3.1.2/cmake.tar.bz2
  - tar -xjf cmake.tar.bz2
  - rm cmake.tar.bz2
  - export PATH=$(pwd)/cmake/bin/:$PATH
```

If you prefer CMake 2.8, you can use it with the same code but the url: `https://github.com/Viq111/travis-container-packets/releases/download/cmake-2.8.12/cmake.tar.bz2`

### GCC

```
ToDo
```

