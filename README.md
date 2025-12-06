# TJCoin (TJC)

![Stacks](https://img.shields.io/badge/Stacks-Blockchain-5546ff)
![Clarity](https://img.shields.io/badge/Clarity-Smart%20Contract-blue)
![License](https://img.shields.io/badge/license-MIT-green)

A SIP-010 compliant fungible token built on the Stacks blockchain using Clarity smart contracts.

## Overview

TJCoin (TJC) is a fungible token implementation that follows the SIP-010 standard for fungible tokens on Stacks. The token has a fixed maximum supply of 1 trillion tokens (1,000,000,000,000) with 6 decimal places.

## Features

- ✅ **SIP-010 Compliant**: Fully implements the SIP-010 fungible token standard
- 🔒 **Fixed Supply**: Maximum supply of 1 trillion tokens
- 💰 **Transfer**: Send tokens between accounts
- 🔥 **Burn**: Token holders can burn their tokens
- 🏦 **Mint**: Contract owner can mint additional tokens (up to max supply)
- 📝 **Metadata**: Includes token name, symbol, decimals, and optional URI
- 🛡️ **Access Control**: Owner-only functions for administrative operations

## Token Details

- **Name**: TJCoin
- **Symbol**: TJC
- **Decimals**: 6
- **Max Supply**: 1,000,000,000,000 (1 trillion)
- **Initial Supply**: 1,000,000,000,000 (minted to contract owner on deployment)

## Smart Contract Functions

### SIP-010 Standard Functions

#### `transfer`
```clarity
(transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
```
Transfers tokens from sender to recipient. Must be called by the token owner.

#### `get-name`
```clarity
(get-name)
```
Returns the token name: "TJCoin"

#### `get-symbol`
```clarity
(get-symbol)
```
Returns the token symbol: "TJC"

#### `get-decimals`
```clarity
(get-decimals)
```
Returns the number of decimals: 6

#### `get-balance`
```clarity
(get-balance (account principal))
```
Returns the token balance of the specified account.

#### `get-total-supply`
```clarity
(get-total-supply)
```
Returns the current total supply of tokens in circulation.

#### `get-token-uri`
```clarity
(get-token-uri)
```
Returns the optional token URI for metadata.

### Additional Functions

#### `mint`
```clarity
(mint (amount uint) (recipient principal))
```
Mints new tokens to the recipient. **Only callable by contract owner.**

#### `burn`
```clarity
(burn (amount uint) (sender principal))
```
Burns tokens from the sender's balance. Must be called by the token owner.

#### `set-token-uri`
```clarity
(set-token-uri (uri (string-utf8 256)))
```
Sets the token URI for metadata. **Only callable by contract owner.**

## Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| u100 | `err-owner-only` | Function can only be called by contract owner |
| u101 | `err-not-token-owner` | Caller is not the token owner |
| u102 | `err-insufficient-balance` | Insufficient token balance |
| u103 | `err-invalid-amount` | Invalid amount (must be > 0) |

## Development

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) (v3.10.0 or later)
- Node.js (for TypeScript tests)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/tjcoin.git
cd tjcoin
```

2. Install dependencies:
```bash
npm install
```

### Testing

Run the contract syntax check:
```bash
clarinet check
```

Run TypeScript tests:
```bash
npm test
```

### Local Development

Start a local Clarinet console:
```bash
clarinet console
```

Start a local devnet:
```bash
clarinet devnet start
```

## Deployment

### Testnet Deployment

1. Configure your testnet account in `settings/Testnet.toml`
2. Deploy using Clarinet:
```bash
clarinet deployments generate --testnet
clarinet deployments apply --testnet
```

### Mainnet Deployment

1. Configure your mainnet account in `settings/Mainnet.toml`
2. Deploy using Clarinet:
```bash
clarinet deployments generate --mainnet
clarinet deployments apply --mainnet
```

## Usage Examples

### Transfer Tokens

```clarity
(contract-call? .tjcoin transfer u1000000 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM none)
```

### Check Balance

```clarity
(contract-call? .tjcoin get-balance 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

### Mint Tokens (Owner Only)

```clarity
(contract-call? .tjcoin mint u1000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

### Burn Tokens

```clarity
(contract-call? .tjcoin burn u500000 tx-sender)
```

## Security Considerations

- The contract owner has special privileges (minting, setting URI)
- The contract owner is set at deployment and cannot be changed
- All token transfers require authorization from the token owner
- Tokens can only be burned by their owner
- All amounts must be greater than 0
- The maximum supply is enforced by the fungible token definition

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For questions and support, please open an issue in the GitHub repository.

## Acknowledgments

- Built with [Clarinet](https://github.com/hirosystems/clarinet)
- Follows [SIP-010](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md) fungible token standard
- Powered by [Stacks](https://www.stacks.co/) blockchain
 
