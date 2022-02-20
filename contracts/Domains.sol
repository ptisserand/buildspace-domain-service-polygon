// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { StringUtils } from "./libraries/StringUtils.sol";

import "hardhat/console.sol";

contract Domains {
    string public tld;

    // To store data in blockchain
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor(string memory _tld) payable {
        tld = _tld;
        console.log("Name service deployed: %s", tld);
    }

    // to get price of domain according to name
    function price(string calldata _name) public pure returns (uint256) {
        uint256 len = StringUtils.strlen(_name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
        } else if (len == 4) {
            return 3 * 10**17; // To charge smaller amounts, reduce the decimals. This is 0.3
        } else {
            return 1 * 10**17;
        }
    }

    function register(string calldata name) public payable {
        require(domains[name] == address(0), "Domain is not free");
        uint _price = price(name);
        require(msg.value >= _price, "Not enough Matic pair");
        domains[name] = msg.sender;
        console.log("%s has registered domain: %s", msg.sender, name);
    }

    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require(
            domains[name] == msg.sender,
            "Only domain owner can set record"
        );
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
