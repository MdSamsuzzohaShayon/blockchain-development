// SPDX-License_Identifier: MIT
pragma solidity 0.8.0;

/**
 * SafeMath was popular library but not any more
 * https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol
 */
contract SafeMathTester {
    uint8 public bigNumber = 255; // uint8 has upper limit of 255

    function add() public {
        /**
         * Overflow and underflow of numbers in Solidity 0.8 throw an error. This can be disabled by using unchecked.
         * https://docs.soliditylang.org/en/latest/control-structures.html#checked-or-unchecked-arithmetic
         * An overflow or underflow is the situation where the resulting value of an arithmetic operation, when executed on an unrestricted integer, falls outside the range of the result type.
         * Prior to Solidity 0.8.0, arithmetic operations would always wrap in case of under- or overflow leading to widespread use of libraries that introduce additional checks.
         * Since Solidity 0.8.0, all arithmetic operations revert on over- and underflow by default, thus making the use of these libraries unnecessary.
         *
         * In solidity 0.6.0: If we add 1 to the upper limit of the number (255) it will be back to the start that is 1
         * In solidity 0.8.0: If we add 1 to the upper limit of the number (255) it will give us an error
         * In solidity 0.8.0: If we add 1 to the upper limit of the number (255) we can make it unchecked that will be like 0.6.0 and be back to the start that is 1
         */
        
        // bigNumber = bigNumber + 1;  // This is checked by default
        unchecked(bigNumber = bigNumber + 1);  // we can make it unchecked 
    }
}
