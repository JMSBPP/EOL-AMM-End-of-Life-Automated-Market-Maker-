// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

import "./stimulus/IPoolSupplyDemandStimulus.sol";
import "./stimulus/ILPRelatedStimulus.sol";
import "./IActionSpace.sol";
interface IPoolActionSpace is IActionSpace {
    /**
     * @dev Enables direct marketing for the pool.
     * TRIGGERING EVENT: When token is on pre-expiration epoch
     * and market is either not on equilibrium
     */
    function enableDirectMarketing(
        LogRecord memory expiryTokenEpochStimulus,
        LogRecord memory poolNonEquilibriumStimulus,
        LogRecord memory lpsInactivityStimulus
    ) external;
    /**
     * @dev Enables secon d price acution.
     * TRIGGERING EVENT: token expires or allLpsInactive
     * and market is either not on equilibrium or not cleared
     */

    function enableSecondPriceAuction(
        LogRecord memory expiryTokenEpochStimulus,
        LogRecord memory poolNonEquilibriumStimulus,
        LogRecord memory lpsInactivityStimulus
    ) external;
}
