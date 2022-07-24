# Testing 04:46:50

from brownie import SimpleStorage, accounts

# We should not always manually check all of our stuff what we want to do 
# Automating test is crutial  to becoming a successfull smart contract developer 
# We can write test directly in solidity 
# However, most of the start contract developer like to code their test in the smart contract development framework such as web3.py in python, web3.js in javascript
# This allows lots of flexibility and customization


def test_deploy():
    # Arrange
    account = accounts[0]

    # Act
    simple_storage = SimpleStorage.deploy({"from": account})
    starting_value = simple_storage.retrive()
    expected = 0

    # Assert
    assert starting_value == expected


def test_updating_storage():
    # Arrange
    account = accounts[0]

    # Act
    expected = 15
    simple_storage = SimpleStorage.deploy({"from": account})
    simple_storage.store(expected, {"from": account})
    updated_value = simple_storage.retrive()

    # Assert
    assert updated_value == expected