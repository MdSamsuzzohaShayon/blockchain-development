// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Working on Remix
contract Encoding {
    // Normal state variable of type string
    string public normal = "Normal";

    /*
     * This function combines two strings into one using abi.encodePacked().
     * encodePacked is useful for compact encoding, saving gas when concatenating strings.
     * Example: "Hi mom!" + "Miss Your" -> "Hi mom!Miss Your"
     * Returns: "Hi mom!Miss Your"
     */
    function combineStrings() public pure returns(string memory) {
        return string(abi.encodePacked("Hi mom!", "Miss Your")); // encodePacked returns bytes, so we cast it to string.
    }

    /*
     * This function encodes a number into its binary representation.
     * Example: abi.encode(1) -> bytes equivalent of 1
     * Returns: Encoded bytes of the number 1.
     */
    function encodeNum() public pure returns(bytes memory) {
        bytes memory num = abi.encode(1); // convert to binary
        return num;
    }

    /*
     * Encodes a string into its binary format using abi.encode.
     * Example: abi.encode("some string") -> Encoded bytes of the string
     * Returns: Encoded bytes of the string "some string"
     */
    function encodeString() public pure returns(bytes memory) {
       bytes memory someStr = abi.encode("some string") ;
       return someStr;
    }

    /*
     * Encodes multiple strings using abi.encodePacked to save gas by packing them without padding.
     * Example: "Hello" + "World" -> Encoded bytes for "HelloWorld" (packed)
     * Returns: Packed bytes of "HelloWorld"
     */
    function encodeStringPacked() public pure returns(bytes memory) {
        bytes memory someString = abi.encodePacked("Hello", "World");
        return someString;
    }

    /*
     * Converts a string directly to bytes without encoding (useful for reading raw bytes).
     * Example: bytes("HelloWorld") -> Encoded bytes of the string "HelloWorld"
     * Returns: Raw bytes of "HelloWorld"
     */
    function encodeStringBytes() public pure returns(bytes memory) {
        bytes memory someString = bytes("HelloWorld");
        return someString;
    }

    /*
     * Decodes an encoded string back to its original form using abi.decode.
     * This works on strings encoded with abi.encode.
     * Example: abi.decode(abi.encode("some string"), (string)) -> "some string"
     * Returns: Decoded string from the encoded bytes.
     */
    function decodeString() public pure returns(string memory) {
        string memory someString = abi.decode(encodeString(), (string));
        return  someString;
    }

    /*
     * Encodes multiple values (here, two strings) using abi.encode.
     * Each value is encoded individually, padded, and returned as bytes.
     * Example: abi.encode("some string", "It's bigger") -> Encoded bytes of both strings
     * Returns: Combined encoded bytes of two strings.
     */
    function multiEncode() public pure returns(bytes memory) {
        bytes memory someString = abi.encode("some string", "It's bigger");
        return someString;
    }

    /*
     * Decodes the result of multiEncode into two strings.
     * Example: abi.decode(encodedData, (string, string)) -> ("some string", "It's bigger")
     * Returns: The two decoded strings.
     */
    function multiDecode() public pure returns(string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    /*
     * Encodes multiple values (two strings) using abi.encodePacked to pack the data tightly.
     * This saves gas by removing padding.
     * Example: abi.encodePacked("some string", "it's bigger") -> Packed bytes of both strings
     * Returns: Packed bytes of the two strings.
     */
    function multiEncodePacked() public pure returns(bytes memory) {
        bytes memory someString = abi.encodePacked("some string", "it's bigger");
        return someString;
    }

    /*
     * Decoding packed data directly as a string will not work properly because packed encoding
     * removes padding and length information. This results in incomplete or incorrect data.
     * Example: Trying to decode packed data as (string) will cause issues.
     * Returns: An invalid attempt to decode packed data as a string.
     */
    function multiDecodePacked() public pure returns(string memory) {
        string memory someString = abi.decode(multiEncodePacked(), (string)); // This won't work properly
        return someString;
    }

    /*
     * Converts packed-encoded data to string by casting the bytes directly.
     * Example: string(multiEncodePacked()) -> Works, but can cause data loss or issues with complex data.
     * Returns: Directly cast packed-encoded data as a string.
     */
    function multiStringCastPacked() public pure returns(string memory) {
        string memory someString = string(multiEncodePacked());
        return someString;
    }

    /*
     * In Solidity, we can pass specific fields of a transaction, such as value (ETH sent), in the {} brackets.
     * In the () brackets, we pass function arguments (data) to specify which function to call and with what parameters.
     * If no function call is required and only ETH is being sent, the () can be left empty.
     */
}
