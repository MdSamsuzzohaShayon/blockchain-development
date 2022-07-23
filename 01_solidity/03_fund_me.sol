// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

// Chainlink Data Feeds can be used in combination to derive denominated price pairs in other currencies. 
// https://docs.chain.link/docs/get-the-latest-price/
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";


// This contract should accept some kind of payment
contract FundMe{
  using SafeMathChainlink for uint256;
  mapping(address => uint256) public addressToAmountFunded; // Use fake account from remix deploy - 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
  address public owner; 
  address[] public funders;

  constructor() public{
    owner = msg.sender;
  }

  // Payble function used to pay for the things
  function fund() public payable{
    uint256 minimumUSD = 50 * 10 ** 18;

    // way 1 - using if else statement 
    // if(msg.value < minimumUSD){
    //   revert? 
    // }

    // way 2 using require statement 
    require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!"); // if they don't send us enough ether we are going to stop here

    // 1 GWEI = 1000000000 WEI
    addressToAmountFunded[msg.sender] += msg.value;

    // What is ETH to USD conversion rate 
    // Data frice feeds - https://data.chain.link
    // We can build our own decentralized network and api calls using chain link
    // Using Data Feeds - https://docs.chain.link/docs/get-the-latest-price/
    // LINK Token Contracts - https://docs.chain.link/docs/link-token-contracts/

    funders.push(msg.sender);
  }



  // Get version using the contract of the interface 
  function getVersion() public view returns(uint256){
    // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e this is a real contract can be found in the link below 
    // Ethereum Data Feeds - https://docs.chain.link/docs/ethereum-addresses/
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); 
    return priceFeed.version();
  }


  // Get price using the contract of the interface 
  function getPrice() public view returns(uint256){
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    ( , int256 answer,,,) = priceFeed.latestRoundData();

    return uint256(answer * 10000000000); // 1532.10485060
  }


  // Get ethereum price in us doller
  function getConversionRate(uint256 ethAmount ) public view returns(uint256){
    // 1 GWEI = 1000000000 WEI - put in function parameter and get the conversation rate of 0.00001532104850600 at the time
    // 1 ETH = 1000000000000000000
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1000000000000000000;
    return ethAmountInUSD;
  } 


  // by modifier we can check that only owner can withdraw the funds 
  modifier onlyOwner{
    require(msg.sender == owner);
    _; // Run rest f the code 
  }


  // Before the function call only Owner modifier will be called
  function withdraw() payable onlyOwner public{
    msg.sender.transfer(address(this).balance);
    for(uint256 fi =0 ; fi< funders.length; fi++){
      address funder = funders[fi];
      addressToAmountFunded[funder] = 0;
    }

    funders = new address[](0);
  }
}