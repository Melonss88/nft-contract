// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";
// import "@nomiclabs/hardhat-ethers"
// import '@openzeppelin/hardhat-upgrades'
// import dotenv from 'dotenv';
// dotenv.config();

// const PRIVATE_KEY = '49835bf8f31b10300f647bba28d023554e4a06b98dae3267c44bd7ecdf18e520'
// const ETHERSCAN_API_KEY = 'H466KP9R8EC91D9CBFQ5H18F3J3CI952YU'

// const config: HardhatUserConfig = {
//   solidity: "0.8.24",
//   networks: {
//     sepolia: {
//       url: "https://eth-sepolia.g.alchemy.com/v2/vD4A4zO3XV2O6VQjvWa0H1UZa7ZRu1sx", 
//       accounts: [`0x${PRIVATE_KEY}`]  
//     }
//   },
//   etherscan: {
//     apiKey: ETHERSCAN_API_KEY
//   }
// };


// export default config;


import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-ethers";
import dotenv from 'dotenv';
dotenv.config();

const PRIVATE_KEY = process.env.PRIVATE_KEY || '49835bf8f31b10300f647bba28d023554e4a06b98dae3267c44bd7ecdf18e520'; // 使用环境变量
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || 'H466KP9R8EC91D9CBFQ5H18F3J3CI952YU'; // 使用环境变量

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/vD4A4zO3XV2O6VQjvWa0H1UZa7ZRu1sx", 
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  // etherscan: {
  //   apiKey: ETHERSCAN_API_KEY,
  // },
};

export default config;
