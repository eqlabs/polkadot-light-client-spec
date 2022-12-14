# Requirements

Note: The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## High-Level Requirements

- The light client (hereafter _the client_) MUST be written in C++

- The client MUST be compatible with any full nodes of any Substrate chain that are [spec](https://spec.polkadot.network/)-conformant.

## User Experience

- The client library MUST be architected as to minimize the coupling of functionality and the user interface.
  - The client library SHOULD be architected as to eliminate coupling altogether.

- The client MUST support multiple platforms to improve the security of wallets on mobile devices/web/desktop.
  - The client MUST be a command-line application with a support of linux target. The client MUST be implemented in a cross-platform way and SHOULD compile against Mac OS and Windows platforms. But full Windows and Mac OS support is out of the scope and can be added within further development.
  - The client library MUST be usable on popular mobile platforms (iOS, Android)
  - The client library MUST be usable in browsers as a WebAssembly module, with a JS wrapper (hereafter _WASM Module_).
  - The client library MUST support linux target. It SHOULD be implemented in a cross-platform way, but full support of other platforms (e.g. Windows, Mac OS, Android) is out of the scope.

- The client MUST be sufficiently documented.
  - The client MUST contain standalone documentation for users
  - The client library code SHOULD contain inline documentation for current and future developers

## The WASM Module

- The WebAssembly Module + JS wrapper SHOULD call RPC methods via API (modelled after ScProvider of [substrate-connect](https://substrate.io/developers/substrate-connect/)), not via RPC server.

- The WASM Module SHOULD NOT concern itself with use in standalone node applications.[^1]

## Functionality

- The client MUST be able to connect to a relay chain using chain state.
- The client MUST be able to retrieve checkpoint state from a trusted source to speed up initialization.
- The client MUST be able to subscribe/unsubscribe to/from any polkadot-spec-conformant relay chain (Polkadot, Westend, Kusama)
- The client MUST be able to subscribe/unsubscribe to/from parachains that do not use custom protocols or cryptography methods other than those that Polkadot, Westend and Kusama use.
- The client MUST support the following [RPC methods](https://paritytech.github.io/json-rpc-interface-spec/):
  - `rpc_methods`, `chainHead_unstable_follow`, `chainHead_unstable_unfollow`, `chainHead_unstable_unpin`, `chainHead_unstable_storage`, `chainHead_unstable_call` `chainHead_unstable_stopCall`. `transaction_unstable_submitAndWatch`, and `transaction_unstable_unwatch`
- The client MUST support the `@substrate/connect` [connection extension protocol](https://github.com/paritytech/substrate-connect/tree/main/packages/connect-extension-protocol):
  - `ToApplicationError`, `ToApplicationChainReady`, `ToApplicationRpc`, `ToExtensionAddChain`, `ToExtensionAddWellKnownChain`, `ToExtensionRpc`,` ToExtensionRemoveChain`



[^1]: This could be discussed in future grant proposals.