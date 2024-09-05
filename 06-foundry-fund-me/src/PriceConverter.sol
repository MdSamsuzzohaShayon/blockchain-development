// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * https://solidity-by-example.org/library/
 * Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.
 * A library is embedded into the contract if all library functions are internal.
 *
 * https://docs.soliditylang.org/en/v0.8.25/contracts.html#libraries
 * Libraries are similar to contracts, but their purpose is that they are deployed only once at a specific address and their code is reused using
 * the DELEGATECALL (CALLCODE until Homestead) feature of the EVM. This means that if library functions are called, their code is executed in the
 * context of the calling contract, i.e. this points to the calling contract, and especially the storage from the calling contract can be accessed.
 */

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
        /**
         * To work with an contract we need Address of that contract and ABI
         * To consume price data, your smart contract should reference AggregatorV3Interface, which defines the external functions implemented by Data Feeds.
         * https://docs.chain.link/data-feeds/using-data-feeds#solidity
         * https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol
         *
         * Get address from here https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
         * Network: Sepolia Testnet
         * Aggregator: ETH/USD
         * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
         */


        (
            ,
            /* uint80 roundID */ int price /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/,
            ,
            ,

        ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        // 1 ETH = 2000,000000000000000000
        uint256 ethPrice = getPrice(priceFeed);
        // (2000,000000000000000000 * 1,000000000000000000) / 1e18
        // $2000 = 1 ETH
        uint256 ethAmmountInUSD = (ethPrice * ethAmount) / 1e18; // https://youtu.be/umepbfKp5rI?t=17564
        return ethAmmountInUSD;
    }

    // function getVersion() public view returns (uint256) {
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(
    //         0x694AA1769357215DE4FAC081bf1f309aDC325306
    //     );
    //     return priceFeed.version();
    // }
}

// https://youtu.be/umepbfKp5rI?t=18337