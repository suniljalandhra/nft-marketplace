const { getContractAddress } = require("@ethersproject/address");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarket", function () {
  it("Should create and execute market sales", async function () {
    // deploy marketplace
    const Market = await ethers.getContractFactory("NFTMarket")
    const market = await Market.deploy()
    await market.deployed()
    const marketAddress = market.address

    // deploy the nft contract 
    const NFT = await ethers.getContractFactory("NFT")
    const nft = await NFT.deploy(marketAddress)
    await nft.deployed()
    const nftContractAddress = nft.address

    let listingPrice = await market.getListingPrice()
    ListingPrice = listingPrice.toString()

    const auctionPrice = ethers.utils.parseUnits('100','ether')
    // added the tokenURI for a nft
    await nft.createToken("https://www.mytokenlocation.com")
    await nft.createToken("https://www.mytokenlocation2.com")

    // put both the created token for sale 
    await market.createMarketItem(nftContractAddress,1,auctionPrice,{value: listingPrice})
    await market.createMarketItem(nftContractAddress,2,auctionPrice,{value: listingPrice})

    const [_, buyerAddress] = await ethers.getSigners()
  });
});
