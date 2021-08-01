# Python Blockchain
 - [tutorials](https://www.youtube.com/watch?v=pZSegEXtgAE)
 - [Web3.py](https://web3py.readthedocs.io/en/stable/index.html) is a Python library for interacting with Ethereum.
 - [Infura's](https://infura.io/) development suite provides instant, scalable API access to the Ethereum and IPFS networks.
 - Create an Ethereum project in Infura and get the end point
 - Install  all of those for working correctly with venv
```
sudo apt update
sudo apt install python3-dev
sudo apt install libpython3.8-dev
sudo apt install python3-devel
sudo apt-get install libevent-dev
sudo apt update
```

 - Create project folder and activate venv
```
mkdir python-blockchain
cd python-blockchain
python3 -m venv venv
source venv/bin/activate
```
 - Essential pip commands
```
pip install -r requirements.txt
pip install web3
pip list
pip uninstall packagename
```

 - Test the connection
```
(venv) shayon@shayon-X556UQK:~/Documents/python-blockchain$ python
Python 3.8.10 (default, Jun  2 2021, 10:49:15) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from web3 import Web3
>>> infura_url = "https://mainnet.infura.io/v3/ef71fa39424f4e6482f9a1097ffd1df0"
>>> web3 = Web3(Web3.HTTPProvider(infura_url))
>>> web3.isConnected()
True
>>> web3.eth.blockNumber
12939474
>>> web3.eth.blockNumber
12939474
>>> balance = web3.eth.get_balance('meta-mask-id')
>>> balance
>>> web3.fromWei(balance, 'ether')
```

 - [Etherscan](https://etherscan.io/) is a Block Explorer and Analytics Platform for Ethereum, a decentralized smart contracts platform. Preferences. Company. About Us · Advertise .





