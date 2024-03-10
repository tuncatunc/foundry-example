// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract ExampleContract1 {
    uint256 public val1;
    uint256 public val2;
    uint256 public val3;

    function addToA(uint256 _val) external {
        val1 += _val;
        val3 += _val;
    }

    function addToB(uint256 _val) external {
        val2 += _val;
        val3 += _val;
    }
}
