# 🔐 ZK Proof + CCIP Demo - Privacy-Preserving Balance Verification

## 📋 Smart Contracts (Arbitrum Sepolia)

| Contract | Address |
|----------|---------|
| **ZK Verifier (Stylus)** | `0x9ee040ab35b9ea2d2f0fdf708cc1752b6cb22582` |
| **CCIP Sender** | `0xC36F3c1Fe8A099e75E9a86441145170C6d5923e5` |
| **CCIP Receiver (Ethereum Sepolia)** | `0x2f5845C15FFd5191703B92b68CbFC07e3cD9505e` |

---

## 🎯 Overview

A Zero-Knowledge Proof system that allows users to prove they have a minimum balance without revealing their exact amount. After successful verification, the system automatically sends a cross-chain message via **Chainlink CCIP** to Ethereum Sepolia.

### ✨ Features

- 🔐 **ZK Proof Generation**: Generate proofs client-side using snarkjs
- ⚡ **On-Chain Verification**: Verify proofs on Arbitrum using Stylus smart contracts (Rust + WASM)
- 🌉 **Cross-Chain Messaging**: Automatic CCIP message to Ethereum Sepolia after successful verification

---

## 🛠️ Technical Stack

- **Circuits**: Circom 2.0 with Groth16 zk-SNARKs
- **Frontend**: Next.js 14 + TypeScript + ethers.js v6
- **Smart Contracts**: Rust + Arbitrum Stylus (WASM)
- **Cross-Chain**: Chainlink CCIP
- **Networks**: 
  - Arbitrum Sepolia (ZK Verification + NFT Mint)
  - Ethereum Sepolia (CCIP Message Receiver)

---

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ and pnpm
- Rust and Cargo (for contract development)
- MetaMask or compatible Web3 wallet
- Some ETH on Arbitrum Sepolia

### 📦 Installation

1. **Install dependencies**
   ```bash
   # Install frontend dependencies
   cd app
   pnpm install
   ```

2. **Configure environment variables**
   ```bash
   # Create .env.local file
   cd app
   cp .env.example .env.local
   ```
   
   Edit `.env.local` and set:
   ```env
   NEXT_PUBLIC_CONTRACT_ADDRESS=0x9ee040ab35b9ea2d2f0fdf708cc1752b6cb22582
   NEXT_PUBLIC_RPC_URL=https://sepolia-rollup.arbitrum.io/rpc
   ORACLE_SECRET=your_oracle_secret_here
   ```

### ▶️ Running the Application

1. **Start the development server**
   ```bash
   cd app
   pnpm dev
   ```

---

## 📝 How to Use

### Step 1: Generate ZK Proof

1. Connect your wallet to Arbitrum Sepolia
2. Click "Generate Proof" button
3. The system will:
   - Check your ETH balance on-chain
   - Verify you meet the minimum requirement (0.1 ETH)
   - Generate a zero-knowledge proof client-side

### Step 2: Mint NFT with Proof

1. After proof generation, click "Mint NFT with Proof"
2. Confirm the transaction in MetaMask
3. The smart contract will:
   - ✅ Verify the ZK proof on-chain
   - ✅ Validate timestamp (proof expires in 5 minutes)
   - ✅ Check nullifier (prevents replay attacks)
   - ✅ Send CCIP message to Ethereum Sepolia
   - ✅ Mint NFT to your address

### Step 3: Check Results

- Check the CCIP message on [CCIP Explorer](https://ccip.chain.link/)
- Verify on Arbitrum Sepolia: [Arbiscan](https://sepolia.arbiscan.io/address/0x9ee040ab35b9ea2d2f0fdf708cc1752b6cb22582)

---

### CCIP Flow

```
┌─────────────────┐
│ ZK Proof Verify │
│  (Arbitrum)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  CCIP Sender    │ ─────► Message: user, nullifier, timestamp
│  (Arbitrum)     │
└────────┬────────┘
         │
         ▼ (Cross-chain)
┌─────────────────┐
│ CCIP Receiver   │
│ (Eth Sepolia)   │
└─────────────────┘
```

### Security Features

- ✅ **Nullifier tracking** - Prevents proof reuse
- ✅ **Timestamp validation** - 5 minute expiry window
- ✅ **Replay protection** - One-time use proofs
- ✅ **Min balance verification** - Contract enforces minimum
- ✅ **Oracle commitment** - Cryptographic signature validation

---

## 🏗️ Smart Contract Development

### Building the Contract

```bash
cd contracts
cargo build --release --target wasm32-unknown-unknown
```

### Checking Contract (Stylus)

```bash
cargo stylus check --endpoint=https://sepolia-rollup.arbitrum.io/rpc
```