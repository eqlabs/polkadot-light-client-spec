# Implementation

```mermaid
flowchart TB
  subgraph PSC["Platform Specific Code"]
  end

  subgraph LC["Light Client"]
    direction TB
    subgraph BAL["main event loop"]
        direction RL
        boost::asio --> boost::asio
    end
    subgraph Networking
        cpp-libp2p <--> scale-code-cpp

        scale-code-cpp <--> /dot/sync/warp
        scale-code-cpp <--> /dot/block-announces/1
        scale-code-cpp <--> /dot/sync/1
        scale-code-cpp <--> /dot/light/2
    end
    subgraph BS["Blockchain State"]
    end
    subgraph Crypto
      subgraph openssl
      end
      subgraph Ported["Schorr signatures (ported)"]
      end
    end
    Networking <--> BS
    BS --> Crypto
    Networking <--> Crypto
  end
  subgraph CT["Compilation Targets"]
    direction TB
    subgraph WASM["WASM (via emscripten)"]
    end
    subgraph NativeDesktop["Native (Desktop)"]
    end
    subgraph NativeMobile["Native (Mobile)"]
    end
  end
  PSC <--> LC --> CT
```

Implementation will use a single `boost::asio`-loop based approach without extra threads. The reasons why we choose `boost::asio` for a run loop and I/O:
 - `boost::asio` is already used in the [libp2p library](https://github.com/libp2p/cpp-libp2p) we are going to use for p2p communication (see below). Having several I/O libraries and loops being used in one application would introduce extra complexity, the need of synchronization and is a potential source of errors.
 - `boost::asio` supports all the functionality we need apart from p2p: timers, posting and dispatching tasks, synchronization and execution ordering, building a JSON RPC server on top of it.
 - having a single `boost::asio::io_service`-loop that processes all the requests removes the need of having concurrent access synchronization (while logical synchronization still may be required), makes the code WebAssembly-friendly and introduces well-defined asynchronous logic.

 While `boost::asio` is mostly callback based (and so `cpp-libp2p` is) we are planning to wrap callbacks in C++ 20 coroutines, so that async code will have a more Rust-like look. That would significantly improve code readability (logic isn't split between multiple nested callback functions), however may require more skilful contributors since C++ coroutines are still quite new to a lot of C++ developers. Every incoming RPC request will end up with a coroutine creation object that will wait for I/O data in its suspension points. Also some coroutines will handle background tasks, e.g. connection management, notifications processing etc.

 We will use [cppcoro](https://github.com/lewissbaker/cppcoro) library for working with coroutines. C++ standard library doesn't provide existing primitives (awaitable types, synchronization, etc) for coroutines. `cppcoro` is one the most mature C++ coroutine libraries for now.

All platform-specific code will be abstracted out. That would allow us to compile the same C++ code both to native binaries and to a WASM module.

Emscripten will be used to compile C++ code into WASM module.

We will use [binaryen](https://github.com/WebAssembly/binaryen) to run WebAssembly inside _the client_. Binaryen is a compiler and toolchain infrastructure library for WebAssembly written in C++. Reasons behind this choice:
- binaryen is fast and effective, it is optimized to use all available CPU cores, it also compiles to WebAssembly quickly,
- it contains many optimizations that improve code size and speed,
- binaryen is already used by other projects (e.g. Emscripten, Kagome) so it is a tested solution.

[scale-code-cpp](https://github.com/soramitsu/scale-codec-cpp) will be used for SCALE encoding/decoding. 

[cpp-libp2p](https://github.com/libp2p/cpp-libp2p) will be used as libp2p implementation. We will extend these libraries to support building with the Conan package manager. Also we will add support of building with Emscripten and websocket clients.

To support the light client functionality we will implement the support of the following protocols:

- /dot/sync/warp
- /dot/block-announces/1
- /dot/sync/1
- /dot/light/2

We will use hash_map with serialization/deserialization to hold the blockchain state.

We will use openssl for cryptography functions (e.g. Blake2), and port the needed algorithms not included in openssl (e.g. Schnorr signatures).
