const dims = await DIMS.deploy();
console.log("DIMS contract deployed to:", dims.address); // Ensure this prints a valid address.

const receipt = await dims.deployTransaction.wait();  // Error occurs here
