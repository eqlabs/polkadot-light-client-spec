# Functionality

Light client should support the following functionality:

- Connecting to a relay chain using chain state
- Retrieving checkpoint state from a trusted source to speed up initialization
- Subscribe/unsubscribe to/from parachains
- Send a new transaction and subscribe to it’s updates
- Subset of [RPC methods](https://docs.5ire.org/docs/substrate/rpc/). The minimum subset would include *childstate_GetStorage*, *state_getStorage* and *state_getReadProof*. This subset should be carefully defined along with which methods can and should do the validation on a light client side and which will proxy it to a full node.
