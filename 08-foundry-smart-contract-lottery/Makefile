-include .env

.PHONY: all test deploy

build :; forge build

test :; forge test

install :; forge install foundry-rs/forge-std@v1.9.2 --no-commit && forge install Cyfrin/foundry-devops --no-commit && git clone https://github.com/smartcontractkit/chainlink-brownie-contracts.git lib/chainlink-brownie-contracts && forge install transmissions11/solmate --no-commit 


# deploy-sepolia:
# 	@forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA_RPC_URL) --account myaccount --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia:
	@forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv


deploy-anvil: 