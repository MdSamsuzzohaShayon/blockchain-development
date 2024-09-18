// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// https://ethereum.org/en/developers/docs/standards/tokens/erc-20/#methods
// https://eips.ethereum.org/EIPS/eip-20
contract ManualToken {
    mapping(address => uint256) s_balances;

    // OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function name() public pure returns (string memory) {
        return "Manual Token";
    }
    // string public name = "Manual Token";

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    // OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.
    function decimals() public pure returns (uint8) {
        return 18;
    }

    // Returns the account balance of another account with address _owner.
    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public{
        uint256 prevbalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] -= _amount;

        require(balanceOf(msg.sender) + balanceOf(_to) == prevbalances);
    }
}
