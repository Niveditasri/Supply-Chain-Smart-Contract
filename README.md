# SupplyChain Smart Contract

The `SupplyChain` smart contract is designed to manage a basic supply chain process on the Ethereum blockchain. It allows participants (manufacturers, suppliers, and retailers) to interact with products, transfer ownership, and mark products as delivered.

## Contract Overview

The smart contract includes the following main components:

- **Roles**: Participants can have roles of `Manufacturer`, `Supplier`, or `Retailer`.
- **Product States**: Products can be in states of `Created`, `InTransit`, or `Delivered`.
- **Structs**: `Participant` struct to store participant details and `Product` struct to store product details.
- **Mappings**: `participants` mapping to store participants and `products` mapping to store products by ID.

## Contract Functions

- **addParticipant**: Allows the contract owner to add participants with specified roles.
- **createProduct**: Allows manufacturers to create products.
- **transferProduct**: Allows participants to transfer ownership of products.
- **deliverProduct**: Allows retailers to mark products as delivered.
- **getProduct**: Retrieves details of a product by its ID.

## Interaction Scripts

### `deploy.js`

The `deploy.js` script deploys the `SupplyChain` smart contract onto the Ethereum blockchain.

- Retrieves the deployer's account and logs its address and balance.
- Deploys the `SupplyChain` contract with a specified gas limit.
- Outputs the address where the `SupplyChain` contract is deployed.

### `interact.js`

The `interact.js` script interacts with a deployed instance of the `SupplyChain` contract.

- Adds participants (`manufacturer`, `supplier`, `retailer`) to the supply chain.
- Manufacturer creates a product.
- Transfers the product from manufacturer to supplier, and then from supplier to retailer.
- Retailer marks the product as delivered.
- Fetches and logs the details of the product.

## Prerequisites

- Node.js installed
- Ethereum provider (like Ganache, Infura, or a local Ethereum node)
- ethers.js library installed (`npm install --save ethers`)

## Usage

1. **Deploying the Contract**:
   - Update the `deploy.js` script with your Ethereum provider and run `node scripts/deploy.js`.

2. **Interacting with the Contract**:
   - Update the `interact.js` script with the deployed contract address and your Ethereum provider.
   - Run `node scripts/interact.js` to execute the interactions.
---

This README provides an overview of the `SupplyChain` smart contract, its functionalities, interaction scripts (`deploy.js` and `interact.js`), prerequisites, usage instructions, and notes for deployment and interaction on the Ethereum blockchain. Adjust the content as necessary to fit your project specifics and additional details you may want to include.
