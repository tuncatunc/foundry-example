// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

contract SimpleStorage {
    uint256 public value;

    function set(uint256 _value) public {
        value = _value;
    }
}
