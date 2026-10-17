// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

contract ZenithHabitTracker {
    struct Habit {
        address payable user;
        uint256 stakeWei;
        uint256 checkInsRequired;
        uint256 currentCheckIns;
        uint256 lastCheckInTime;
        bool isActive;
        bytes32 habitHash;
    }

    address payable public immutable trackerAdmin;
    string public trackerDescriptor;
    uint256 public platformFeeBps; // 200 = 2%
    uint256 public habitCounter;
    uint256 public accumulatedFees;
    bool public isTrackerPaused;

    mapping(uint256 => Habit) public habits;

    event HabitStarted(uint256 indexed habitId, address indexed user, uint256 stake);
    event DailyCheckIn(uint256 indexed habitId, uint256 currentCheckIns);
    event HabitCompleted(uint256 indexed habitId, uint256 rewardPayout);
    event HabitAbandoned(uint256 indexed habitId, uint256 penalty);
    event TreasuryDeposited(address indexed funder, uint256 amount);
    event ReservesDrained(address indexed admin, uint256 amount);
    event FeesHarvested(address indexed admin, uint256 amount);
    event TrackerPauseToggled(bool isPaused);
    event DescriptorUpdated(string newDescriptor);

    modifier onlyAdmin() {
        require(msg.sender == trackerAdmin, "ZenithHabit: Access denied");
        _;
    }

    modifier whenNotPaused() {
        require(!isTrackerPaused, "ZenithHabit: System is paused");
        _;
    }

    constructor() {
        trackerAdmin = payable(msg.sender);
        trackerDescriptor = "Zenith Base Habit Tracker v1";
        platformFeeBps = 200; // 2%
        isTrackerPaused = false;
    }

    // 1. abandonHabitStreak
    function abandonHabitStreak(uint256 habitId) external {
        Habit storage h = habits[habitId];
        require(habitId > 0 && habitId <= habitCounter, "ZenithHabit: Invalid ID");
        require(msg.sender == h.user || msg.sender == trackerAdmin, "ZenithHabit: Unauthorized");
        require(h.isActive, "ZenithHabit: Already inactive");

        h.isActive = false;
        accumulatedFees += h.stakeWei; // Штраф уходит в пул платформы
        h.stakeWei = 0;

        emit HabitAbandoned(habitId, accumulatedFees);
    }

    // 2. checkInDailyHabit
    function checkInDailyHabit(uint256 habitId) external whenNotPaused {
        Habit storage h = habits[habitId];
        require(msg.sender == h.user, "ZenithHabit: Not your habit");
        require(h.isActive, "ZenithHabit: Habit inactive");
        // В реальной жизни здесь была бы проверка времени: require(block.timestamp > h.lastCheckInTime + 1 days);

        h.currentCheckIns++;
        h.lastCheckInTime = block.timestamp;

        emit DailyCheckIn(habitId, h.currentCheckIns);
    }

    // 3. claimHabitReward
    function claimHabitReward(uint256 habitId) external {
        Habit storage h = habits[habitId];
        require(msg.sender == h.user, "ZenithHabit: Not your habit");
        require(h.isActive, "ZenithHabit: Habit inactive");
        require(h.currentCheckIns >= h.checkInsRequired, "ZenithHabit: Goal not met yet");

        h.isActive = false;
        uint256 payout = h.stakeWei;
        h.stakeWei = 0;

        (bool sent, ) = h.user.call{value: payout}("");
        require(sent, "ZenithHabit: Reward payout failed");

        emit HabitCompleted(habitId, payout);
    }

    // 4. depositPlatformTreasury
    function depositPlatformTreasury() external payable whenNotPaused {
        require(msg.value > 0, "ZenithHabit: Zero deposit");
        accumulatedFees += msg.value;
        emit TreasuryDeposited(msg.sender, msg.value);
    }

    // 5. drainTrackerReserves
    function drainTrackerReserves() external onlyAdmin {
        uint256 balance = address(this).balance;
        require(balance > 0, "ZenithHabit: Zero balance");

        accumulatedFees = 0;
        (bool sent, ) = trackerAdmin.call{value: balance}("");
        require(sent, "ZenithHabit: Sweep failed");

        emit ReservesDrained(trackerAdmin, balance);
    }

    // 6. harvestPlatformFees
    function harvestPlatformFees() external onlyAdmin {
        uint256 amount = accumulatedFees;
        require(amount > 0, "ZenithHabit: Zero fees");

        accumulatedFees = 0;
        (bool sent, ) = trackerAdmin.call{value: amount}("");
        require(sent, "ZenithHabit: Harvest failed");

        emit FeesHarvested(trackerAdmin, amount);
    }

    // 7. pauseHabitTracker
    function pauseHabitTracker(bool isPaused) external onlyAdmin {
        isTrackerPaused = isPaused;
        emit TrackerPauseToggled(isPaused);
    }

    // 8. startNewHabit
    function startNewHabit(uint256 requiredCheckIns, bytes32 habitHash) external payable whenNotPaused returns (uint256) {
        require(requiredCheckIns > 0, "ZenithHabit: Must require at least 1 check-in");
        
        uint256 fee = (msg.value * platformFeeBps) / 10000;
        uint256 netStake = msg.value - fee;
        accumulatedFees += fee;

        habitCounter++;
        habits[habitCounter] = Habit({
            user: payable(msg.sender),
            stakeWei: netStake,
            checkInsRequired: requiredCheckIns,
            currentCheckIns: 0,
            lastCheckInTime: block.timestamp,
            isActive: true,
            habitHash: habitHash
        });

        emit HabitStarted(habitCounter, msg.sender, netStake);
        return habitCounter;
    }

    // 9. updateTrackerDescriptor
    function updateTrackerDescriptor(string calldata newDescriptor) external onlyAdmin {
        require(bytes(newDescriptor).length > 0, "ZenithHabit: Empty string");
        trackerDescriptor = newDescriptor;
        emit DescriptorUpdated(newDescriptor);
    }
}