// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Whitelist {
    uint8 public MaxAllowedWhiteList;
    uint8 public numAddressesListed; //storing listed addresses

    error NotWhiteListedAddres();
    error WhiteListFilled();

    mapping(address => bool) public WhiteListedAddresses; //maps to check if address has been added or not

    constructor(uint8 _MaxAllowedWhiteList) {
        MaxAllowedWhiteList = _MaxAllowedWhiteList;
    }

    function addWhitelistAddress() public {
        if (!WhiteListedAddresses[msg.sender]) {
            revert NotWhiteListedAddres();
        }

        if (numAddressesListed >= MaxAllowedWhiteList) {
            revert WhiteListFilled();
        }
        WhiteListedAddresses[msg.sender] = true; //confirming the sneder from bool
        numAddressesListed++;
    }
}
