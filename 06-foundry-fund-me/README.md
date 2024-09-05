## Foundry

### Testing
 1. **Unit**: Testing a specific part of our code
 2. **Integration**: Testng how our code works with other parts of our code
 3. **Forked**: Testing our code on a simulated real environment
 4. **Staging**: Testing our code in a real environment that is not prod

### Deployment
 - Modular deployment / Modular testing [34:18](https://youtu.be/sas02qSFZ74?t=2058), we can change any kind of chain easily 
 - Mocking contract [42:06](https://youtu.be/sas02qSFZ74?t=2526) for testing so we can run test without RPC URL locally
 - Magic numbers https://youtu.be/sas02qSFZ74?t=3520
 - Add more tests - https://youtu.be/sas02qSFZ74?t=3970

 Till - https://youtu.be/sas02qSFZ74?t=5546

___
___
___
 
**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.


## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
