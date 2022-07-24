from brownie import accounts, config, SimpleStorage # Name of the contract
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

    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})



def main():
    deploy_simple_storage()