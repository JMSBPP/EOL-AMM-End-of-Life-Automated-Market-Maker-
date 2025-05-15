// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./IActionSpace.sol";
interface ILPActionSpace is IActionSpace {
    /**
     * @dev enables powered Uniswap v4 concenrated liquidity mecahnisms
     * @param expiryTokenEpochStimulus Only the epoch boundary matters
     * @param poolNonEquilibriumStimulus Available only when the pool is not on equilibrium
     */
    function freezeLiquidity(
        LogRecord memory expiryTokenEpochStimulus,
        LogRecord memory poolNonEquilibriumStimulus
    ) external;

    function changeCurvature(
        LogRecord memory expiryTokenEpochStimulus,
        LogRecord memory poolNonEquilibriumStimulus
    ) external;
}
