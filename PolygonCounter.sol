// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ICounterPOLToken {
    function mint(address to, uint256 amount) external;
}

contract PolygonCounter {
    uint256 public counter;

    ICounterPOLToken public token;

    event CounterIncreased(address indexed user, uint256 newValue);
    event CounterDecreased(address indexed user, uint256 newValue);
    event RewardMinted(address indexed user, uint256 amount);

    constructor(address tokenAddress) {
        token = ICounterPOLToken(tokenAddress);
    }

    function increment() external {
        counter += 1;

        uint256 reward = 100 * 10 ** 18;

        token.mint(msg.sender, reward);

        emit CounterIncreased(msg.sender, counter);
        emit RewardMinted(msg.sender, reward);
    }

    function decrement() external {
        require(counter > 0, "Counter cannot go below zero");

        counter -= 1;

        uint256 reward = 100 * 10 ** 18;

        token.mint(msg.sender, reward);

        emit CounterDecreased(msg.sender, counter);
        emit RewardMinted(msg.sender, reward);
    }
}