// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "../interfaces/ILiquidityDistribution.sol";
type LiquidityProvider is address;

library LiquidityProviderActions {
    function aggregate(
        LiquidityProvider[] memory liquidityProviders,
        ILiquidityDistribution[] memory liquidityDistributions
    ) internal {}
}
