// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.sol";


contract DeployFundMe is Script{
    function run()external returns (FundMe){
        // Before start broadcast -> Not a real transaction (We do not need to spend extra gas)
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // After startBroadcast it is a real transaction
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return  fundMe;
    }

}

// forge script script/DeployFundMe.s.sol