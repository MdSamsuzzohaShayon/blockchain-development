// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 00:13:40 https://youtu.be/M-KRLlHG_zs?t=822

error Upload__PermissionDenied(); // Custom error for permission denial, saving gas over using revert strings.

/**
 * @title Upload Contract
 * @dev This contract allows users to upload and manage URLs (files) and control access to them.
 * Users can grant or revoke access to other users to view their URLs.
 */
contract Upload {

    /**
     * @dev Struct to represent user access permissions.
     * @param user The address of the user being granted or revoked access.
     * @param access Boolean indicating whether access is granted (true) or revoked (false).
     */
    struct Access {
        address user;  // Address of the user being granted/revoked access.
        bool access;   // Access status: true for granted, false for revoked.
    }

    /**
     * Mapping to store uploaded URLs for each user.
     * Address of the user (owner of the URLs).
     * Array of URLs (represented as strings) owned by the user.
     */
    mapping(address => string[]) value;  // Stores the URLs uploaded by each user.

    /**
     * Mapping to track access permissions between users.
     * The first key is the owner (msg.sender), the second key is the user being granted access.
     * Boolean indicating if access is granted (true) or denied (false).
     */
    mapping(address => mapping(address => bool)) ownership;

    /**
     * Public mapping to store the list of users with access to a specific user's URLs.
     * Address of the owner.
     * Array of Access structs representing users and their access status.
     */
    mapping(address => Access[]) public accessList;

    /**
     * Mapping to track whether a user has previously been given access.
     * This helps avoid duplication when adding or removing users.
     * First key is the owner, second key is the user.
     * Boolean indicating if the user has previously been added to the access list.
     */
    mapping(address => mapping(address => bool)) prevData;

    /**
     * @notice Adds a URL to the list of URLs for a specific user.
     * @param _user The address of the user for whom the URL is being added.
     * @param url The URL (string) to be added to the user's list.
     */
    function add(address _user, string calldata url) external {
        value[_user].push(url);  // Appends the provided URL to the user's list of URLs.
    }

    /**
     * @notice Grants access to another user to view the message sender's URLs.
     * @param user The address of the user to be granted access.
     * @dev If the user was previously given access, it updates the access status.
     * Otherwise, it adds the user to the access list.
     */
    function allow(address user) external {
        ownership[msg.sender][user] = true;  // Grants ownership permission.

        if (prevData[msg.sender][user] == true) {
            // If the user already exists in the access list, just update their access to true.
            for (uint i = 0; i < accessList[msg.sender].length; i++) {
                if (accessList[msg.sender][i].user == user) {
                    accessList[msg.sender][i].access = true;
                }
            }
        } else {
            // If the user hasn't been added before, push them to the access list.
            accessList[msg.sender].push(Access(user, true));
            prevData[msg.sender][user] = true;
        }
    }

    /**
     * @notice Revokes access from a user who was previously allowed to view the sender's URLs.
     * @param user The address of the user to have their access revoked.
     * @dev The function sets the ownership permission to false and updates the access list.
     */
    function disallow(address user) external {
        ownership[msg.sender][user] = false;  // Revokes ownership permission.

        // Loop through the access list and set the access to false for the specified user.
        for (uint i = 0; i < accessList[msg.sender].length; i++) {
            if (accessList[msg.sender][i].user == user) {
                accessList[msg.sender][i].access = false;
            }
        }
    }

    /**
     * @notice Displays the list of URLs for the specified user, if the caller has permission.
     * @param _user The address of the user whose URLs are being requested.
     * @return An array of URLs (strings) uploaded by the specified user.
     * @dev The function checks if the caller has the right permissions to view the URLs.
     * If the caller doesn't have permission, it throws a custom error.
     */
    function display(address _user) external view returns (string[] memory) {
        // Revert if the caller does not own the URLs or has no access permission.
        if (_user != msg.sender || !ownership[_user][msg.sender]) {
            revert Upload__PermissionDenied();
        }

        return value[_user];  // Returns the list of URLs for the user.
    }

    /**
     * @notice Retrieves the list of users who have access to the caller's URLs.
     * @return An array of Access structs containing user addresses and their access statuses.
     * @dev This function allows the caller to view their access control list.
     */
    function shareAccess() public view returns (Access[] memory) {
        return accessList[msg.sender];  // Returns the access list for the caller.
    }
}
