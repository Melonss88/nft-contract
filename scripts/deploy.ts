import "hardhat/console.sol";
import { Web3 } from 'web3'

async function main() {
  const web3 = new Web3("http://127.0.0.1:8545/");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
