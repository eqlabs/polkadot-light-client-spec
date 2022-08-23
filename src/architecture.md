# Architecture & artifacts

A light client should support multiple platforms to improve the security of wallets on mobile devices/web/desktop. So from architectural point of view it’s important to have the following:

- Cross-platform C++ library that can be built against desktop and mobile platforms
- Native desktop console application (linux)
- WebAssembly module with a JS wrapper that can be used in browser
- Inline and standalone documentation

Since WASM module is to be used in a browser, it will be able to call RPC methods via API, not via RPC server.
Please note that JS module is supposed to be used in browser, not in standalone node applications. However this can be achieved as a separate project with minimal changes to the existing code.
