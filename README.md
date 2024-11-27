# PME ERC20 Tokens

This repository contains two ERC20 token contracts for the **PCO Meta Earth (PME)** ecosystem. Both tokens are upgradeable and follow OpenZeppelin's best practices for secure and maintainable smart contracts.

## Contracts Overview

### 1. PMETokenV3
**PMETokenV3** is the primary token of the PCO Meta Earth ecosystem. It supports standard ERC20 functionality with additional features like minting, burning, pausing, and ownership management.

#### Key Features:
- **Total Supply**: 35 billion tokens (with 18 decimals).
- **Upgradeable**: Supports upgradeability for future improvements.
- **Pausable**: Contract can be paused by the owner in case of emergencies.
- **Ownership Management**: Only the contract owner can execute privileged functions.

#### Use Cases:
- Buying lands within the ecosystem.
- Paying fees for land NFTs.
- Earning staking rewards.
- Serving as the main transactional token in the ecosystem.

#### Contract Details:
- Implements: `ERC20Upgradeable`, `OwnableUpgradeable`, `PausableUpgradeable`.
- Total supply is fixed at **35 billion** tokens.

---

### 2. PMGToken
**PMGToken** is another token in the ecosystem designed for specific use cases, with a strong focus on role-based minting.

#### Key Features:
- **Maximum Supply**: 35 billion tokens (with 18 decimals).
- **Role-Based Minting**: Only accounts with the `MINTER_ROLE` can mint new tokens.
- **Upgradeable**: Built using OpenZeppelin's upgradeable patterns.
- **Pausable**: Can be paused for security or maintenance purposes.

#### Use Cases:
- Buying lands.
- Earning staking rewards.

#### Contract Details:
- Implements: `ERC20Upgradeable`, `AccessControlUpgradeable`, `PausableUpgradeable`.
- Introduces `MINTER_ROLE` for controlled token minting.

---

## Directory Structure

```plaintext
contracts/
├── PMETokenV3.sol   # Primary token contract for the ecosystem
├── PMGToken.sol     # Secondary token contract with role-based minting
