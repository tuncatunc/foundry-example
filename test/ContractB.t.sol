// SPDX-License-Identifier: unlicensed

pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract ContractBTest is Test {
    uint256 public number;
    function setUp() public {
      number = 42;
    }

    function test_NumberIs42() public {
        assertEq(number, 42);
    }

    function testFail_Subtract43() public {
      vm.expectRevert(stdError.arithmeticError);
        assertEq(number - 1, 43);
    }
}
