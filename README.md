# Python Blockchain

- [tutorials](https://www.youtube.com/watch?v=M576WGiDBdQ&t=2627s), [docs](https://github.com/smartcontractkit/full-blockchain-solidity-course-py)

### Blockchain 00:06:25

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

### Characteristics 00:15:06

1. Decentralized: Blockchain operates without a central authority, with network participants called node operators collectively maintaining and validating transactions.

2. Transparent: All transactions and rules on the blockchain are visible to everyone, promoting accountability and trust among users.

3. Speed: Transaction speed varies across blockchain networks and depends on factors like architecture and volume, with some aiming for faster processing times.

4. Immutable: Once recorded, data on the blockchain cannot be altered, ensuring the integrity and security of the information.

5. Remove Counterparty Risk: Blockchain eliminates the need for intermediaries, reducing counterparty risk associated with traditional systems.

6. Allow for Trust-Minimized Agreements: Smart contracts enable parties to execute agreements without relying on trust in a central authority, automatically enforcing terms.

7.Hybrid Smart Contracts: These contracts combine both on-chain and off-chain elements, offering flexibility while leveraging blockchain security and transparency.

### Digital wallet (Metamask) 00:25:00

- We must need to backup **Secret Recovery Phrase** in order to keep real money - if anyone has that recovery phrase he will have access to our wallet and all of the funds
- Install metamask chrome extension -> create account - account details -> export private key -> download and save private key -> copy address -> scan address with **https://etherscan.io** or **https://rinkeby.etherscan.io** (for testing)
- One private key is only for one single account of our wallet
- Make a tweet with ether address and post the tweet here **https://faucet.rinkeby.io/** to get free testing ether

| **Concept**    | **Access**   | **Public or private** |     |
| -------------- | ------------ | --------------------- | --- |
| Mnemonic       | All accounts | Keep Private          |     |
| Private Key    | 1 Account    | Keep Private          |     |
| Public Address | Nothing      | It is public          |     |

- When we work with eth, working with ethereum mainnet when intract with smart contract, d5, or any other mainnet real value to be working on mainnet
- There are some testnets to resemble ethereum before using it. Not real money this is just for testing














Completed till 35.00












### Gas 00:36:52

- Whenever we do something on the block chain it cost gas. The amount of **gas** used and how much to pay depends on how **computationally expensive** the transaction is.
- Gas - Measure of computation use
- Gas price - how much it costs per unit of gas
- Gas Limit - Max amount of gas in a transaction
- Transaction fees - gas used x gas price
- E.g. 21000 gas @ 1 GWEI per gas = 21000 GWEI

### Blockchain demo 00:44:25

### Concept definations - (01:00:00)

0.  Get ideas of [blockchain](https://andersbrownworth.com/)
1.  **Hash** - Unique fixed length string to identify a peace of data
2.  **Hash Algorithms** - A function that computes data into a unique hash
3.  **Mining** - the process of finding solutions to the blockchain problem. e.g. The problem to find a hash that starts with 4 zeros. nodes get paid for mining block.
4.  **Block** - a list of transactions mined together
5.  **Decentralized** - having no single point of authority
6.  **Nonce** - a number used once to find the solution to the blockchain problem. It's also used to define the transaction number for an account/address.
7.  **Nonce** - a number used once to find the solution to the blockchain problem.
8.  **Private key** - Only known to the key holder, it is used to sign transactions
9.  **Public key** - is derived from private key. Anyone can see it, and use it to verify that a transaction came from.
10. Private key -> public key -> address

- Attacks - 01:19:28
- Scalability -> sharding -> layer 1: base layer blockchain implementation -> layer 2: any application that is build on top of a layer 2 - 01:25:32

### Reacp 01:28:00

- ETH and BTC are both proof of work (in 2022),
- ETH 2.0 will be proof of stake
- POW & POS are sybil resistance mechanisms
- The bigger the blockchain, the more secure
- Consensus is how blockchain decide what the state of the chain is
- Sharding and rollups are scalability solutions
- Only so many transactions can fit into a block

### Solidity code 01:29:25

- [Lesson 1: Welcome to Remix! Simple Storage](https://github.com/smartcontractkit/full-blockchain-solidity-course-py#lesson-1-welcome-to-remix-simple-storage) -> [Github code](https://github.com/PatrickAlphaC/simple_storage) -> [remix ide](https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.7+commit.e28d00a7.js)
- [Lesson 2: Storage Factory 02:09:30](https://github.com/PatrickAlphaC/storage_factory)
- [Lesson 3: fund me 02:26:30](https://github.com/smartcontractkit/full-blockchain-solidity-course-py#lesson-3-fund-me)
- [Lesson 4: Simple Storage Python 03:32:50](https://github.com/PatrickAlphaC/web3_py_simple_storage)
- [Chainlink](https://data.chain.link/)

### Deploy with python on local environment 03:28:00

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


Rivision 02:26:00
Till 05:35:00

### More 
 - [Build a Blockchain with Python & FastAPI](https://www.youtube.com/watch?v=G5M4bsxR-7E)
 - [Blockchain Programming with Python: Free Bonus Lessons](https://www.youtube.com/watch?v=nhA9I_RYxgQ)
curl -d "address=MY_CONTRACT_ADDRESS" "https://api-ropsten.etherscan.io/api?module=contract&action=verifyproxycontract&apikey=H1AD2KZ9Q7IUZ67YF5CUTFCCT3P2DWIQ89"