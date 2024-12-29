// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;
import {Test, console} from "forge-std/Test.sol";
import {Deploy} from "../script/Deploy.s.sol";
import {FinanceSystem} from "../src/FinanceSystem.sol";

contract NormalTests is Test {
    FinanceSystem ft;
    address USER = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

    function setUp() public {
        Deploy deploy = new Deploy();
        ft = deploy.run();
    }

    function testTransactions() public {
        vm.startPrank(USER);
        uint256 initialBalance = ft.getTransactions().length;
        vm.stopPrank();
        assertEq(initialBalance, 20);
    }

}
