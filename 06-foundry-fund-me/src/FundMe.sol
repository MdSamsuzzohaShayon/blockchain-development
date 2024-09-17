// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    /**
     * State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time.
     * For constant variables, the value has to be a constant at compile time and it has to be assigned where the variable is declared.
     * https://docs.soliditylang.org/en/latest/contracts.html#constant
     * Transaction cost: Gas used before without using constant 853,039 -> optimized gas used 790,344 using constant
     * Execution cost: Gas used before without using constant 2407 -> optimized gas used 307 using constant for viewing MIN_USD variable
     */
    uint256 public constant MIN_USD = 5 * 1e18; // 5e18;

    address[] private s_funders;
    mapping(address funder => uint256 amountFunded)
        private s_addressToAmountFunded;

    /**
     * Variables declared as immutable are a bit less restricted than those declared
     * as constant: Immutable variables can be assigned a value at construction time.
     * The value can be changed at any time before deployment and then it becomes permanent.
     * https://docs.soliditylang.org/en/latest/contracts.html#immutable
     * i_owner immutable cost 444, i_owner non immutable cost 2580
     */
    address private immutable i_owner;

    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) > MIN_USD,
            "Didn't send enough ETH!"
        );

        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < s_funders.length; i++) {
            address funder = s_funders[i];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
    }

    function cheapWithdraw() public onlyOwner {
        // s_variable means storage variable 
        uint256 fundersLength = s_funders.length;
        for (uint256 i = 0; i < fundersLength; i++) {
            address funder = s_funders[i];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
    }

    /**
     * https://solidity-by-example.org/fallback/
     *
     * Ether is sent to contract
     *          is msg.data empty?
     *                  /       \
     8                 Yes      No
     *                 /          \
     *  `          receive()    fallback()
     *               /  \
     *             Yes  No
     *             /     \
     *       receive()   fallback()
     *
     */
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    function getAddressToAmountFunded(
        address fundingAddress
    ) external view returns (uint256) {
        return s_addressToAmountFunded[fundingAddress];
    }

    function getFunder(uint256 index) external view returns (address) {
        return s_funders[index];
    }

    /**
     * Starting from Solidity v0.8.4, there is a convenient and gas-efficient way to explain to users why an operation failed through the use of custom errors.
     * https://soliditylang.org/blog/2021/04/21/custom-errors/
     */
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Owner is not sender!");
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    /**
     * A contract can have at most one receive function, declared using receive()
     * external payable { ... } (without the function keyword). This function cannot
     * have arguments, cannot return anything and must have external visibility and
     * payable state mutability. It can be virtual, can override and can have
     * modifiers.The receive function is executed on a call to the contract with
     * empty calldata. This is the function that is executed on plain Ether
     * transfers (e.g. via .send() or .transfer()). If no such function exists,
     * but a payable fallback function exists, the fallback function will be
     * called on a plain Ether transfer. If neither a receive Ether nor a payable
     * fallback function is present, the contract cannot receive Ether through a
     * transaction that does not represent a payable function call and throws an exception.
     * https://docs.soliditylang.org/en/latest/contracts.html#special-functions
     */

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}

// 05:34:00 https://youtu.be/umepbfKp5rI?t=20079
