// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/OwnerUpOnly.sol";

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly ownerUpOnly;

    function setUp() public {
        ownerUpOnly = new OwnerUpOnly();
    }

    function test_IncrementAsOwner() public {
        ownerUpOnly.increment();
        assertEq(ownerUpOnly.number(), 1);
    }

    function testFail_IncrementAsNotOwner() public {
      vm.prank(address(1));
      ownerUpOnly.increment();
    }

    function test_RevertWhen_CallerIsNotOwner() public {
      vm.expectRevert(Unauthorized.selector);
      vm.prank(address(1));
      ownerUpOnly.increment();
    }
}
