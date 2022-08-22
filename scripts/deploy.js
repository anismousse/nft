// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
require('dotenv').config();

const hre = require("hardhat");
const {PUBLIC_ADDRESS} = process.env; //environment variables are being loaded here.

async function main() {
  const Nft = await hre.ethers.getContractFactory("FirstNFT");
  const nft = await Nft.deploy();
  //since we are testing, you should mention your own Eth wallet address
  const myAddress=PUBLIC_ADDRESS;//"ETHEREUM-ADDRESS-WHERE-YOU-WANT-TO-MINT";
  console.log("first nft deployed to:", nft.address);
  
  let txn = await nft.mintNFT(myAddress, 'virgo');
  await txn.wait();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
