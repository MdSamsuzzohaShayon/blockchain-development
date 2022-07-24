# read value directly from rinkeby blockchain 
from brownie import SimpleStorage, accounts, config ## simple storage already deployed
# brownie run scripts/read_value.py

def read_contract():
    # print(SimpleStorage)
    # print(SimpleStorage[0]) # get recent deployed contract using index -1 and run command brownie run scripts/read_value.py  --network rinkeby
    # for ss in SimpleStorage:
    #     print("Simple Storage - " +ss)
    simple_storage = SimpleStorage[-1]
    print(simple_storage.retrive())

def main ():
    read_contract()