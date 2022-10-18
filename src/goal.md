# Project goal

> A light client or light node is a piece of software that connects to full nodes to interact with the blockchain ... [providing] a much better end-user experience while letting end-users access the blockchain in a decentralized and secure manner.
>
> [https://www.parity.io/blog](https://www.parity.io/blog/what-is-a-light-client/)

This goal of this project is to create a new light client implementation for Substrate, written in C++. It would be an alternative to [substrate-connect](https://wiki.polkadot.network/docs/build-substrate), and other clients like it past, present, and future.

Reasons for having another light client:

- Improve the light client specifications. As for now there is only one [smoldot](https://github.com/paritytech/smoldot)-based light client implementation. This may lead to certain things and workflows being poorly documented, e.g. light client API

Reasons for writing it in C++:
- Involve C++ community into Polkadot development. As for now there is only full node C++ implementation ([Kagome](https://github.com/soramitsu/kagome))
- Add more integration options for mobile and desktop platforms. C++ light client library can be reused for creating mobile and desktop wallets. C++ code of the library will be also compiled to WASM module allowing launching light client in a browser

Downsides of choosing C++ for implementation:
- C++ language is infamous for been keen to undefined behavior and resource management runtime errors which are sometimes hard to find. This can be handled by using modern C++ features (smart pointers, move resource management), adding static and dynamic code analysis jobs
- C++ standard library lacks many things which are quite standard for other languages, e.g. networking, serialization. So the implementation in C++ may have more thirdparty components
- Modern C++ (up to 20 standard) is quite complex. So the requirements to the potential contributors are quite high