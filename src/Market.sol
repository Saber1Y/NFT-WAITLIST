// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Whitelist} from "src/Whitelist.sol";

abstract contract Market is ERC721, Ownable {
    error ExceededMaxSupply();
    error AlreadyOwned();
    error NotEnoughEther();
    error FailedToSendEther();

    uint256 public constant _price = 0.01 ether;
    uint256 public constant maxTokenIds = 20;

    Whitelist whitelist;

    // Number of tokens reserved for whitelisted members
    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    constructor(address whitelistContract) ERC721("Devs Waitlist", "DW") {
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.MaxAllowedWhiteList();
    }

    // function mint() public payable {
    //     // Make sure there is enough room for whitelist reservations and public minting
    //     if (
    //         totalSupply() + reservedTokens - reservedTokensClaimed >=
    //         maxTokenIds
    //     ) {
    //         revert ExceededMaxSupply();
    //     }

    //     // If user is whitelisted and has not sent enough ETH, enforce whitelist rules
    //     if (whitelist.whitelistedAddresses(msg.sender) && msg.value < _price) {
    //         // Ensure that the whitelisted user does not already own an NFT
    //         if (balanceOf(msg.sender) > 0) {
    //             revert AlreadyOwned();
    //         }
    //         reservedTokensClaimed += 1;
    //     } else {
    //         // For non-whitelisted users, make sure they have sent enough ETH
    //         if (msg.value < _price) {
    //             revert NotEnoughEther();
    //         }
    //     }

    //     uint256 tokenId = totalSupply();
    //     _safeMint(msg.sender, tokenId);
    // }

    // /**
    //  * @dev Withdraw function sends all the ether in the contract to the owner.
    //  */
    // function withdraw() public onlyOwner {
    //     address _owner = owner();
    //     uint256 amount = address(this).balance;

    //     (bool sent, ) = _owner.call{value: amount}("");
    //     if (!sent) {
    //         revert FailedToSendEther();
    //     }
    // }
}
