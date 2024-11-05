// SPDX-License-Identifier: MIT
/**
 * Pragma statements
 *     Import statements
 *     Events
 *     Errors
 *     Interfaces
 *     Libraries
 *     Contracts
 *     Inside each contract, library or interface, use the following order:
 *     Type declarations
 *     State variables
 *     Events
 *     Errors
 *     Modifiers
 *     Functions
 */
pragma solidity ^0.8.19;

import {DecentralizedStableCoin} from "src/DecentralizedStableCoin.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// /lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol

// System is designed to be as minimal as possible
// Have the tokens maintain a 1 token == $1 peg.
// This stable coin has the properties:
// - Exogenous collateral
// - Dollar pegged
// - Algoritmically stable
// It is similar to DAI if DAI had no governance, no fees, and was only backed by WETH and WBTC
// Our DSC system should always be "overcollateralized". At no point, should the value of all collateral <= the $ backed value of all the DSC
// This contract is the code of the DSC System. It handles all the logic for minting and redeeming DSC.
// As well as depositing & withdrawing collateral.
// This contract is VERy loosely based on the MakerDAO DSS (DAI ) system.

contract DSCEngine is ReentrancyGuard {

    uint256 private constant ADDITIONAL_FEED_PRECISION = 1e10;
    uint256 
    mapping(address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address token => uint256 amount)) private s_collateralDeposited;
    mapping(address user => uint256 amountDscMinted)  private s_DSCMinted;
    address[] private s_collateralTokens;


    DecentralizedStableCoin private immutable i_dsc;

    // Events
    event CollateralDeposited(address indexed user, address indexed token, uint256 amount);

    // Errors
    error DSCEngine__NeedsMoreThanZero();
    error DSCEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
    error DSCEngine__NotAllowedToken();
    error DSCEngine__TransferFailed();

    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DSCEngine__NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if (s_priceFeeds[token] == address(0)) {
            revert DSCEngine__NotAllowedToken();
        }
        _;
    }

    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddress, address dscAddress) {
        if (tokenAddresses.length != priceFeedAddress.length) {
            revert DSCEngine__TokenAddressesAndPriceFeedAddressesMustBeSameLength();
        }

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddress[i]; // If they have a price feed they are allowed, If they do not have a price feed they are not allowed
        }
        i_dsc = DecentralizedStableCoin(dscAddress);
    }

    function depositCollateralAndMintDsc() external {}

    /**
     * @notice follows CEI pattern
     * @param tokenCollateralAddress The address of the token to deposit as collateral
     * @param amountCollateral The amount of collateral to deposit
     */
    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral)
        external
        moreThanZero(amountCollateral)
        isAllowedToken(tokenCollateralAddress)
        nonReentrant
    {
        s_collateralDeposited[msg.sender][tokenCollateralAddress] += amountCollateral;
        emit CollateralDeposited(msg.sender, tokenCollateralAddress, amountCollateral);
        bool success = IERC20(tokenCollateralAddress).transferFrom(msg.sender, address(this), amountCollateral);
        if(!success){
            revert DSCEngine__TransferFailed();
        }
    }

    function redeemCollateralForDsc() external {}

    function redeemCollateral() external {}

    // $200 ETH -> $20 DSC
    /**
     * @notice follows CEI
     * @param amountDscToMint The amount of decentralized stablecoin to mint
     * @notice they must have more collateral value than the minimum threshold
     */
    function mintDsc(uint256 amountDscToMint) external moreThanZero(amountDscToMint) nonReentrant{
        s_DSCMinted[msg.sender] += amountDscToMint;
        // If they minted too much ($150 DSC. $100 ETH)
        _revertIfHealthFactorIsBroken(msg.sender);
    }

    function burnDsc() external {}

    function liquidate() external {}

    function getHelthFactor() external view {}

    function _getAccountInformation(address user)private view returns (uint256 totalDscMinted, uint256 collateralValueInUsd){
        totalDscMinted = s_DSCMinted[user];
        collateralValueInUsd = getAccountCollateralValue(user);
    }

    /**
     * @return how close to liquidation a user is
     * @param user gets below 1, then they can get liquidated
     */
    function _helthFactor(address user) private view returns(uint256){
        // Totoal DSC minted
        // Total collateral value
        (uint256 totalDscMinted, uint256 collatearlValueUsed) = _getAccountInformation(user);
    }
    function _revertIfHealthFactorIsBroken(address user) internal view{
        // 1. Check helth factor (do they have enough collateral?)
        // 2. Revert if they do not
    }

    function getAccountCollateralValue(address user) public view returns(uint256){
        // Loop through each collateral token, get the amount they have deposited, and map it to the price to get the USD value.
    }

    function getUsdValue(address token, uint256 amount) public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(s_priceFeeds[token]);
        (, int256 price,,,) = priceFeed.latestRoundData();
        return ((uint256(price) * ADDITIONAL_FEED_PRECISION) * amount) / 1e18; // 0x694AA1769357215DE4FAC081bf1f309aDC325306
    }

}

// Make this code more professional, Explain everything, create a proper documentation for explaining the code, use docstring when necessary or use single line comments to explain.
// Try to answer the question "why". Explain Why we are doing specific task in this contract
