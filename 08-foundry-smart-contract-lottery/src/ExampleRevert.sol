// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// https://soliditylang.org/blog/2021/04/21/custom-errors/

contract ExampleRevert{
    error ExampleRevert_Error(); // Much more gas efficient
    function revertWithError() public pure{
        if(false){
            revert ExampleRevert_Error(); // 142 gas
        }
    }

    function revertWithRequire() public pure{
        require(true, "ExampleRevert_Error"); // 161 gas
    }
}
