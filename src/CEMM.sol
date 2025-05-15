// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./interfaces/ICEMM.sol";
import "./types/LiquiditySupplyState.sol";
import "./types/Curvature.sol";

abstract contract CEMM is ICEMM {
    using CurvatureServices for Curvature;
    using LiquiditySupplyStateServices for LiquiditySupplyState;

    LiquiditySupplyState private liquiditySupplyState;

    function updateLiquiditySupplyStateAfterTrade(
        LiquiditySupplyState memory outdatedLiquiditySupplyState
    ) internal {
        liquiditySupplyState = outdatedLiquiditySupplyState.updateAfterTrade();
    }
}
