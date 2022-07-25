from brownie import FundMe, MockV3Aggregator, network, config
from .helpful_scripts import deploy_mocks, get_account, LOCAL_BLOCKCHAIN_ENVIRONMENTS




def deploy_fund_me():
    account = get_account()
    # Verify and deploy - publish source code
    # Pass the price feed address to our fundme contract
    # // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e this is a real contract can be found in Ethereum Data Feeds - https://docs.chain.link/docs/ethereum-addresses/
    # if we are on a presistent network like rinkeby, use associated address otherwise, deploy mocks
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        price_feed_address = config["networks"][network.show_active()]["eth_usd_price_feed"]
    else:
        deploy_mocks()   
        price_feed_address = MockV3Aggregator[-1].address
        print("Mock deployed!")


    fund_me = FundMe.deploy(price_feed_address,{"from": account}, publish_source=config["networks"][network.show_active()].get("verify"))
    print(f"Contract deployed to {fund_me}")


def main():
    deploy_fund_me()
