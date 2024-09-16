// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721Enumerable} from "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Whitelist} from "src/whitelist.sol";

contract Devs is ERC721Enumerable, Ownable {
    uint256 public constant _price = 0.01 ether;
    uint256 public constant maxTokenIds = 20;

    Whitelist whitelist;

    // Number of tokens reserved for whitelisted members
    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    constructor(
        address whitelistContract
    ) ERC721Enumerable("Devs Waitlist", "DW") {
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.maxWhitelistedAddresses();
    }
}
