// scripts/interact.js
async function main() {
    const [owner, manufacturer, supplier, retailer] = await ethers.getSigners();
    const SupplyChain = await ethers.getContractFactory("SupplyChain");
    const supplyChain = SupplyChain.attach("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4");

    // Add participants
    let tx = await supplyChain.connect(owner).addParticipant(manufacturer.address, 1); // Manufacturer role
    await tx.wait();
    console.log("Added manufacturer:", manufacturer.address);

    tx = await supplyChain.connect(owner).addParticipant(supplier.address, 2); // Supplier role
    await tx.wait();
    console.log("Added supplier:", supplier.address);

    tx = await supplyChain.connect(owner).addParticipant(retailer.address, 3); // Retailer role
    await tx.wait();
    console.log("Added retailer:", retailer.address);

    // Manufacturer creates a product
    tx = await supplyChain.connect(manufacturer).createProduct("Product A");
    await tx.wait();
    console.log("Product A created by manufacturer");

    // Transfer product to supplier
    tx = await supplyChain.connect(manufacturer).transferProduct(0, supplier.address);
    await tx.wait();
    console.log("Product A transferred to supplier");

    // Supplier transfers product to retailer
    tx = await supplyChain.connect(supplier).transferProduct(0, retailer.address);
    await tx.wait();
    console.log("Product A transferred to retailer");

    // Retailer marks the product as delivered
    tx = await supplyChain.connect(retailer).deliverProduct(0);
    await tx.wait();
    console.log("Product A marked as delivered by retailer");

    // Fetch product details
    const product = await supplyChain.getProduct(0);
    console.log("Product A details:", product);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
