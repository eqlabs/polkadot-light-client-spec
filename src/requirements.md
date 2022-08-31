# Requirements

Note: The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## High-Level Requirements

- The light client (hereafter _the client_) MUST be written in C++

- The client must be compatible with the full node of any Substrate chain, i.e. Polkadot, Kusama, or any number of stand-alone Substrate chains and Parachains.

## User Experience

- The client library MUST be architected as to minimize the coupling of functionality and the user interface.
  - The client library SHOULD be architected as to eliminate coupling altogether.

- The client MUST support multiple platforms to improve the security of wallets on mobile devices/web/desktop.
  - The client MUST support the linux command line
  - The client library MUST be usable in mobile devices
  - The client library MUST be usable in browsers as a WebAssembly module, with a JS wrapper (hereafter _WASM Module_).
  - The client library MUST support the linux desktop
    - TODO: Mac? Windows?

- The client MUST be sufficiently documented.
  - The client MUST contain standalone documentation for users
  - The client library code SHOULD contain inline documentation for current and future developers

## The WASM Module

- The WebAssembly Module + JS wrapper SHOULD call RPC methods via API (modelled after ScProvider of [substrate-connect](https://substrate.io/developers/substrate-connect/)), not via RPC server.

- The WASM Module SHOULD NOT concern itself with use in standalone node applications.[^1]

## Functionality

- The client MUST be able to connecting to a relay chain using chain state.
- The client MUST be able to retrieving checkpoint state from a trusted source to speed up initialization.
- The client MUST be able to subscribe/unsubscribe to/from parachains.
- The client MUST be able to send a new transaction.
- The client MUST be able subscribe a new transaction's updates.
- The client MUST support the following minimum subset of [RPC methods](https://docs.5ire.org/docs/substrate/rpc/):
  - `childstate_GetStorage`, `state_getStorage` and `state_getReadProof`. 
  - TODO: This subset should be carefully defined along with which methods can and should do the validation on a light client side and which will proxy it to a full node. Web3 Foundation input required, which API methods to be implemented within the scope

[^1]: This could be discussed in future grant proposals.