// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
    // To store data in blockchain
    mapping (string => address) public domains;
    constructor() {
        console.log("This is Domains contract!");
    }

    function register(string calldata name) public {
        domains[name] = msg.sender;
        console.log("%s has registered domain: %s", msg.sender, name);
    }

    function getAddress(string calldata name) public view returns(address) {
        return domains[name];
    }
}
