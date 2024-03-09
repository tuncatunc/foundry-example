// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/ExpectEmit.sol";

contract EmitContractTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    function test_ExpectEmit() public {
        ExpectEmit emitter = new ExpectEmit();

        // Check that topic 1, topic 2, and data are the same as the following emitted event
        // Checking topic 3 here doesn't metter, because `Transfer` only has 2 indexed topics
        vm.expectEmit(true, true, false, true);
        // The event we expect to be emitted
        emit Transfer(address(this), address(1337), 1337);
        // The event we get
        emitter.t();
    }

    function test_ExpectEmit_DoNotCheckData() public {
        ExpectEmit emitter = new ExpectEmit();

        // Check that topic 1, topic 2 are the same as the following emitted event
        // Checking topic 3 and data here doesn't metter, because `Transfer` only has 2 indexed topics
        vm.expectEmit(true, true, false, false);
        // The event we expect to be emitted
        emit Transfer(address(this), address(1337), 1338); // Different data
        // The event we get
        emitter.t();
    }
}
