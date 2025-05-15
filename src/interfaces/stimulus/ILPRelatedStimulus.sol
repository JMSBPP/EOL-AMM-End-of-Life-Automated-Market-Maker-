// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

interface ILPRelatedStimulus {
    event AllLPsInactive();

    event inactiveLp(address lp, uint256 epoch);

    event activeLp(address lp, uint256 epoch);
}
