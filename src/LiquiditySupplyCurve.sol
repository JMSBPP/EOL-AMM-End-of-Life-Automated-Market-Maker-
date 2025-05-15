// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./interfaces/ILiquiditySupplyCurveServices.sol";
import "./types/Curvature.sol";
import "./interfaces/ICEMM.sol";
import "./libraries/LiquiditySupplyCurveMath.sol";
abstract contract LiquiditySupplyCurve is ILiquiditySupplyCurveServices {
    using LiquiditySupplyCurveMath for *;
    Curvature private curvature;
    ICEMM private CEMM;

    constructor(address underlymngAmmFunction) {
        CEMM = ICEMM(underlymngAmmFunction);
    }
}
