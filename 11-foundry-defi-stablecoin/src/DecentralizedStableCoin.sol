// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DecentralizedStableCoin
 * @author Md Shayon
 * @notice Implements a decentralized stablecoin pegged to the US dollar.
 * @dev Uses external assets (ETH, BTC) as collateral with algorithmic minting.
 * It focuses on minting and burning stablecoins under the control of the owner (governed by a separate engine).
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    // Error for when an operation tries to burn or mint a zero or negative amount.
    error DecentralizedStableCoin__MustBeMoreThanZero();

    // Error for when the burn amount exceeds the sender's balance.
    error DecentralizedStableCoin__BurnAmountExceedsBalance();

    // Error for when a mint is attempted to the zero address.
    error DecentralizedStableCoin__NotZeroAddress();

    /**
     * @dev Initializes the token with a name and symbol and sets the owner.
     * @notice Token name is "DecentralizedStableCoin" and symbol is "DSC".
     * Ownership is assigned to the provided address.
     *
     * Why are we doing this?
     * - We need a named stablecoin (DSC) for the decentralized system.
     * - Assigning ownership allows only the owner to control critical functions like minting and burning.
     */
    constructor() ERC20("DecentralizedStableCoin", "DSC") Ownable(0x61e3dDcbdF250C5e775f78F91AF9b0A3230422bA) {}

    /**
     * @notice Allows the owner to burn a specific amount of stablecoins.
     * @dev Only the owner can burn tokens to reduce supply.
     * @param _amount The amount of tokens to burn, must be greater than zero.
     *
     * Why are we doing this?
     * - Burning tokens reduces the total supply, which is a crucial mechanism for managing the stablecoin's value relative to the US dollar.
     * - Limiting this function to the owner ensures centralized control over the burn process to maintain stability.
     */
    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);

        // Why are we checking if the amount is more than zero?
        // - We don't want to allow meaningless operations, like burning zero tokens, which could waste gas and lead to unintended consequences.
        if (_amount <= 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }

        // Why are we checking if the balance is sufficient for the burn?
        // - We can't burn more tokens than the user holds. This ensures the contract follows proper accounting rules and prevents errors.
        if (balance < _amount) {
            revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        }

        // Why are we using `super.burn`?
        // - We are calling the burn function from the inherited `ERC20Burnable` contract to execute the actual token burn process.
        super.burn(_amount);
    }

    /**
     * @notice Mints new stablecoins and assigns them to a specific address.
     * @dev Only the owner can mint tokens to control supply.
     * @param _to The address to mint tokens to, must not be the zero address.
     * @param _amount The number of tokens to mint, must be greater than zero.
     *
     * Why are we doing this?
     * - Minting increases the supply of stablecoins in circulation, which is necessary to meet demand or adjust the system's collateral ratio.
     * - Restricting minting to the owner ensures centralized control to prevent inflation or instability.
     */
    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        // Why are we preventing minting to the zero address?
        // - Sending tokens to the zero address would effectively burn them, which is not the intention of minting. This prevents unintended burns and keeps the token system consistent.
        if (_to == address(0)) {
            revert DecentralizedStableCoin__NotZeroAddress();
        }

        // Why are we checking if the amount is more than zero?
        // - Minting zero or negative amounts is nonsensical and would consume unnecessary gas. We only allow meaningful mint operations.
        if (_amount <= 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }

        // Why are we calling `_mint`?
        // - `_mint` is an internal function from the `ERC20` contract, responsible for creating new tokens and assigning them to the recipient. We call it to actually mint the tokens.
        _mint(_to, _amount);
        return true;
    }
}
