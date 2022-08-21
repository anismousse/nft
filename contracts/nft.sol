// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

// Import this file to use console.log
import "hardhat/console.sol";

contract FirstNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("GameItem", "ITM") {}

    function mintNFT(address recipient, string memory data)
    public returns (uint256){
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, data);
        return tokenId;
    }
}
