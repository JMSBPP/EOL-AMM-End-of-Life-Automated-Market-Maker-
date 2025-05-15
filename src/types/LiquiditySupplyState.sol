// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./Curvature.sol";

struct LiquiditySupplyState {
    uint256 reserveX;
    uint256 reserveY;
    Curvature curvature;
    uint256 amountXIn;
    uint256 amountYOut;
    uint32 timeStampt;
}

library LiquiditySupplyStateServices {
    using CurvatureServices for Curvature;
    function updateAfterTrade(
        LiquiditySupplyState memory outdatedLiquiditySupplyState
    )
        public
        returns (LiquiditySupplyState memory updatedLiquiquiditySupplyState)
    {
        uint256 deltaY = outdatedLiquiditySupplyState
            .curvature
            .calculateSwapOutputWithCurvature(
                outdatedLiquiditySupplyState.reserveX,
                outdatedLiquiditySupplyState.reserveY,
                outdatedLiquiditySupplyState.amountXIn
            );
        updatedLiquiquiditySupplyState = LiquiditySupplyState({
            reserveX: outdatedLiquiditySupplyState.reserveX +
                outdatedLiquiditySupplyState.amountXIn,
            reserveY: outdatedLiquiditySupplyState.reserveY - deltaY,
            curvature: outdatedLiquiditySupplyState.curvature,
            amountXIn: outdatedLiquiditySupplyState.amountXIn,
            amountYOut: deltaY,
            timeStampt: uint32(block.timestamp)
        });
    }

    function calculateSubstitutionRate(
        LiquiditySupplyState memory liquiditySupplyState
    ) internal pure returns (uint256 substitutionRate) {
        substitutionRate =
            liquiditySupplyState.reserveY /
            liquiditySupplyState.reserveX;
    }

    function calculateTermsOfTrade(
        LiquiditySupplyState memory liquiditySupplyState
    ) public returns (uint256 termsOfTrade) {
        uint256 curvature = liquiditySupplyState.curvature.getCurvatureValue();
        termsOfTrade =
            curvature *
            calculateSubstitutionRate(liquiditySupplyState);
    }

    function calculateSlippageCost(
        LiquiditySupplyState memory liquiditySupplyState
    ) public pure returns (uint256 slippageCost) {
        uint256 inverseReserveY = 1 / liquiditySupplyState.reserveY;
        uint256 curvatureValue = liquiditySupplyState
            .curvature
            .getCurvatureValue();
        slippageCost = curvatureValue * inverseReserveY;
    }
}
