const { ethers } = require("hardhat");

const hre = require("hardhat");

async function main() {
    const DIMS = await hre.ethers.getContractFactory("DIMS");
    const dims = await DIMS.deploy(); // Deploy the contract
    console.log(`DIMS contract deployed at address: ${dims.target}`);
}

// Run the main function
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});