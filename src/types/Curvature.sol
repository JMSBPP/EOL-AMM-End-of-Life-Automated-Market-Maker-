// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

type Curvature is uint256;

library CurvatureServices {
    /**
     * @dev Calculates the amount of token Y (deltaY) a trader receives in exchange for a given amount of token X (deltaX)
     *      based on the current liquidity reserves and a specified curvature parameter. This function implements a bonding
     *      curve mechanism where the exchange rate between tokens X and Y is influenced by the curvature (kappa_M), which
     *      controls the price elasticity or sensitivity of the pool to trades. A higher curvature results in a steeper curve,
     *      meaning larger trades cause greater price impact (higher slippage).
     * @param curvature The curvature parameter (kappa_M) of the bonding curve, determining the price elasticity of the pool.
     * @param reserveX The current reserve of token X in the liquidity pool.
     * @param reserveY The current reserve of token Y in the liquidity pool.
     * @param deltaX The amount of token X being input (sold) by the trader into the pool.
     * @return deltaY The amount of token Y that the trader receives in exchange for deltaX, based on the current reserves
     *                and the bonding curve defined by the curvature.
     */
    function calculateSwapOutputWithCurvature(
        Curvature curvature,
        uint256 reserveX,
        uint256 reserveY,
        uint256 deltaX
    ) public pure returns (uint256 deltaY) {
        deltaY =
            reserveY *
            ((reserveX + deltaX) / reserveX) ** (getCurvatureValue(curvature)) -
            reserveY;
    }
    function calculateSpotPrice(
        Curvature curvature,
        uint256 reserveX,
        uint256 reserveY
    ) public pure returns (uint256 spotPrice) {
        spotPrice = getCurvatureValue(curvature) * (reserveY / reserveX);
    }

    function calculateSpotSlippageCost(
        Curvature curvature,
        uint256 reserveY
    ) public pure returns (uint256 spotSlippageCost) {
        spotSlippageCost = calculateElasticity(curvature) * (1 / reserveY);
    }

    function getCurvatureValue(
        Curvature curvature
    ) public pure returns (uint256 curvatureValue) {
        curvatureValue = Curvature.unwrap(curvature);
    }

    function calculateElasticity(
        Curvature curvature
    ) public pure returns (uint256 elasticity) {
        uint256 curvatureValue = getCurvatureValue(curvature);
        elasticity = (curvatureValue + 1) / curvatureValue;
    }
}
