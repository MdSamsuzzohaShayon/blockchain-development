// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * 1. Deploy mocks when we are on a local anvil chain
 * 2. Keep track of contract address across different chains
 * Sepolica ETH/USD
 * Mainnet ETH/USD
 */

import {Script} from "forge-std/Script.sol";


contract HelperConfig{
    // If we are on a local anvil, we deploy mocks
    // Otherwise, gtrab the existing address from the live network

    struct NetworkConfig{
        address priceFeed; // ETH/USD price feed address
    }

    NetworkConfig public activeNetworkConfig;

    constructor(){
        /**
         * block.chainid (uint): current chain id
         * https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties
         * See all chain IDs https://chainlist.org/
         * Sepolia chainid = 11155111
         */
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }else{
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getAnvilEthConfig() public pure returns(NetworkConfig memory){

    }
}