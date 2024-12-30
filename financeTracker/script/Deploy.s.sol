// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Script} from "forge-std/Script.sol";
import {FinanceSystem} from "../src/FinanceSystem.sol";

contract Deploy is Script {
    function run() external returns (FinanceSystem) {
        address owner = address(msg.sender);
        vm.startBroadcast(msg.sender);
        FinanceSystem fs = new FinanceSystem("MyOrg", owner);

        // Add tracked accounts
        address[6] memory accounts = [
            0x1234567890AbcdEF1234567890aBcdef12345678,
            0x9876543210FeDcba9876543210FEdCba98765432,
            0xdEF1234567890AbcdEF1234567890aBcdEF12345,
            0xabCDEF1234567890ABcDEF1234567890aBCDeF12,
            0xfEdcBA9876543210FedCBa9876543210fEdCBa98,
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        ];

        for (uint i = 0; i < accounts.length; i++) {
            fs.addAccount(accounts[i]);
        }

        // Add 20 sample transactions with manual timestamps
        fs.addTransaction(1000, "Subscription Service Payment", 0xfEdcBA9876543210FedCBa9876543210fEdCBa98, accounts[0], false, 1704067200); // Jan 1, 2024
        fs.addTransaction(750, "Office Rent", 0x876543210AbcdeF9876543210abCdeF987654321, accounts[1], false, 1706745600); // Feb 1, 2024
        fs.addTransaction(2000, "Client Payment Received", accounts[0], 0xdEF1234567890AbcdEF1234567890aBcdEF12345, true, 1709251200); // Mar 1, 2024
        fs.addTransaction(1500, "Payment for Services", accounts[3], accounts[1], true, 1711929600); // Apr 1, 2024
        fs.addTransaction(1200, "Freelancer Payment", accounts[1], accounts[2], false, 1714521600); // May 1, 2024
        fs.addTransaction(2500, "Product Sales", accounts[0], accounts[3], true, 1717200000); // Jun 1, 2024
        fs.addTransaction(2500, "New Product Sales", accounts[0], accounts[3], true, 17172001000); // Jun 1, 2024
        fs.addTransaction(3000, "Consultation Fees", accounts[1], accounts[4], true, 1719792000); // Jul 1, 2024
        fs.addTransaction(500, "Office Supplies", accounts[2], 0x6543210fedcBA9876543210Fedcba9876543210f, false, 1722470400); // Aug 1, 2024
        fs.addTransaction(800, "Utility Bill Payment", 0x876543210AbcdeF9876543210abCdeF987654321, accounts[1], false, 1725148800); // Sep 1, 2024
        fs.addTransaction(1800, "Received from Partner", accounts[0], accounts[2], true, 1727740800); // Oct 1, 2024
        fs.addTransaction(700, "Advertising Payment", accounts[4], accounts[0], false, 1730419200); // Nov 1, 2024
        fs.addTransaction(900, "Web Development Contract", accounts[1], accounts[3], true, 1704153600); // Jan 2, 2024
        fs.addTransaction(2200, "Partner Commission", accounts[0], accounts[4], true, 1706832000); // Feb 2, 2024
        fs.addTransaction(400, "IT Services Payment", accounts[2], accounts[1], false, 1709337600); // Mar 2, 2024
        fs.addTransaction(1600, "Maintenance Fees", accounts[3], accounts[4], true, 1712016000); // Apr 2, 2024
        fs.addTransaction(300, "Food Supplies", accounts[0], accounts[2], false, 1714608000); // May 2, 2024
        fs.addTransaction(700, "Travel Expenses", accounts[1], accounts[3], false, 1717286400); // Jun 2, 2024
        fs.addTransaction(2100, "Annual Bonus Payment", accounts[3], accounts[1], true, 1719878400); // Jul 2, 2024
        fs.addTransaction(650, "Support Payment", accounts[1], accounts[3], false, 1722556800); // Aug 2, 2024

        vm.stopBroadcast();
        return (fs);
    }
}

//  forge script script/Deploy.s.sol --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
//  forge script script/Deploy.s.sol --rpc-url https://testnet.evm.nodes.onflow.org --private-key $PRIVATE_KEY --broadcast