# Base Habit Tracker

A decentralized productivity and lifestyle protocol on the Base network. This smart contract allows users to commit to personal goals, track daily streaks entirely on-chain, and build verifiable, tamper-proof records of their consistency.

## System Mechanics
* **Streak Tracking:** Employs timestamp intervals to verify daily check-ins, automatically resetting streaks if the user misses the strict validation window.
* **Immutable Commitments:** Users log their habit declarations directly to the ledger, creating a permanent, public accountability layer.
* **Gamified Progression:** Emits detailed events for every successful check-in, enabling frontends to render dynamic heatmaps and achievement badges.

## Architecture
The storage is highly localized, using nested mappings to securely isolate each user's habit data while maintaining overall state efficiency across the protocol.
