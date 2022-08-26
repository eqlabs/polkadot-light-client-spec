# Project goal

As the [Blog of Parity Technologies](https://www.parity.io/blog/what-is-a-light-client/) puts it, light clients provide a much better end-user experience while letting end-users access the blockchain in a decentralized and secure manner. This project is to create a C++ equivalent of [substrate-connect](https://wiki.polkadot.network/docs/build-substrate) light client. This would:

- Improve light client specification. As for now there is only one [smoldot](https://github.com/paritytech/smoldot)-based light client implementation. This may lead to certain things and workflows being poorly documented, e.g. light client API
- Involve C++ community into Polkadot development. As for now there is only full node C++ implementation ([Kagome](https://github.com/soramitsu/kagome))
- Add more integration options for mobile and desktop platforms. C++ light client library can be reused for creating mobile and desktop wallets. C++ code of the library will be also compiled to WASM module allowing launching light client in a browser
