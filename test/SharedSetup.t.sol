// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "src/Counter.sol";

abstract contract HelperContract {
    address constant IMPORTANT_ADDRESS =
        0x5432154321543215432154321543215432154321;
    Counter counterContract;
    constructor() {}
}

contract CounterContractTest is Test, HelperContract {
    function setUp() public {
        counterContract = new Counter();
    }
}

contract CounterContractTest2 is Test, HelperContract {
    function setUp() public {
        counterContract = new Counter();
    }
}

