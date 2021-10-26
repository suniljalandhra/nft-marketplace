import {useState} from "react";
import {ethers} from 'ethers';
import {create as ipfsHttpClient }from 'ipfs-http-client';
import { useRouter } from 'next/router';
import Web3Model from 'web3modal'