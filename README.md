# Python Blockchain

- [tutorials](https://www.youtube.com/watch?v=umepbfKp5rI&t=3756s), [Tutorial docs](https://github.com/Cyfrin/foundry-full-course-f23), [docs](https://soliditylang.org/)

### Blockchain

- **Bitcoin** was the first one to take blockchain mainstream
- **Bitcoin** is like digital gold
- Bitcoin can be used to make peer-to-peer transactions in a decentralized network. This network is powered by cryptography allowes prople to engage in censorship resistant finance in a decentralized manner.
- **Ethereum** allows for smart contracts
- Chainlink provides data and external compution to smart contract
- Ethereum used the same blockchain infrastructure with an additional feature. Decentralized application, decentralized organization and build smart contracts and engage in agreements without third party, intermediary or centralized governing force.
- Smart contract is a self-executing set of instructions that is executed without a third party intermediary
- Bitcoin does also have smart contract however they are not touring complete, meaning, they don't have the full range of capabilities.
- The ethereum protocol has given rise to many new paradigms and industries including d5, nfts, dows or decentralized
- **Hybrid Smart Contract** combine on-chain and off-chain components

 - [Overview - 38:23](https://youtu.be/umepbfKp5rI?t=2304)
 - [Making a transaction - 46:55](https://youtu.be/umepbfKp5rI?t=2815)

### Explanation 
 - [Explain with example - 24:25](https://youtu.be/umepbfKp5rI?t=1467)

### Chainlink
 - [Chainlink Data Feeds](https://docs.chain.link/data-feeds) are the quickest way to connect your smart contracts to the real-world data such as asset prices, reserve balances, NFT floor prices, and L2 sequencer health
 - [Chainlink VRF](https://docs.chain.link/vrf) (Verifiable Random Function) is a provably fair and verifiable random number generator (RNG) that enables smart contracts to access random values without compromising security or usability. 
 - To [consume price data](https://docs.chain.link/data-feeds/using-data-feeds#solidity), your smart contract should reference AggregatorV3Interface, which defines the external functions implemented by Data Feeds.
 - [Chainlink Functions](https://docs.chain.link/chainlink-functions) provides your smart contracts access to trust-minimized compute infrastructure, allowing you to fetch data from APIs and perform custom computation.

### Characteristics 


1. Decentralized: Blockchain operates without a central authority, with network participants called node operators collectively maintaining and validating transactions.

2. Transparent: All transactions and rules on the blockchain are visible to everyone, promoting accountability and trust among users.

3. Speed: Transaction speed varies across blockchain networks and depends on factors like architecture and volume, with some aiming for faster processing times.

4. Immutable: Once recorded, data on the blockchain cannot be altered, ensuring the integrity and security of the information.

5. Remove Counterparty Risk: Blockchain eliminates the need for intermediaries, reducing counterparty risk associated with traditional systems.

6. Allow for Trust-Minimized Agreements: Smart contracts enable parties to execute agreements without relying on trust in a central authority, automatically enforcing terms.

7.Hybrid Smart Contracts: These contracts combine both on-chain and off-chain elements, offering flexibility while leveraging blockchain security and transparency.

### Digital wallet (Metamask) 00:25:00

- We must need to backup **Secret Recovery Phrase** in order to keep real money - if anyone has that recovery phrase he will have access to our wallet and all of the funds
- Install metamask chrome extension -> create account - account details -> export private key -> download and save private key -> copy address -> scan address with **https://etherscan.io** or **sepolia.etherscan.io** (for sepolia test net)
- One private key is only for one single account of our wallet
- Go to **https://faucets.chain.link/** conect to matamask -> login via Github -> send to our wallet

| **Concept**    | **Access**   | **Public or private** |     |
| -------------- | ------------ | --------------------- | --- |
| Mnemonic / Secret Phrase       | (*Keep private*) All accounts | Person X can send transactions from **any account** created in your metamask / wallet          |     |
| Private Key    | 1 Account    | (*Keep Private*) Person X can send transactions from any **one account** created in your metamask / wallet          |     |
| Public Address | Nothing      | Person X can see your transaction history         |     |

- When we work with eth, working with ethereum mainnet when intract with smart contract, d5, or any other mainnet real value to be working on mainnet
- There are some testnets to resemble ethereum before using it. Not real money this is just for testing

### Gas and transaction fees

- Whenever we do something on the block chain it cost [gas](https://youtu.be/umepbfKp5rI?t=6169). The amount of **gas** used and how much to pay depends on how **computationally expensive** the transaction is.
- Gas - [Measure of computation use](https://youtu.be/umepbfKp5rI?t=4120), more instructions takes more gas. in other ward, for complex transaction such as minting and NFT takes more gas
- Gas price - how much it costs per unit of gas
- Gas Limit - Max amount of gas in a transaction
- [Transaction fees](https://youtu.be/umepbfKp5rI?t=4010) - gas used x gas price
- E.g. 21000 gas @ 1 GWEI per gas = 21000 GWEI

 - To [convert Ether](https://eth-converter.com/) to Gwei and Wei, you need to understand their relative values.
 - 1 Ether (ETH) = 1,000,000,000 Gwei 1 Gwei = 1,000,000 Wei
 - So, to convert from Ether to Gwei, you multiply the amount of Ether by 1,000,000,000, and to convert from Ether to Wei, you multiply by 1,000,000,000,000,000,000.
 - Here are the conversion formulas:
 - Ether to Gwei: Gwei=Ether×1,000,000,000Gwei=Ether×1,000,000,000
 - Ether to Wei: Wei=Ether×1,000,000,000,000,000,000Wei=Ether×1,000,000,000,000,000,000
 - For example, if you have 2 Ether, to convert it into Gwei and Wei:
 - Converting to Gwei: Gwei=2×1,000,000,000=2,000,000,000 GweiGwei=2×1,000,000,000=2,000,000,000 Gwei
 - Converting to Wei: Wei=2×1,000,000,000,000,000,000=2,000,000,000,000,000,000 WeiWei=2×1,000,000,000,000,000,000=2,000,000,000,000,000,000 Wei
 - So, 2 Ether is equal to 2,000,000,000 Gwei and 2,000,000,000,000,000,000 Wei.

### Blockchain demo
- [Basics - 01:31:05](https://youtu.be/umepbfKp5rI?t=5465)

### Concept definations

0.  Get ideas of [blockchain intractivly](https://andersbrownworth.com/). [Explain blockchain](https://youtu.be/umepbfKp5rI?t=4556)
1.  **Hash** - Unique fixed length string to identify a peace of data
2.  **Hash Algorithms** - A function that computes data into a unique hash
3.  **Mining** - the process of finding solutions to the blockchain problem. e.g. The problem to find a hash that starts with 4 zeros. nodes get paid for mining block.
4.  **Block** - a list of transactions mined together
5.  **Decentralized** - having no single point of authority
6.  **Nonce** - a number used once to find the solution to the blockchain problem. It's also used to define the transaction number for an account/address.
7.  **Nonce** - a number used once to find the solution to the blockchain problem.
8. **The [genesis block - 01:22:00](https://youtu.be/umepbfKp5rI?t=4942)** is the first block in a blockchain network. It serves as the foundation for the entire blockchain and is unique because it does not reference a previous block. Instead, it is hardcoded into the software of the blockchain network and is typically created by the creator(s) of the blockchain.
8.  **Private key** - Only known to the key holder, it is used to sign transactions
9.  **Public key** - is derived from private key. Anyone can see it, and use it to verify that a transaction came from.
10. Private key -> public key -> address

- [Attacks](https://youtu.be/umepbfKp5rI?t=7721)
- Scalability -> sharding -> layer 1: base layer blockchain implementation such as block chain -> layer 2: any application that is build on top of a layer 2 such chainlink
 - *Attacks:* Refers to malicious activities aimed at disrupting or manipulating a blockchain network. Examples include double-spending attacks, where a user spends the same digital asset twice, or a denial-of-service attack, where the network is overwhelmed with traffic to halt operations.
 - *Proof of Work (PoW):* A consensus mechanism used in blockchain networks to validate and confirm transactions. Miners compete to solve complex mathematical puzzles, and the first one to solve it gets the right to add a new block to the blockchain. Bitcoin is a prominent example of a blockchain that uses PoW.
 - *Proof of Stake (PoS):* Another consensus mechanism where the creator of the next block is chosen via various combinations of random selection and wealth or age (i.e., the stake). Ethereum is transitioning to PoS with its Ethereum 2.0 upgrade. In PoS, validators are chosen to create blocks based on the number of coins they hold and are willing to "stake" as collateral.
 - *51% Attack:* A situation where a single entity or a group controls over 51% of the network's mining power, enabling them to manipulate transactions, double-spend coins, or halt the network's operations. It undermines the decentralization and security of a blockchain. For instance, if a single miner or coalition of miners controls the majority of the network's computational power in a PoW system, they could potentially execute a 51% attack.
 - *Sharding:* A technique used to improve the scalability of blockchain networks by partitioning the database into smaller, more manageable parts called shards. Each shard contains its subset of transaction history and smart contracts, allowing for parallel processing. Ethereum 2.0 is implementing sharding to enhance its scalability.
 - *Rollups:* A scaling solution for Ethereum and other blockchains that aggregates multiple transactions off-chain into a single transaction on-chain. This helps reduce the computational load and transaction fees while maintaining security. Rollups can be implemented in different ways, such as Optimistic Rollups and zkRollups.
 - *Layer 1:* The base layer of a blockchain protocol, where fundamental consensus and validation mechanisms reside. Examples include Bitcoin and Ethereum mainnets. Changes or upgrades to the layer 1 protocol require a hard fork, which can be contentious and disruptive.
 - *Layer 2:* Additional protocols or solutions built on top of layer 1 blockchains to improve scalability, speed, and functionality. Layer 2 solutions include payment channels (e.g., Lightning Network for Bitcoin), sidechains, and off-chain computation platforms (e.g., Plasma for Ethereum). They aim to handle a significant portion of transactions off-chain, reducing congestion and fees on the layer 1 blockchain. 

### Consensus Mechanism
 - Certainly, [consensus mechanisms](https://youtu.be/umepbfKp5rI?t=6980) play a critical role in blockchain networks, ensuring that all participants agree on the state of the network and the validity of transactions. Let's delve deeper into "Chain Selection" and "Sybil Resistance":
 1. Chain Selection:
    - Definition: Chain selection is the process by which nodes in a blockchain network decide which chain of blocks to follow as the correct one.
    - Importance: It ensures that all participants in the network agree on the same version of the truth, resolving conflicts when multiple valid blocks are proposed simultaneously.
    - Example: In Bitcoin, the longest chain with the most accumulated computational work (Proof of Work) is considered the valid one.
 2. Sybil Resistance:
    - Definition: Sybil resistance is the network's ability to resist attacks where a single entity creates multiple fake identities to manipulate the network.
    - Importance: It prevents malicious actors from overwhelming the network and compromising its integrity.
    - Example: In Proof of Work, miners invest computational power to solve puzzles, while in Proof of Stake, participants must stake cryptocurrency as collateral.
- Both concepts are vital for ensuring the security, integrity, and decentralization of blockchain networks.

### Reacp 01:28:00

- ETH and BTC are both proof of work (in 2022),
- ETH 2.0 will be proof of stake
- POW & POS are sybil resistance mechanisms
- The bigger the blockchain, the more secure
- Consensus is how blockchain decide what the state of the chain is
- Sharding and rollups are scalability solutions
- Only so many transactions can fit into a block

### Layer 2
 - Layer 2 refers to secondary frameworks or protocols built on top of existing blockchain networks like Ethereum. These solutions aim to improve scalability and reduce transaction costs by processing transactions off-chain or in a more efficient manner, while still leveraging the security of the underlying blockchain when necessary.
 - **EVM (Ethereum Virtual Machine):** EVM is the runtime environment for smart contracts in Ethereum. It executes smart contracts' bytecode and is responsible for the decentralized execution of code.
 - **Ethereum:** Ethereum is a decentralized platform that enables developers to build and deploy smart contracts and decentralized applications (DApps). It's based on blockchain technology and utilizes the EVM for executing smart contracts.
 - **Polygon:** Polygon is a protocol and framework for building and connecting Ethereum-compatible blockchain networks. It aims to improve Ethereum's scalability, making it more efficient for decentralized applications and transactions.
 - **Arbitrum:** Arbitrum is a layer 2 scaling solution for Ethereum. It uses rollups to increase transaction throughput and reduce fees on the Ethereum network, while maintaining compatibility with Ethereum smart contracts.
 - **Optimism:** Optimism is another layer 2 scaling solution for Ethereum. It employs optimistic rollups to enhance scalability and reduce transaction costs by aggregating multiple transactions off-chain before committing them to the Ethereum blockchain.
 - **Zksync:** Zksync is a layer 2 scaling solution for Ethereum focused on using zero-knowledge proofs to enable fast and low-cost transactions off-chain while maintaining the security guarantees of the Ethereum blockchain.

### Solidity code 01:29:25

- [Lesson 1: Welcome to Remix! Simple Storage](https://github.com/smartcontractkit/full-blockchain-solidity-course-py#lesson-1-welcome-to-remix-simple-storage) -> [Github code](https://github.com/PatrickAlphaC/simple_storage) -> [remix ide](https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.7+commit.e28d00a7.js)
- [Lesson 2: Storage Factory 02:09:30](https://github.com/PatrickAlphaC/storage_factory)
- [Lesson 3: fund me 02:26:30](https://github.com/smartcontractkit/full-blockchain-solidity-course-py#lesson-3-fund-me)
- [Lesson 4: Simple Storage Python 03:32:50](https://github.com/PatrickAlphaC/web3_py_simple_storage)
- [Chainlink](https://data.chain.link/)

### Witdraw
 - There are 3 different ways to send native blockchain currencies
 - Transfer
 - Send
 - Call

### AI & Prompting
 1. Tinker
 2. Ask your AI
    There are 6 principles of Prompt engeenring
      A. Write cean and specific instructions
      B. Give as uch context as possible
      C. Use delimiters to clearly indicate distinct parts of the input
      D. Look out for hallucinations
 3. Read docs
 4. Web Search
 5. Ask in a forum
 6. Ask on support forum or github
 7. Iterate

### Setup local environment
 - Install [foundry](https://book.getfoundry.sh/) to run solidity project
  ```
  curl -L https://foundry.paradigm.xyz | bash
  source /home/shayon/.bashrc
  foundryup
  forge --version
  cast --version
  anvil --version
  chisel --version
  ```
 - To start a [new project](https://book.getfoundry.sh/projects/creating-a-new-project) with Foundry, use `forge init`:

### Deploy with python on local environment

- [**Ganache**](https://trufflesuite.com/ganache/) - Quickly fire up a personal Ethereum blockchain which you can use to run tests, execute commands, and inspect state while controlling how the chain operates.
- Download, install and quickstart ganache desktop - (03:50:00)
- We can also use ganache cli - (04:18:00) (more friendly for programmer)
  ```
  sudo npm install --global yarn
  yarn global add ganache-cli
  // or
  sudo npm install --global ganache-cli
  ganache --version
  ```
- deploy with ganache cli in terminal

```
# keep ganache cli running
ganache -d
# run the code on another terminal or tab
python3 deploy.py
```

- [Install web3.py](https://pypi.org/project/web3/) `pip install web3`
- Intract with real network / mainnet instead of testnet (04:23:00)
- Run [geth](https://github.com/ethereum/go-ethereum) external library to run bloackchain for us
- Get blockchain url for free using [infura](https://infura.io/). alternative: [alchemy](https://www.alchemy.com/)
- In infura -> create project / keys -> endpoints -> network endpoints -> rinkeby

- [Brownie](https://github.com/eth-brownie/brownie) Simple Storage (04:27:43) - A Python-based development and testing framework for smart contracts targeting the Ethereum Virtual Machine.
- deactivate virtual environment and [install brownie](https://github.com/eth-brownie/brownie#installation)
- Initialize the project with `brownie init`

```
  brownie init
  brownie compile
  brownie
  brownie run scripts/deploy.py
```

- Add our account to brownie with metamask private key (most secure way)

```
  brownie accounts new brownie-shayon-account
  brownie accounts list
  brownie run scripts/deploy.py
  brownie accounts delete brownie-shayon-account

```

- Should not put private keys associated with wallets and that have real in them as environment variable or in a dot env file, We can do this for test account
- For more serious serious account we are going to use encryption with brownie account
- modify Brownie’s default behaviours by creating an optional [configuration file](https://eth-brownie.readthedocs.io/en/stable/config.html). The configuration file must be saved as **brownie-config.yaml**

### [Testing](https://docs.pytest.org/en/7.1.x/) 04:46:50

- We should not always manually check all of our stuff what we want to do
- Automating test is crutial to becoming a successfull smart contract developer
- We can write test directly in solidity
- However, most of the start contract developer like to code their test in the smart contract development framework such as web3.py in python, web3.js in javascript, brownie in python.
- This allows lots of flexibility and customization
- Running the tests

  ```
  brownie test
  # Running one single test (mention name of the test function)
  brownie test -k test_updating_storage
  # If the test is failed python shell we be opened and we can intract with program, see values of variables
  brownie test --pdb
  # Robust
  brownie test -s
  ```

- Deploying in real rinkeby network

```
brownie networks list
brownie run scripts/deploy.py --network rinkeby
```

- See brownie deployed contract `brownie run scripts/read_value.py --network rinkeby`
- [Brownie shell](https://eth-brownie.readthedocs.io/en/stable/interaction.html) - in terminal write `brownie console`

```
 Brownie v1.19.0 - Python development framework for Ethereum

 BrownieProject is the active project.

 Launching 'ganache-cli --chain.vmErrorsOnRPCResponse true --server.port 8545 --miner.blockGasLimit 12000000 --wallet.totalAccounts 10 --hardfork istanbul --wallet.mnemonic brownie'...
 Brownie environment is ready.
 >>> SimpleStorage
 []
 >>> account = accounts[0
 ... ]
 >>> account
 <Account '0x66aB6D9362d4F35596279692F0251Db635165871'>
 >>> simple_storage = SimpleStorage.deploy({"from": account})
 Transaction sent: 0xc28ea1487d026207abe7ffa99311c511cf7bd17f8c8651e5e00ed0cf37ca38b6
   Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
   SimpleStorage.constructor confirmed   Block: 1   Gas used: 481093 (4.01%)
   SimpleStorage deployed at: 0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87

 >>> simple_storage
 <SimpleStorage Contract '0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87'>
 >>> SimpleStorage
 [<SimpleStorage Contract '0x3194cBDC3dbcd3E11a07892e7bA5c3394048Cc87'>]
 >>> len(SimpleStorage)
 1
 >>> simple_storage = SimpleStorage.deploy({"from": account})
 Transaction sent: 0x147c104f69d2037e2b6713f60f888dabe8d480785dc505a226bf60ff12ac0be4
   Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 1
   SimpleStorage.constructor confirmed   Block: 2   Gas used: 481093 (4.01%)
   SimpleStorage deployed at: 0x602C71e4DAC47a042Ee7f46E0aee17F94A3bA0B6

 >>> len(SimpleStorage)
 2
 >>> simple_storage.retrive()
 0
 >>> simple_storage.store(15, {"from": account})
 Transaction sent: 0x47e2b7e5c925a1446f6f0bc8b24e120336f9d9c2410f0da432e35e9eacbbf3f1
   Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 2
   SimpleStorage.store confirmed   Block: 3   Gas used: 41438 (0.35%)

 <Transaction '0x47e2b7e5c925a1446f6f0bc8b24e120336f9d9c2410f0da432e35e9eacbbf3f1'>
 >>> simple_storage.retrive()
 15
 >>> print("brownie shell is a python shell with all of our smart contract feature included")
 brownie shell is a python shell with all of our smart contract feature included
 >>> quit()
 Terminating local RPC client...
 shayon@shayon-X556UQK:~/Documents/python-blockchain/03_brownie_simple_storage/brownie_project$
```

### Fund me project with brownie (05:06:20)

 - Unlink remix brownie on local machine does not understand npm package, so we have to add [brownie chainlink contract](https://github.com/smartcontractkit/chainlink-brownie-contracts)
 - Verify start contract - there are two different ways 1. manually 2. programmatically
 - **Manually** - go to __https://rinkeby.etherscan.io__ -> search with contract address -> Contract -> click on Verify and Publish link -> 
 - **Programmatically** - Go to etherscan.io -> signup -> sign in - my profile -> api keys ->  to get api key
 - We need that API key to programmatically verify our smart contract on etherscan
 - Deploing mocsk, deploing on local ganache, deploying on rinkeby network
 ```
 brownie networks list
 brownie add Ethereum ganache-local host=http://127.0.0.1:7545 chainid=1337
 # Keep ganache desktop open
 brownie networks modify ganache-local chainid=1337
 brownie run scripts/deploy.py --network ganache-local
 ```
 - Intract with it (withdraw and funds) (05:42:00)

___

## Latest tutorial
 - [(19:26:00) | Advanced Foundry](https://youtu.be/-1GB6m39-rM?t=70012)
 - [ERC](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) - Ethereum Requests for Comments
 - [EIP](https://eips.ethereum.org/) - Ethereum Improvement Proposal

### Resources For This Course
  AI Frens
  ChatGPT
  Just know that it will often get things wrong, but it's very fast!
  Phind
  Like ChatGPT, but it searches the web
  Bard
  Other AI extensions
  Github Discussions
  Ask questions and chat about the course here!
  Stack Exchange Ethereum
  Great place for asking technical questions about Ethereum
  Peeranha
  Decentralized Stack Exchange!

### More 
 - [Build a Blockchain with Python & FastAPI](https://www.youtube.com/watch?v=G5M4bsxR-7E)
 - [Blockchain Programming with Python: Free Bonus Lessons](https://www.youtube.com/watch?v=nhA9I_RYxgQ)
curl -d "address=MY_CONTRACT_ADDRESS" "https://api-ropsten.etherscan.io/api?module=contract&action=verifyproxycontract&apikey=H1AD2KZ9Q7IUZ67YF5CUTFCCT3P2DWIQ89"


Till 06:57:16 - https://youtu.be/umepbfKp5rI?t=25036
Rivision 01:30:00 - https://youtu.be/umepbfKp5rI?t=5454

 - Next - https://www.youtube.com/watch?v=sas02qSFZ74
### More
 - https://www.youtube.com/watch?v=jcgfQEbptdo
 - https://www.youtube.com/watch?v=jcgfQEbptdo