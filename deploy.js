
// scripts/deploy.js
async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Log the balance of the deployer
    const balance = await deployer.getBalance();
    console.log("Account balance:", balance.toString());

    const SupplyChain = await ethers.getContractFactory("SupplyChain");

    // Deploy the contract with a specified gas limit
    const supplyChain = await SupplyChain.deploy({
        gasLimit: 6000000  // Set a higher gas limit
    });

    await supplyChain.deployed();
    console.log("SupplyChain contract deployed to:", supplyChain.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
