// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ExampleContract.sol";

contract InvariantExampleTest is Test {
  ExampleContract1 foo;

  function setUp() public {
    foo = new ExampleContract1();
  }

  function invariant_A() external {
    assertEq(foo.val1() + foo.val2(), foo.val3());
  }

  function invariant_B() external {
    assertEq(foo.val1() + foo.val2(), foo.val3());
  }
}