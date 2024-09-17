// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * 1. Deploy mocks when we are on a local anvil chain
 * 2. Keep track of contract address across different chains
 * Sepolica ETH/USD
 * Mainnet ETH/USD
 */

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";


contract HelperConfig is Script{
    // If we are on a local anvil, we deploy mocks
    // Otherwise, gtrab the existing address from the live network

    struct NetworkConfig{
        address priceFeed; // ETH/USD price feed address
    }

    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;


    constructor(){
        /**
         * block.chainid (uint): current chain id
         * https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties
         * See all chain IDs https://chainlist.org/
         * Sepolia chainid = 11155111
         * Ethereum chainid = 1
         */
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }else if (block.chainid == 1){
            activeNetworkConfig = getMainnetEthConfig();
        } else{
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        /**
         * Price Feed Contract Addresses: https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
         */
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306}); // Sepolia Mainnet -> ETH / USD
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns(NetworkConfig memory){
        /**
         * Price Feed Contract Addresses: https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
         */
        NetworkConfig memory ethConfig = NetworkConfig({priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419}); // Ethereum Mainnet -> ETH / USD
        return ethConfig;
    }

    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory){
        if (activeNetworkConfig.priceFeed != address(0)){
            return activeNetworkConfig;
        }
        // Deploy the mock
        // Return the mock address 

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }
}