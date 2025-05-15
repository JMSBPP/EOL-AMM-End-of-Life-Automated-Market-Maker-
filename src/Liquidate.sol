// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import {ERC6909} from "v4-core/ERC6909.sol";

// At each epoch boundary, the following is executed
// in an atomic step: for each liquidity provider in Lliquidate, get the amounts of X
// and Y they have the right to, remove this liquidity, sell the total units of Y that
// have been traded for X, and distribute these funds to each member of Lliquidate in
// proportion to their shares of asset X; then set Lliquidate ← ∅

contract Liquidate is ERC6909 {}
