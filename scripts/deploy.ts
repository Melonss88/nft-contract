// import "hardhat/console.sol";
// import { Web3 } from 'web3'

// async function main() {
//   const web3 = new Web3("http://127.0.0.1:8545/");
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });

// import { ethers } from "hardhat";
import hre from "hardhat";

async function main() {
  // const MyNFT = await ethers.getContractFactory("MyDuck");
  const MyNFT = await hre.ethers.getContractFactory("MyDuck");
  const myNFT = await MyNFT.deploy("0x463FCfA75aD1c920e0327379812db196c9Db7317");
  await myNFT.deployed();
  console.log("MyNFT deployed to:", myNFT.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
