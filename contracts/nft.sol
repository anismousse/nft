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
    string baseSvg =
    "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    constructor() ERC721("AkinSerie", "AKS") {}

    function mintNFT(address recipient, string memory data)
        public returns (uint256)
    {
        _tokenIds.increment();

        string memory svg_template = string(
            abi.encodePacked(baseSvg, data, "</text></svg>")
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',data,
                        // We set the title of our NFT as the generated word.
                        '", "description": "On-chain NFTs", "attributes": [{"trait_type": "first nft", "value": "', data,
                        '"}], "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(svg_template)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        uint256 tokenId = _tokenIds.current();
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, finalTokenUri);

        return tokenId;
    }
}
