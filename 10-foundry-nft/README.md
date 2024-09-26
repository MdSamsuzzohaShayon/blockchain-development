# NFT
 - [(20:07:52) | Setup NFTs](https://youtu.be/-1GB6m39-rM?t=72472)
 - [(20:21:59) | Hosting on IPFS](https://youtu.be/-1GB6m39-rM?t=73319)
 - [(20:32:00) | Deploy basic NFT](https://youtu.be/-1GB6m39-rM?t=73920)
 - [(20:33:23) | Test, Deploy basic NFT](https://youtu.be/-1GB6m39-rM?t=74003)
 - [(20:55:50) | Creating, encoding, decoding SVG](https://youtu.be/-1GB6m39-rM?t=75352)
 - [(21:02:52) | Mood NFT](https://youtu.be/-1GB6m39-rM?t=75772)

 - Till - https://youtu.be/-1GB6m39-rM?t=74623

#### IPFS (InterPlanetary File System)
IPFS is a decentralized storage system that allows users to store and share files in a distributed manner, much like a peer-to-peer network.

#### How IPFS Works:
 - Content-based addressing: Instead of locating files by their location (like in HTTP), IPFS uses the file's content to generate a unique hash. This hash is the file's identifier, making it immutable—if the file changes, the hash changes.
 - Distributed Storage: Files are broken into smaller chunks and distributed across a network of nodes. Anyone can retrieve the file using its unique hash.
 - Upload 2 files to IPFS desktop, one is a file another one is the json, with some attributes file pointing to orginal file
#### Examples:
 - Storing NFTs: Rather than storing large files (e.g., images, videos) on-chain, NFTs use IPFS to store files. The NFT will contain a token URI pointing to the IPFS hash where the image or metadata is stored.
    - Example: The NFT metadata might look like: __ipfs://QmHash12345__ , linking to an image hosted on IPFS.
 - Sharing Files: You can upload a file (e.g., a video) to IPFS. Anyone with the hash can access it, ensuring persistence even if the original uploader goes offline.
#### Benefits:
 - Decentralization: Files are not reliant on a single server, reducing the risk of censorship or loss.
 - Immutability: Once stored, content cannot be altered, ensuring data integrity.
IPFS is widely used for NFTs and decentralized applications (dApps) for storing assets in a secure, decentralized manner.

#### Compare string
 - Use **chisel** for interactive terminal or shell for solidity
   ```
   Welcome to Chisel! Type `!help` to show available commands.
   ➜ string memory cat  = "cat";
   ➜ string memory dog = "dog";
   ➜ cat
   Type: string
   ├ UTF-8: cat
   ├ Hex (Memory):
   ├─ Length ([0x00:0x20]): 0x0000000000000000000000000000000000000000000000000000000000000003
   ├─ Contents ([0x20:..]): 0x6361740000000000000000000000000000000000000000000000000000000000
   ├ Hex (Tuple Encoded):
   ├─ Pointer ([0x00:0x20]): 0x0000000000000000000000000000000000000000000000000000000000000020
   ├─ Length ([0x20:0x40]): 0x0000000000000000000000000000000000000000000000000000000000000003
   └─ Contents ([0x40:..]): 0x6361740000000000000000000000000000000000000000000000000000000000
   ➜ bytes memory encodedCat = abi.encodePacked(cat);
   ➜ encodedCat
   Type: dynamic bytes
   ├ Hex (Memory):
   ├─ Length ([0x00:0x20]): 0x0000000000000000000000000000000000000000000000000000000000000003
   ├─ Contents ([0x20:..]): 0x6361740000000000000000000000000000000000000000000000000000000000
   ├ Hex (Tuple Encoded):
   ├─ Pointer ([0x00:0x20]): 0x0000000000000000000000000000000000000000000000000000000000000020
   ├─ Length ([0x20:0x40]): 0x0000000000000000000000000000000000000000000000000000000000000003
   └─ Contents ([0x40:..]): 0x6361740000000000000000000000000000000000000000000000000000000000
   ➜ bytes32 catHash = keccak256(encodedCat);
   ➜ catHash
   Type: bytes32
   └ Data: 0x52763589e772702fa7977a28b3cfb6ca534f0208a2b2d55f7558af664eac478a
   ➜ 
   ```

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
