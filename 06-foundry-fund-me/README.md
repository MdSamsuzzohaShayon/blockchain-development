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
 - Debuging with [Chisel (01:32:26)](https://youtu.be/sas02qSFZ74?t=5546) is an advanced Solidity REPL shipped with Foundry. - https://book.getfoundry.sh/chisel/
 - Making [gas efficient (01:33:56)](https://youtu.be/sas02qSFZ74?t=5636)
 - An Ethereum Virtual Machine Opcodes Interactive [Reference](https://www.evm.codes/)
 - [Style guide](https://docs.soliditylang.org/en/latest/style-guide.html#) - This guide is intended to provide coding conventions for writing Solidity code.
 - [README.md, Interation tests, Programatic verication (01:56:11)](https://youtu.be/sas02qSFZ74?t=6971)
 - Makefile [02:10:59](https://youtu.be/sas02qSFZ74?t=7859)

### README Guide / [Make a README Because no one can read your mind](https://www.drupal.org/docs/develop/managing-a-drupalorg-theme-module-or-distribution-project/documenting-your-project/readmemd-template) 
 - __https://www.makeareadme.com/__
 - About
 - Getting Started
    1. Requirements
    2. Quickstart
    3. Usage

 Till - https://youtu.be/sas02qSFZ74?t=7539


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
