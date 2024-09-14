// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * Solidity Tutorial - https://youtu.be/jcgfQEbptdo
 * This contract demonstrates various types of variables, including 
 * string, bytes, uint, int, bool, address, and more advanced features 
 * like structs, arrays, mappings, loops, and conditionals.
 */

contract MyContract {

    /*
     * State Variables: These are permanently stored on the blockchain.
     * Examples of various Solidity variable types are demonstrated below.
     */

    // String: A dynamic-sized string of characters
    string public contractName = "My Solidity Contract"; 

    // Bytes: Fixed-size byte arrays, useful for storing raw binary data
    bytes32 public dataHash = keccak256(abi.encodePacked(contractName)); 

    // Unsigned Integer (uint): Non-negative integer. 'uint256' is common, but smaller sizes (like uint8, uint16) can be used.
    uint256 public totalSupply = 1000;

    // Signed Integer (int): Can hold negative and positive values.
    int256 public balance = -100;

    // Boolean: Stores true or false values.
    bool public isActive = true;

    // Address: Holds an Ethereum address (typically of users or contracts).
    address public s_owner; 

    /*
     * Mapping: A type of key-value store in Solidity. 
     * Useful for associating values with keys (e.g., IDs to names or addresses to balances).
     */
    
    // Mapping from an ID (uint) to a name (string).
    mapping(uint256 => string) public names;

    // Mapping from an ID (uint) to a Book struct.
    mapping(uint256 => Book) public books;

    // Nested Mapping: Maps an address to another mapping (address => (ID => Book)).
    mapping(address => mapping(uint256 => Book)) public myBooks;

    /*
     * Struct: Structs allow you to define custom data types.
     * In this example, we define a 'Book' struct with two properties: title and author.
     */
    struct Book {
        string title;
        string author;
    }

    /*
     * Constructor: The constructor is a special function that runs when the contract is deployed.
     * It sets the initial state of the contract, in this case, assigning the owner and initializing the `names` mapping.
     */
    constructor() {
        // msg.sender is a global variable in Solidity that stores the address of the function caller.
        // Here, it sets the contract owner to the account that deployed the contract.
        s_owner = msg.sender; 
        
        // Initialize some values in the `names` mapping
        names[1] = "Hulk";
        names[2] = "Thor";
        names[3] = "Ironman";
    }

    /*
     * Function to add a new book to the `books` mapping.
     * This is a state-changing function (not view or pure), meaning it alters the contract's storage.
     */
    function addBook(uint256 id, string memory title, string memory author) public {
        // This stores the book details in the `books` mapping using the provided `id`.
        books[id] = Book(title, author);
    }

    /*
     * Function to add a book to the `myBooks` nested mapping.
     * Each user (msg.sender) can add their own books using this function.
     * Nested mappings allow us to organize data in two layers: user address and book ID.
     */
    function addMyBook(uint256 id, string memory title, string memory author) public {
        // Here, the caller (msg.sender) adds a book to their own collection in `myBooks`.
        myBooks[msg.sender][id] = Book(title, author);
    }

    /*
     * Function to check if the caller is the owner of the contract.
     * Demonstrates the use of conditionals (if statements) and returns a boolean value.
     */
    function isOwner() public view returns (bool) {
        // Check if the current function caller (msg.sender) is the contract owner.
        return msg.sender == s_owner;
    }

    /*
     * Local Variables:
     * Local variables exist only within the scope of a function and are not stored on the blockchain.
     * In this example, we define a local variable `localVal` and return it. 
     */
    function getValue() public pure returns (uint256) {
        // Local variable example
        uint256 localVal = 1; 
        return localVal; // Returns the local value (does not affect contract state).
    }

    /*
     * Loops:
     * Solidity supports loops (for, while, do-while) just like other languages.
     * Below, we demonstrate a `for` loop to iterate over the `names` mapping.
     * Note: Loops are generally discouraged in Solidity if they could run indefinitely or too many iterations, due to gas costs.
     */
    function listBooks(uint256 limit) public view returns (string[] memory) {
        // Create an array to store book titles with a size equal to the limit.
        string[] memory bookTitles = new string[](limit);

        // A `for` loop to iterate over the first `limit` items in the `names` mapping.
        for (uint256 i = 1; i <= limit; i++) {
            bookTitles[i - 1] = names[i]; // Add the book title to the array
        }

        return bookTitles; // Return the array of book titles
    }

    /*
     * Conditionals with Loop:
     * This function uses a conditional inside a loop to check if a specific book title exists.
     * It demonstrates the use of `if` statements and loops together.
     */
    function bookExists(string memory title) public view returns (bool) {
        uint256 limit = 3; // Hardcoded limit for demonstration purposes

        // Loop through the first 3 entries in the `names` mapping.
        for (uint256 i = 1; i <= limit; i++) {
            // Use `keccak256` to compare strings (Solidity doesn't have direct string comparison).
            if (keccak256(bytes(names[i])) == keccak256(bytes(title))) {
                return true; // If a match is found, return true.
            }
        }

        return false; // If no match is found, return false.
    }
}
