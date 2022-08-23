# Implementation stages

1. Native light client console application with minimal JSON RPC functionality
    1. Add support of Conan package manager to [scale-code-cpp](https://github.com/soramitsu/scale-codec-cpp)
    2. Add support of Conan package manager to [cpp-libp2p](https://github.com/libp2p/cpp-libp2p)
    3. Create light client application with transaction management functionality.
    4. Add support of *GetStorage* and *GetStorageProof* JSON RPC methods
    5. Document code & API
2. C++ library with light client functionality
    1. Prepare separate C++ library artifact (include + methods)
    2. Add library interface documentation
3. JS light client library
    1. Compile  [cpp-libp2p](https://github.com/libp2p/cpp-libp2p) with Emscipten and add websocket client support
    2. Add WASM compilation target for C++ client library
    3. Implement JS wrapper around WASM module
4. Implement more JSON RPC methods
