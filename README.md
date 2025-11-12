# ZK Proof Demo - Privacy-Preserving Balance Verification

## Smart Contract
ZK Verifier (Arbitrum Sepolia): 0xd8b7f70c959609091494ce7096b6c8397181a22d

---

## Overview
A Zero-Knowledge Proof system that allows users to prove they have a minimum balance without revealing their exact amount. Built using Groth16 zk-SNARKs with Circom circuits and verified on-chain via Arbitrum Stylus.

### Features
- **ZK Proof Generation**: Generate proofs client-side using snarkjs
- **On-Chain Verification**: Verify proofs on Arbitrum using Stylus smart contracts
- **Privacy-Preserving**: Balance amounts remain private
- **Oracle Commitments**: Trusted oracle signs balance data
- **NFT Minting**: Mint NFTs as proof of verification

---

## Technical Stack
- **Circuits**: Circom 2.0 with Groth16
- **Frontend**: Next.js + TypeScript + ethers.js
- **Smart Contracts**: Rust + Arbitrum Stylus
- **Network**: Arbitrum Sepolia Testnet

---

## Demo Video
https://drive.google.com/drive/folders/1mcP8_Ecl2Pf3kcUMK_2Xdr4zFUql-mSs?usp=drive_link

---

