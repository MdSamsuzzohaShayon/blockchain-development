# NFT
 - [(20:07:52) | Setup NFTs](https://youtu.be/-1GB6m39-rM?t=72472)
 - [(20:21:59) | Hosting on IPFS](https://youtu.be/-1GB6m39-rM?t=73319)
 - [(20:32:00) | Deploy basic NFT](https://youtu.be/-1GB6m39-rM?t=73920)
 - [(20:33:23) | Test, Deploy basic NFT](https://youtu.be/-1GB6m39-rM?t=74003)
 - [(20:55:50) | Creating, encoding, decoding SVG](https://youtu.be/-1GB6m39-rM?t=75352)
 - [(21:02:52) | Mood NFT, Test & Get metadata as a JSON file from SVG](https://youtu.be/-1GB6m39-rM?t=75772)
 - [(21:24:41) | Flip the mood, Deploy, Test](https://youtu.be/-1GB6m39-rM?t=77081)
 - [(21:49:31) | Deploy NFT, Mint NFT, Flip Mood, Anvil demo](https://youtu.be/-1GB6m39-rM?t=78571)
 - [(21:56:12) | Encoding, Opcodes, and calls](https://youtu.be/-1GB6m39-rM?t=78972)

 - Till - https://youtu.be/-1GB6m39-rM?t=78972

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

#### SVGS
 - Happy SVG (Get hash for the svg `base64 -i img/happy.svg`)
   ```
   data:image/svg+xml;base64,
   PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAg
   MjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+CiAgPCEtLSBGYWNlIENpcmNsZSB3aXRoIEdy
   YWRpZW50IC0tPgogIDxkZWZzPgogICAgPHJhZGlhbEdyYWRpZW50IGlkPSJmYWNlR3JhZGllbnQi
   IGN4PSI1MCUiIGN5PSI1MCUiIHI9IjUwJSI+CiAgICAgIDxzdG9wIG9mZnNldD0iMCUiIHN0eWxl
   PSJzdG9wLWNvbG9yOiNGRkVCM0I7IHN0b3Atb3BhY2l0eToxIiAvPgogICAgICA8c3RvcCBvZmZz
   ZXQ9IjEwMCUiIHN0eWxlPSJzdG9wLWNvbG9yOiNGQkMwMkQ7IHN0b3Atb3BhY2l0eToxIiAvPgog
   ICAgPC9yYWRpYWxHcmFkaWVudD4KICA8L2RlZnM+CiAgPGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAw
   IiByPSI5MCIgZmlsbD0idXJsKCNmYWNlR3JhZGllbnQpIiBzdHJva2U9IiNGNTdGMTciIHN0cm9r
   ZS13aWR0aD0iNSIvPgoKICA8IS0tIExlZnQgRXllIHdpdGggR3JhZGllbnQgYW5kIFNoaW5lIC0t
   PgogIDxkZWZzPgogICAgPHJhZGlhbEdyYWRpZW50IGlkPSJleWVHcmFkaWVudCIgY3g9IjUwJSIg
   Y3k9IjUwJSIgcj0iNTAlIj4KICAgICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3R5bGU9InN0b3AtY29s
   b3I6IzU1NTsgc3RvcC1vcGFjaXR5OjEiIC8+CiAgICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3R5
   bGU9InN0b3AtY29sb3I6IzIyMjsgc3RvcC1vcGFjaXR5OjEiIC8+CiAgICA8L3JhZGlhbEdyYWRp
   ZW50PgogIDwvZGVmcz4KICA8Y2lyY2xlIGN4PSI2NSIgY3k9IjgwIiByPSIxMiIgZmlsbD0idXJs
   KCNleWVHcmFkaWVudCkiLz4KICA8Y2lyY2xlIGN4PSI2MCIgY3k9Ijc1IiByPSIzIiBmaWxsPSJ3
   aGl0ZSIgLz4KCiAgPCEtLSBSaWdodCBFeWUgd2l0aCBHcmFkaWVudCBhbmQgU2hpbmUgLS0+CiAg
   PGNpcmNsZSBjeD0iMTM1IiBjeT0iODAiIHI9IjEyIiBmaWxsPSJ1cmwoI2V5ZUdyYWRpZW50KSIv
   PgogIDxjaXJjbGUgY3g9IjEzMCIgY3k9Ijc1IiByPSIzIiBmaWxsPSJ3aGl0ZSIgLz4KCiAgPCEt
   LSBNb3V0aCAoSGFwcHkpIHdpdGggRGVwdGggLS0+CiAgPHBhdGggZD0iTSA1MCAxMzAgUSAxMDAg
   MTcwIDE1MCAxMzAiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSI2IiBmaWxsPSJ0cmFuc3Bh
   cmVudCIgLz4KICA8cGF0aCBkPSJNIDUwIDEzMCBRIDEwMCAxNjAgMTUwIDEzMCIgc3Ryb2tlPSIj
   NTU1IiBzdHJva2Utd2lkdGg9IjMiIGZpbGw9InRyYW5zcGFyZW50IiAvPgoKICA8IS0tIEJsdXNo
   IENpcmNsZXMgZm9yIEV4dHJhIERldGFpbCAtLT4KICA8Y2lyY2xlIGN4PSI1MCIgY3k9IjExMCIg
   cj0iMTIiIGZpbGw9InJnYmEoMjU1LDEwNSwxODAsMC40KSIgLz4KICA8Y2lyY2xlIGN4PSIxNTAi
   IGN5PSIxMTAiIHI9IjEyIiBmaWxsPSJyZ2JhKDI1NSwxMDUsMTgwLDAuNCkiIC8+CgogIDwhLS0g
   RXllYnJvd3MgLS0+CiAgPHBhdGggZD0iTSA1NSA2MCBRIDY1IDUwIDc1IDYwIiBzdHJva2U9IiMz
   MzMiIHN0cm9rZS13aWR0aD0iNCIgZmlsbD0idHJhbnNwYXJlbnQiIC8+CiAgPHBhdGggZD0iTSAx
   MjUgNjAgUSAxMzUgNTAgMTQ1IDYwIiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iNCIgZmls
   bD0idHJhbnNwYXJlbnQiIC8+Cjwvc3ZnPgo=
   ```
 - Sad SVG (Get hash for the svg `base64 -i img/sad.svg`)
   ```
   data:image/svg+xml;base64,
   PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0MDAg
   NDAwIiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQwMCI+CiAgPCEtLSBGYWNlIENpcmNsZSAtLT4KICA8
   Y2lyY2xlIGN4PSIyMDAiIGN5PSIyMDAiIHI9IjE4MCIgZmlsbD0iI0ZGRUIzQiIgc3Ryb2tlPSIj
   RkJDMDJEIiBzdHJva2Utd2lkdGg9IjEwIi8+CgogIDwhLS0gTGVmdCBFeWUgLS0+CiAgPGVsbGlw
   c2UgY3g9IjE0MCIgY3k9IjE2MCIgcng9IjMwIiByeT0iMjAiIGZpbGw9IndoaXRlIiBzdHJva2U9
   IiMzMzMiIHN0cm9rZS13aWR0aD0iMyIvPgogIDxjaXJjbGUgY3g9IjE0MCIgY3k9IjE2MCIgcj0i
   MTAiIGZpbGw9IiMzMzMiLz4KCiAgPCEtLSBSaWdodCBFeWUgLS0+CiAgPGVsbGlwc2UgY3g9IjI2
   MCIgY3k9IjE2MCIgcng9IjMwIiByeT0iMjAiIGZpbGw9IndoaXRlIiBzdHJva2U9IiMzMzMiIHN0
   cm9rZS13aWR0aD0iMyIvPgogIDxjaXJjbGUgY3g9IjI2MCIgY3k9IjE2MCIgcj0iMTAiIGZpbGw9
   IiMzMzMiLz4KCiAgPCEtLSBEcm9vcGluZyBFeWVicm93cyAtLT4KICA8cGF0aCBkPSJNIDEwMCAx
   MzAgUSAxNDAgMTEwIDE4MCAxMzAiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSI1IiBmaWxs
   PSJ0cmFuc3BhcmVudCIvPgogIDxwYXRoIGQ9Ik0gMjIwIDEzMCBRIDI2MCAxMTAgMzAwIDEzMCIg
   c3Ryb2tlPSIjMzMzIiBzdHJva2Utd2lkdGg9IjUiIGZpbGw9InRyYW5zcGFyZW50Ii8+CgogIDwh
   LS0gU2FkIE1vdXRoIC0tPgogIDxwYXRoIGQ9Ik0gMTMwIDI4MCBRIDIwMCAyMjAgMjcwIDI4MCIg
   c3Ryb2tlPSIjMzMzIiBzdHJva2Utd2lkdGg9IjgiIGZpbGw9InRyYW5zcGFyZW50IiAvPgoKICA8
   IS0tIFRlYXJzIC0tPgogIDxwYXRoIGQ9Ik0gMTMwIDE4MCBDIDEyNSAyMjAgMTQ1IDI0MCAxNTAg
   MjIwIiBmaWxsPSJibHVlIiBmaWxsLW9wYWNpdHk9IjAuNiIvPgogIDxwYXRoIGQ9Ik0gMjcwIDE4
   MCBDIDI2NSAyMjAgMjg1IDI0MCAyOTAgMjIwIiBmaWxsPSJibHVlIiBmaWxsLW9wYWNpdHk9IjAu
   NiIvPgoKICA8IS0tIENoZWVrIFNoYWRpbmcgZm9yIERlcHRoIC0tPgogIDxkZWZzPgogICAgPHJh
   ZGlhbEdyYWRpZW50IGlkPSJjaGVla0dyYWRpZW50IiBjeD0iNTAlIiBjeT0iNTAlIiByPSI1MCUi
   PgogICAgICA8c3RvcCBvZmZzZXQ9IjAlIiBzdHlsZT0ic3RvcC1jb2xvcjpyZ2JhKDI1NSwxNTMs
   MTAyLDAuNCk7c3RvcC1vcGFjaXR5OjAuNCIgLz4KICAgICAgPHN0b3Agb2Zmc2V0PSIxMDAlIiBz
   dHlsZT0ic3RvcC1jb2xvcjpyZ2JhKDI1NSwxNTMsMTAyLDApO3N0b3Atb3BhY2l0eTowIiAvPgog
   ICAgPC9yYWRpYWxHcmFkaWVudD4KICA8L2RlZnM+CiAgPGVsbGlwc2UgY3g9IjE0MCIgY3k9IjI1
   MCIgcng9IjUwIiByeT0iMzAiIGZpbGw9InVybCgjY2hlZWtHcmFkaWVudCkiIC8+CiAgPGVsbGlw
   c2UgY3g9IjI2MCIgY3k9IjI1MCIgcng9IjUwIiByeT0iMzAiIGZpbGw9InVybCgjY2hlZWtHcmFk
   aWVudCkiIC8+Cjwvc3ZnPgo=
   ```
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
