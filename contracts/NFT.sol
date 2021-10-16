// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// ERC 721 standards provided by openZeppelin 
import "@openzeppelin/contracts/utils/Counters.sol";
// simple counter 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// URI storage contract 


contract NFT is ERC721URIStorage {
   using Counters for Counters.Counter;
   Counters.Counter private _tokenIds;
//    Auto increment for tokenId keeping overflow in mind
   address contractAddress;
//    address for marketAddress that will host this 
constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
    contractAddress = marketplaceAddress;
}

// for minting new tokens 
function createToken(string memory tokenURI) public returns (uint){
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();

    _mint(msg.sender,newItemId);
    _setTokenURI(newItemId,tokenURI);
    setApprovalForAll(contractAddress, true);
    return newItemId;
}



}