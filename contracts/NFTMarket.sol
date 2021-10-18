// contracts/NFTMarket.sol
// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFTMarket is ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    // to keep the track of item sold 
    Counters.Counter private _itemsSold;

    address payable owner;
    uint256 listingPrice = 0.025 ether;

    constructor() {
        owner = payable(msg.sender);
    }

    struct MarketItem {
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }
    
    mapping(uint => MarketItem) private idToMarketItem;

    // this event will be emited whenever an item is created in market
    event MarketItemCreated (
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    // return the listing price of the contract 
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    // this fucntion will place an item for sale on the marketplace
    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    )public payable nonReentrant {
        require(price > 0, "price must at least 1 wei");
        require(msg.value == listingPrice,"Amount transfered is not equal to listing price");

        _itemIds.increment();
        uint256 itemId = _itemIds.current();

        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        // this will send all params to front end part  
        emit MarketItemCreated(itemId, nftContract, tokenId, msg.sender, address(0), price, false);
    }

}