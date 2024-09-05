### Setup Locally
 - Build the project with `forge build`
 - [Anvil](https://book.getfoundry.sh/anvil/) is a local testnet node shipped with Foundry. You can use it for testing your contracts from frontends or for interacting over RPC.
 - [Ganache](https://archive.trufflesuite.com/ganache/): Quickly fire up a personal Ethereum blockchain which you can use to run tests, execute commands, and inspect state while controlling how the chain operates.
 - [07:13:17](https://youtu.be/umepbfKp5rI?t=25997) -> Add localhost test net manually to metamask. Metamask -> setting -> networks -> add network -> add a network manually
    - Network name: *localhost*
    - New RPC URL: *HTTP://127.0.0.1:7545* (Get this IP from ganache RPC Server)
    - Chain ID: *1337* (Ganache Network ID, For Anvil it is 31337)
    - Currency symbol: *ETH*
    - No need to put *Block explorer URL (Optional)* since etherscan can not connect our localhost
 - [07:17:05](https://youtu.be/umepbfKp5rI?t=26225) Importing account to MetaMask -> Ganache -> select key icon of the account and copy private key and import account with that private key
 - A specification of the [standard interface](https://ethereum.github.io/execution-apis/api-documentation/) for Ethereum clients.
 - [7:19:40](https://youtu.be/umepbfKp5rI?t=26380) - Deploying to local blockchain using `forge create`
    ```
    forge create --help
    forge create SimpleStorage --rpc-url http://127.0.0.1:7545 --interactive
    ```
 - Forge can [deploy smart contracts](https://book.getfoundry.sh/forge/deploying?highlight=deploy#deploying) to a given network with the forge create command.
 - The RPC (Remote Procedure Call) URL typically refers to the endpoint used for communicating with an Ethereum node, either on the mainnet or a testnet. This endpoint allows applications to interact with the Ethereum blockchain by sending and receiving data, such as querying blockchain data, executing transactions, or deploying smart contracts.
 - Deploying simple storage `forge script script/DeploySimpleStorage.s.sol --intractive` (By default it will automitically deploy to anvil chain)
 - Specify anvil rpc url `forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545`
 - Deploy contract and make everything custom `forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key CONTRACT_PRIVATE_KEY`
 - Secure deployment using environment variable (take rpc url and private key iside dot env file)
 ```
 source .env
 forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
 ```
 - For real money, we must not do any of there to store private key, Whether use `--intractive` shell or use keystore file with a password once foundry adds that

 - 07:36:15 https://youtu.be/umepbfKp5rI?t=28330



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
