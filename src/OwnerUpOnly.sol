// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

error Unauthorized();

contract OwnerUpOnly {
  address public immutable owner;
  uint256 public number;

  constructor() {
    owner = msg.sender;
  }

  function increment() public {
    if (msg.sender != owner) {
      revert Unauthorized();
    }

    number++;
  }
}