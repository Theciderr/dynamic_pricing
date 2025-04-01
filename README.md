# Dynamic Pricing Token

## Overview
This Solidity smart contract implements a token with a dynamic pricing mechanism based on trading volume. The price per token increases as more tokens are purchased and decreases when they are sold. This mechanism creates an adaptive pricing model that adjusts based on demand.

## Features
- **Dynamic Pricing**: Token price changes based on trading volume.
- **Buy & Sell Functions**: Users can buy tokens by sending ETH and sell them to retrieve ETH.
- **Owner Functions**: The contract owner can deposit and withdraw ETH.

## Smart Contract Functions
### Public Functions
- `buyTokens()`: Allows users to buy tokens with ETH at the current price.
- `sellTokens(uint256 amount)`: Allows users to sell their tokens for ETH at the current price.
- `getCurrentPrice() view returns (uint256)`: Returns the dynamically adjusted token price.

### Owner Functions
- `depositETH() payable`: Allows the owner to deposit ETH into the contract.
- `withdrawETH(uint256 amount)`: Allows the owner to withdraw ETH from the contract.

## Pricing Mechanism
- The base price starts at **1 ETH per token**.
- Price increases by `0.01 ETH` per `1000 tokens` traded.
- The price formula is:
  ```solidity
  basePrice + (priceStep * volumeTraded / 1000)
  ```
  where `basePrice = 1 ether` and `priceStep = 0.01 ether`.

## Requirements
- Solidity `^0.8.0`
- Ethereum wallet supporting smart contract interactions

## Usage
1. Deploy the contract on an Ethereum-compatible blockchain.
2. Use `buyTokens()` to purchase tokens.
3. Use `sellTokens(amount)` to sell tokens.
4. The price of tokens will change dynamically based on the volume traded.

## Security Considerations
- Ensure enough ETH is available in the contract for withdrawals.
- Only the owner can withdraw ETH from the contract.

## Contract Address
0x2Fa7FBD666BdEc5fe2fE2B10941c79329A67E895

## License
This project is released under the MIT License.

