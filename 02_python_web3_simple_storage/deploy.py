from solcx import compile_standard, install_solc
import json
from web3 import Web3
import os
from dotenv import load_dotenv

load_dotenv()

install_solc("0.6.0")

with open("./SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()
    # print(simple_storage_file)

# Compile out solidity
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {"*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]}
            }
        },
    },
    solc_version="0.6.0",
)

# print(compiled_sol)
with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)


# obtain bytecode
bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"][
    "bytecode"
]["object"]


# Obtain abi
abi = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["abi"]
# print(abi)

# for connecting to rinkeby - simulated fake blockchain
w3 = Web3(
    Web3.HTTPProvider("https://rinkeby.infura.io/v3/152f73e788284076be9b2673b1aff7ca")
)  # In infura -> create project / keys -> endpoints -> network endpoints -> rinkeby
chain_id = 4  # Boba Network Rinkeby Testnet - https://chainlist.org/chain/4
my_address = "0x459b23aE775b440eED6aE098926D5CFc1bBe80c8"  # use a real address from metamask account


# Set up private on linux or macos terminal Once we close the terminal the key will be gone
# export PRIVATE_KEY=0x8eed9734abe4064d69d712cca834f80a0bbe497430669788330b217676bc5a4d
# echo $PRIVATE_KEY
private_key = os.getenv(
    "PRIVATE_KEY"
)  # private key of the address and add 0x infront of that key
# print(private_key)

# Create the contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)
# print(SimpleStorage) e.g. <class 'web3._utils.datatypes.Contract'>

# obtain nonce by grabbing latest transactions
nonce = w3.eth.getTransactionCount(my_address)
# print(nonce) # if this has not been used we will get 0 - that mean no transaction occured

# Step-1: Build a transaction
transaction = SimpleStorage.constructor().buildTransaction(
    {
        "gasPrice": w3.eth.gas_price,
        "chainId": chain_id,
        "from": my_address,
        "nonce": nonce,
    }
)
# print(transaction)

print("Deploying contract")
# Step-2: Sign a transaction
singed_transaction = w3.eth.account.sign_transaction(
    transaction, private_key=private_key
)
# print(singed_transaction)

# Step-3: Send a transaction
tx_hash = w3.eth.send_raw_transaction(
    singed_transaction.rawTransaction
)  # we will have a transaction on ganache after running this

tx_receipt = w3.eth.wait_for_transaction_receipt(
    tx_hash
)  # wait until the transaction is succeed
print("deployed!")


# Working with contract - contract need two things
# 1 - Contract address
# 2 - Contract ABI
simple_storage = w3.eth.contract(address="address", abi=abi)
# there is a retrive function in SimpleStorage.sol
# Call  -> Simulate making the call and retrive a return value
# Transace -> actually make a state change
# initial value of favorite number
print(simple_storage.functions.retrive().call())  # call transaction
print("Updating contract")
# print(simple_storage.functions.store(15).call())
store_transaction = simple_storage.functions.store(15).buildTransaction(
    {
        "gasPrice": w3.eth.gas_price,
        "chainId": chain_id,
        "from": my_address,
        "nonce": nonce + 1,
    }
)
signed_store_txn = w3.eth.account.sign_transaction(
    store_transaction, private_key=private_key
)
send_store_tx = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(send_store_tx)
print("Updated")
print(simple_storage.functions.retrive().call())  # 15
