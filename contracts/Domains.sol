// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
    // To store data in blockchain
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor() {
        console.log("This is Domains contract!");
    }

    function register(string calldata name) public {
        require(domains[name] == address(0), "Domain is not free");
        domains[name] = msg.sender;
        console.log("%s has registered domain: %s", msg.sender, name);
    }

    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require(domains[name] == msg.sender, "Only domain owner can set record");
        records[name] = record;
    }

    function getRecord(string calldata name)
        public
        view
        returns (string memory)
    {
        return records[name];
    }
}
