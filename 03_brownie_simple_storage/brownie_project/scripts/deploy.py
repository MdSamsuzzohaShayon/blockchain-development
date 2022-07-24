from brownie import accounts, network, config, SimpleStorage # Name of the contract
import os

def deploy_simple_storage():
    # account  = accounts[0] 
    # print(account) 

    # create new account using brownie in the terminal
    # account = accounts.load("brownie-shayon-account") # password - Test1234
    # print(account)

    # account = accounts.add(os.getenv("PRIVATE_KEY"))
    # print(account)

    # account = accounts.add(config['wallets']["from_key"])
    # print(account)

    account = get_account()
    simple_storage = SimpleStorage.deploy({"from": account})
    stored_value = simple_storage.retrive()
    print(stored_value)
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1)
    updated_store = simple_storage.retrive()
    print(updated_store)

def get_account():
    if(network.show_active() == "development"):
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])





def main():
    deploy_simple_storage()