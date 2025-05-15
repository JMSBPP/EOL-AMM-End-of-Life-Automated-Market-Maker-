// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./interfaces/ILiquidityDistribution.sol";
import "./interfaces/IPriceBeliefs.sol";

abstract contract LiquidityDistribution is ILiquidityDistribution {
    mapping(address liquidityProvider => IPriceBelief priceBeliefDistribution)
        private _priceBeliefs;
}
