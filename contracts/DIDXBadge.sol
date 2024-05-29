// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DIDXBadge is ERC721, Ownable {
    struct Badge {
        uint256 tokenId;
        uint8 starRanking;
        string statusColor;
        string metadataURI;
    }

    mapping(uint256 => Badge) public badges;

    constructor(address initialOwner) ERC721("DIDXBadge", "DBADGE") Ownable(initialOwner) {}

    function mintBadge(address to, uint256 tokenId, string memory metadataURI) public onlyOwner {
        _mint(to, tokenId);
        badges[tokenId] = Badge(tokenId, 0, "green", metadataURI);
    }

    function updateRanking(uint256 tokenId, uint8 newRanking) public onlyOwner {
        badges[tokenId].starRanking = newRanking;
    }

    function updateStatus(uint256 tokenId, string memory newColor) public onlyOwner {
        badges[tokenId].statusColor = newColor;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return badges[tokenId].metadataURI;
    }
}
