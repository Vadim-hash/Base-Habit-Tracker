// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

interface IZenithHabitTracker {
    function startNewHabit(uint256 requiredCheckIns, bytes32 habitHash) external payable returns (uint256);
    function checkInDailyHabit(uint256 habitId) external;
}
