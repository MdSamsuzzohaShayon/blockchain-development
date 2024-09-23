# NFT
 - [(20:07:52) | Setup NFTs](https://youtu.be/-1GB6m39-rM?t=72472)
 - [(20:21:59) | Hosting on IPFS](https://youtu.be/-1GB6m39-rM?t=73319)
 - [(20:32:00) | Deploy basic NFT](https://youtu.be/-1GB6m39-rM?t=73920)
 - [(20:33:23) | Test basic NFT](https://youtu.be/-1GB6m39-rM?t=74003)

#### IPFS (InterPlanetary File System)
IPFS is a decentralized storage system that allows users to store and share files in a distributed manner, much like a peer-to-peer network.

#### How IPFS Works:
 - Content-based addressing: Instead of locating files by their location (like in HTTP), IPFS uses the file's content to generate a unique hash. This hash is the file's identifier, making it immutable—if the file changes, the hash changes.
 - Distributed Storage: Files are broken into smaller chunks and distributed across a network of nodes. Anyone can retrieve the file using its unique hash.
#### Examples:
 - Storing NFTs: Rather than storing large files (e.g., images, videos) on-chain, NFTs use IPFS to store files. The NFT will contain a token URI pointing to the IPFS hash where the image or metadata is stored.
    - Example: The NFT metadata might look like: __ipfs://QmHash12345__ , linking to an image hosted on IPFS.
 - Sharing Files: You can upload a file (e.g., a video) to IPFS. Anyone with the hash can access it, ensuring persistence even if the original uploader goes offline.
#### Benefits:
 - Decentralization: Files are not reliant on a single server, reducing the risk of censorship or loss.
 - Immutability: Once stored, content cannot be altered, ensuring data integrity.
IPFS is widely used for NFTs and decentralized applications (dApps) for storing assets in a secure, decentralized manner.

#### IPFS Installations
 - https://docs.ipfs.tech/install/ipfs-desktop/#ubuntu
 ```
 sudo dnf install ./ipfs-desktop-0.38.0-linux-x86_64.rpm
 ```
 - [Install the IPFS Companion Browser Extension](https://docs.ipfs.tech/install/ipfs-companion/#prerequisites)
####  Accessing IPFS file
 - Using gateway __https://ipfs.io/ipfs/<CID_OR_HASH>__
 - Another way is __ipfs://QmeiRXnMbyhYGNaWdisR3pnDd3uykmB7VrjpQcug8ngr5u__
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
