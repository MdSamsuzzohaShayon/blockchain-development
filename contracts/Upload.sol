// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error Upload__PermissionDenied();

// 00:13:40 https://youtu.be/M-KRLlHG_zs?t=822
contract Upload {
    struct Access {
        address user;
        bool access;
    }

    mapping(address => string[]) value; // To store the url
    mapping(address => mapping(address => bool)) ownership;
    mapping(address => Access[]) public accessList; // To give ownership
    mapping(address => mapping(address => bool)) prevData;

    function add(address _user, string calldata url) external {
        value[_user].push(url);
    }

    function allow(address user) external {
        ownership[msg.sender][user] = true;
        if (prevData[msg.sender][user] == true) {
            for (uint i = 0; i < accessList[msg.sender].length; i++) {
                if (accessList[msg.sender][i].user == user) {
                    accessList[msg.sender][i].access = true;
                }
            }
        } else {
            accessList[msg.sender].push(Access(user, true));
            prevData[msg.sender][user] = true;
        }
    }

    function disallow(address user) external {
        ownership[msg.sender][user] = false;
        for (uint i = 0; i < accessList[msg.sender].length; i++) {
            if (accessList[msg.sender][i].user == user) {
                accessList[msg.sender][i].access = false;
            }
        }
    }

    function display(address _user) external view returns(string[] memory){
        if(_user != msg.sender || !ownership[_user][msg.sender]){
            revert Upload__PermissionDenied();
        }
        return value[_user];
    }

    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }
}
