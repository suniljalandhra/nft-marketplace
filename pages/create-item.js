import {useState} from "react";
import {ethers} from 'ethers';
import {create as ipfsHttpClient }from 'ipfs-http-client';
import { useRouter } from 'next/router';
import Web3Model from 'web3modal';

// this will work when I will deploy the contract on chain 
// import {
//     nftaddress, nftmarketaddress
// } from '../config'

import NFT from '../artifacts/contracts/NFT.sol/NFT.json'
import NFTMarket from '../artifacts/contracts/NFTMarket.sol/NFTMarket.json'
