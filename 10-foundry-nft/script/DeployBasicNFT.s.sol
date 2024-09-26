// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title DeployBasicNFT Script
 * @dev This contract is used to deploy the `BasicNFT` contract.
 * It uses Foundry's `Script` to automate the deployment process. 
 * The contract deploys an instance of `BasicNFT` and returns its address.
 * 
 * Foundry is a popular testing and development framework for Solidity projects.
 * The `Script` contract from Foundry provides useful methods for scripting deployments and interactions with contracts.
 * 
 * Links for reference:
 * - Foundry Documentation: https://book.getfoundry.sh/
 * - Script.sol: https://github.com/foundry-rs/forge-std/blob/master/src/Script.sol
 */

// Importing Foundry's Script functionality to automate contract deployment.
import {Script} from "forge-std/Script.sol";

// Importing the BasicNFT contract to be deployed.
import {BasicNFT} from "src/BasicNFT.sol";

/**
 * @title DeployBasicNFT Contract
 * @dev This contract is used to deploy the BasicNFT contract using Foundry's scripting tools.
 */
contract DeployBasicNFT is Script {

    /**
     * @notice The `run` function automates the process of deploying the BasicNFT contract.
     * @dev This function uses Foundry's virtual machine (VM) to broadcast transactions, 
     *      which is necessary for deploying a contract to the blockchain.
     * @dev The function returns the deployed instance of the `BasicNFT` contract.
     * @return basicNft The deployed instance of the `BasicNFT` contract.
     */
    function run() external returns(BasicNFT) {
        // Start broadcasting transactions. This tells the VM that transactions will be sent.
        vm.startBroadcast();

        // Deploy a new instance of the BasicNFT contract.
        BasicNFT basicNft = new BasicNFT();

        // Stop broadcasting transactions. No more transactions will be broadcast after this point.
        vm.stopBroadcast();

        // Return the deployed instance of the BasicNFT contract.
        return basicNft;
    }
}
