// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Safe.sol";

contract SafeTest is Test {
    Safe safe;

    // This is a fallback function, which means it will be called when the contract receives ether
    receive() external payable {}

    function setUp() public {
        safe = new Safe();
    }

    function testWithdraw() public {
        payable(address(safe)).transfer(1 ether);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(
            postBalance,
            preBalance + 1 ether,
            "Balance should increase by 1 ether"
        );
    }

    function testFuzz_Withdraw(uint256 amount) public {
        vm.assume(amount > 0.1 ether);
        // The default amount of ether that the test contract is given is 2**96 wei
        vm.assume(amount < 2 ** 96 wei);
        payable(address(safe)).transfer(amount);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(
            postBalance,
            preBalance + amount,
            "Balance should increase by amount"
        );
    }
}
