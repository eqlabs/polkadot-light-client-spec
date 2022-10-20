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
- The C++ language is infamous for being prone to undefined behavior and resource management runtime errors which are sometimes hard to find. This can be prevented (or at least mitigated) by the use of modern C++ features, including smart pointers, move resource management, as well as the addition of static and dynamic code analysis jobs
- The C++ standard library lacks many features which are standard in other languages, most importantly networking and serialization. The implementation in C++ may therefore have more third-party components
- Modern C++ (up to 20 standard) is quite complex. The required skill for potential contributors can be correspondingly high

Fuctional comparison: Light Client vs. Full Node
> Full Node
> - full verification of all blocks of the chain
> - holds all of the previous block data and the chain's storage in database
> - installation, maintenance, and execution tend to be exhaustive and require system administration expertise.
>
> Light Client
> - only verifies the authenticity of blocks of the chain
> - no database
> - no installation; has an optional extension with minimal or no maintenance. Initializes quickly
>
> [https://wiki.polkadot.network/docs](https://wiki.polkadot.network/docs/build-substrate)

Addtionally,
- the light client only stores parts of the blockchain that are relevant to the transaction being performed
- may cache some limited data in local storage, in order to speed up client launch (e.g., current runtime, previously connected peers, etc.)
- clients remain trustless, directly syncing block headers from peer nodes in order to verify the specific responses provided by the full node

Light client use cases
- Attach to a full node
- get balance
- perform a transaction
- verify block headers
