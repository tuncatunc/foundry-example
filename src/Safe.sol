// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Safe {

  // This is a fallback function, which means it will be called when the contract receives ether
  receive() external payable {}

  function withdraw() external {
    payable(msg.sender).transfer(address(this).balance);
  }
}