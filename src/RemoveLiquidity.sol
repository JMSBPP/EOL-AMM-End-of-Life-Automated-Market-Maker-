// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import {ERC6909} from "v4-core/ERC6909.sol";

// At the next epoch
// boundary, the AMM simply sends the assets that each ℓ ∈ Lremove has the right to
// (computed in the obvious way, depending on if ℓ ∈ L or ℓ ∈ L
// ′
// ) back to ℓ
contract RemoveLiquidity is ERC6909 {}
