// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

// 07:27:00 - https://youtu.be/umepbfKp5rI?t=26827

/**
 * Solidity scripting is a way to declaratively deploy contracts using Solidity, 
 * instead of using the more limiting and less user friendly forge create. Solidity 
 * scripts are like the scripts you write when working with tools like Hardhat; 
 * what makes Solidity scripting different is that they are written in Solidity 
 * instead of JavaScript, and they are run on the fast Foundry EVM backend, 
 * which provides dry-run capabilities.
 * https://book.getfoundry.sh/tutorials/solidity-scripting
 *
 * we have to create a folder and name it script and create a file in it called 
 * NFT.s.sol. This is where we will create the deployment script itself.
 * https://book.getfoundry.sh/tutorials/solidity-scripting#writing-the-script
 *
 * Forge Standard Library Reference
 * https://book.getfoundry.sh/reference/forge-std/
 */

contract DeploySimpleStorage is Script{
    function run() external returns(SimpleStorage){

        /**
         * Local Simulation - The contract script is run in a local evm. If a rpc/fork 
         * url has been provided, it will execute the script in that context. Any external 
         * call (not static, not internal) from a vm.broadcast and/or vm.startBroadcast 
         * will be appended to a list.
         * https://book.getfoundry.sh/tutorials/solidity-scripting#high-level-overview
         */
        vm.startBroadcast();// VM only works on foundry
        SimpleStorage simpleStorage = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}