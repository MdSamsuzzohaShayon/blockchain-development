## Latest tutorial
 - [(19:26:00) | Advanced Foundry / Creating tokens](https://youtu.be/-1GB6m39-rM?t=70012)
 - [(19:42:00) | AI Tests](https://youtu.be/-1GB6m39-rM?t=71029)
 - [(19:58:56) | NFT](https://youtu.be/-1GB6m39-rM?t=71936)

## Docs
 - [ERC](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) - Ethereum Requests for Comments
 - [EIP](https://eips.ethereum.org/) - Ethereum Improvement Proposal
 - https://docs.openzeppelin.com/contracts/5.x/wizard


Till - https://youtu.be/-1GB6m39-rM?t=71284

____

## Foundry

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
