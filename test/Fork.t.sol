// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/SimpleStorage.sol";

contract ForkTest is Test {
    // the identifiers for the forks
    uint256 mainnetFork;
    uint256 optimismFork;

    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
    string OPTIMISM_RPC_URL = vm.envString("OPTIMISM_RPC_URL");

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        optimismFork = vm.createFork(OPTIMISM_RPC_URL);
    }

    function testForkIdDiffers() public {
        assertNotEq(mainnetFork, optimismFork);
    }

    // Select specific fork
    function testCanSelectSpecificFork() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);
    }

    // Manage multiple forks in the same test
    function testCanManageMultipleForks() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        vm.selectFork(optimismFork);
        assertEq(vm.activeFork(), optimismFork);
    }

    // Forks can be created at all times
    function testForksCanBeCreatedAtAllTimes() public {
        uint256 fork = vm.createSelectFork(MAINNET_RPC_URL);
        assertNotEq(fork, 0);
    }

    function testCanSetForkBlockNumber() public {
        uint256 fork = vm.createSelectFork(MAINNET_RPC_URL);
        vm.rollFork(fork, 1_337_000);
        assertEq(block.number, 1_337_000);
    }

    // creates a new contract while a fork is active
    function test_ExpectFail_CreateContract() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        SimpleStorage simpleStorage = new SimpleStorage();

        simpleStorage.set(1337);
        assertEq(simpleStorage.value(), 1337);

        // after switching to another fork, the contract is not available
        vm.selectFork(optimismFork);

        /* this call will therefore revert because `simple` now points to a contract that does not exist on the active fork
         * it will produce following revert message:
         *
         * "Contract 0xCe71065D4017F316EC606Fe4422e11eB2c47c246 does not exist on active fork with id `1`
         *       But exists on non active forks: `[0]`"
         */
        simpleStorage.value();
    }

    // creates a new `persistent` contract while a fork is active
    function testCreatePersistentContract() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        SimpleStorage simpleStorage = new SimpleStorage();

        simpleStorage.set(1337);
        assertEq(simpleStorage.value(), 1337);

        // mark the contract as persistent so it is available on all forks
        vm.makePersistent(address(simpleStorage));
        assert(vm.isPersistent(address(simpleStorage)));

        vm.selectFork(optimismFork);
        assert(vm.isPersistent(address(simpleStorage)));
        // after switching to another fork, the contract is still available
        vm.selectFork(optimismFork);

        // This will succeed because the contract is persistent and available on all forks
        assertEq(simpleStorage.value(), 1337);
    }
}
