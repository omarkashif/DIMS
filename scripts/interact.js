const { ethers } = require("hardhat");
const fs = require("fs");

async function main() {
  // Get the deployer account
  const [deployer] = await ethers.getSigners();
  console.log("Interacting with the DIMS contract with the account:", deployer.address);

  // Read the ABI and address of the deployed contract
  const abi = JSON.parse(fs.readFileSync("./artifacts/contracts/DIMS.sol/DIMS.json")).abi;
  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Replace with your actual contract address

  // Get the contract instance
  const dims = new ethers.Contract(contractAddress, abi, deployer);
  console.log("Contract instance fetched:", dims !== undefined);

  // Example: Register a new user
  const name = "John Doe";
  const passportInfo = "Passport123";
  const healthInfo = "Healthy";
  
  const tx = await dims.registerUser(name, passportInfo, healthInfo);
  console.log("User registration transaction initiated. Hash:", tx.hash);

  // Wait for the transaction to be mined
  await tx.wait();
  console.log("User registration completed!");

  // You can add other function calls here for your contract like `updateUser` or `getHealthInfo`.
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error during interaction:", error);
    process.exit(1);
  });
