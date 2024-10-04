// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
 * This contract demonstrates how to call a function using only the data field of a low-level call.
 * To make such a call, we need to encode:
 *      - The function name.
 *      - The parameters we want to pass.
 *      - Convert everything down to the binary level (bytes).
 *
 * Every contract assigns each function a "function selector".
 * The function selector is the first 4 bytes of the function signature, used to uniquely identify the function.
 *
 * Function signature = function name + parameter types (e.g., "transfer(address,uint256)").
 * The function selector = the first 4 bytes of the keccak256 hash of the function signature.
 * This is a low-level detail that allows calling functions via raw data encoding.
 */

// Working on Remix
contract CallAnything {
    // Public state variables to store the address and amount passed to the transfer function
    address public s_someAddress;
    uint256 public s_amount;

    /*
     * Function that updates the contract's state variables with an address and amount.
     * This will be called in low-level ways later.
     * Example: transfer(0x1234..., 100) -> Updates state with (0x1234..., 100)
     */
    function transfer(address someAddress, uint256 amount) public {
        s_someAddress = someAddress;
        s_amount = amount;
    }

    /*
     * This function calculates and returns the function selector for the `transfer` function.
     * The function selector is the first 4 bytes of the keccak256 hash of the function signature.
     * Example: keccak256("transfer(address,uint256)") -> Returns 4-byte selector (e.g., 0xa9059cbb)
     */
    function getSelectorOne() public pure returns (bytes4 selector) {
        // keccak256 generates a 32-byte hash, and bytes4 extracts the first 4 bytes
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
        return selector;
    }

    /*
     * This function prepares the data needed to call the `transfer` function using the selector.
     * It encodes the selector and the arguments (address and amount) into a bytes array.
     * This is what would be sent via low-level calls like `.call()`.
     * Example: abi.encodeWithSelector(selector, 0x1234..., 100) -> Encoded bytes data for calling transfer
     * Returns: Encoded bytes that can be used to call the function.
     */
    function getDataToCallTransfer(address someAddress, uint256 amount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    /*
     * This function makes a low-level call to the `transfer` function using the encoded data.
     * It constructs the call using the selector and passes the address and amount as arguments.
     * Example: address(this).call(encodedData) -> Calls transfer(0x1234..., 100) via low-level call
     * Returns: 
     *    - First 4 bytes of the returned data (function selector).
     *    - Boolean indicating if the call was successful.
     */
    function callTransferFunctionDirectly(address someAddress, uint256 amount) public returns (bytes4, bool) {
        // Perform a low-level call using the encoded data (selector + arguments)
        (bool success, bytes memory returnedData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), someAddress, amount));
        // Return the first 4 bytes of the returned data and whether the call was successful
        return (bytes4(returnedData), success);
    }

    /*
     * This function makes a low-level call using the function signature instead of the selector.
     * `abi.encodeWithSignature` generates the encoded data using the function name and argument types.
     * Example: abi.encodeWithSignature("transfer(address,uint256)", 0x1234..., 100) -> Encoded bytes for calling transfer
     * Returns: 
     *    - First 4 bytes of the returned data (function selector).
     *    - Boolean indicating if the call was successful.
     */
    function callTransferFunctionDirectlySig(address someAddress, uint256 amount) public returns (bytes4, bool) {
        // Perform a low-level call using the function signature
        (bool success, bytes memory returnedData) = address(this).call(abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount));
        // Return the first 4 bytes of the returned data and whether the call was successful
        return (bytes4(returnedData), success);
    }
}
