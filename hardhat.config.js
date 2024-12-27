require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.18", // Match your contract's Solidity version
  networks: {
    hardhat: {
      chainId: 31337,  // Default chain ID for the Hardhat network
      gas: 8000000,    // Gas limit (optional)
      blockGasLimit: 10000000,  // Block gas limit (optional)
    },
  },
};
