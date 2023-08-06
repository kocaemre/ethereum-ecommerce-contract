# E-commerce Smart Contract

This is an Ethereum smart contract for an e-commerce platform. It allows sellers to create and sell products, while buyers can purchase these products using Ether (in wei).

## Disclaimer

**Please note that this code is a work in progress and may have security vulnerabilities. Use it at your own risk and do not deploy it to the Ethereum mainnet without thorough security audits.**

## Requirements

To run this smart contract, you will need:

- An Ethereum development environment (e.g., Remix, Truffle, Hardhat).
- Access to an Ethereum test network or a local development network.

## Functionality

The smart contract provides the following functionality:

- Sellers can add new products with a name, price (in wei), and initial stock.
- Buyers can purchase products using Ether (in wei), and the seller receives the payment minus a commission for the platform manager.
- Sellers can be granted permissions to add products by the contract owner.
- Buyers can deposit Ether (in wei) into their balance in the contract.
- Buyers can withdraw Ether (in wei) from their balance in the contract.

## Deploying the Smart Contract

1. Make sure you have the necessary development environment set up with an Ethereum wallet.
2. Compile and deploy the smart contract to your chosen Ethereum test network or local development network.

## Usage

1. Deploy the smart contract to an Ethereum test network or local development network.
2. Ensure the contract owner is set to the address of your Ethereum wallet.
3. The owner can grant seller permissions to other addresses using the `seller_permission` function.
4. Sellers can create new products using the `createProduct` function.
5. Buyers can deposit Ether (in wei) into the contract using the `deposit` function.
6. Buyers can purchase products using the `buyProduct` function.
7. Buyers can withdraw their balance (in wei) from the contract using the `withdraw` function.

## Disclaimer

**Please note that this smart contract is for educational and testing purposes only. It may contain security vulnerabilities or bugs. Use it with caution and never deploy it to the Ethereum mainnet without thorough security audits.**



