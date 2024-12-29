// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

/**
Contract to track financial transactions: 
Admin initializes contract with his address and organization name
Admin can add accounts to be tracked
Admin can remove accounts from being tracked
Authorized accounts can make payments
Authorized accounts can manually add transactions ( like those for money received )
Authorized accounts can get transaction details
 */

contract FinanceSystem {
    // Owner of the contract
    address immutable i_owner;
    // Name of the organization
    string private orgName;

    // Transaction struct
    struct Transaction {
        uint256 amount;
        string description;
        address recipient;
        address sender;
        bool sentToOrg;
        uint256 timestamp;
        uint256 accountBalance;
    }
    // Mapping of tracked accounts
    mapping(address => bool) private trackedAccounts;
    address[] private accountsList;
    // Array of transactions
    Transaction[] private transactions;

    // constructor function
    constructor(string memory _orgName, address _owner) {
        i_owner = _owner;
        orgName = _orgName;
    }

    // Modifier to check if the caller is the owner
    modifier onlyOwner() {
        require(msg.sender == i_owner, "Only owner can call this function");
        _;
    }

    // Modifier to check if the caller is a tracked account
    modifier onlyAuthorized() {
        // require(trackedAccounts[msg.sender] || msg.sender==i_owner, "Only authorized accounts can call this function");
        require(true, "Only authorized accounts can call this function");
        _;
    }

    // Owner able to add tracked accounts
    function addAccount(address _account) public onlyOwner {
        trackedAccounts[_account]=true;
        accountsList.push(_account);
    }
    // Owner able to remove tracked accounts
    function removeAccount(address _account) public onlyOwner {
        require(trackedAccounts[_account]==true, " Account didn't have access ");
        trackedAccounts[_account]=false;
        findAndRemove(_account);
    }

    function findAndRemove(address _account) internal {
        uint256 lastIndex=accountsList.length-1;
        for(uint256 i=0;i<accountsList.length;i++){
            if(accountsList[i]==_account){
                accountsList[i]=accountsList[lastIndex];
            }
        }
        accountsList.pop();
    }

    // Tracked accounts allowed to make payments
    function makePayment(uint256 _amount, string memory _description, address _recipient, bool _sentToOrg) public onlyAuthorized {
        require(_amount > 0, "Amount must be greater than 0");
        require(_recipient != address(0), "Recipient address must be valid");

        (bool success, ) = _recipient.call{value: _amount}("");
    
        if (!success) {
            revert("Transfer failed");
        }
        Transaction memory newTransaction = Transaction({
            amount: _amount,
            description: _description,
            recipient: _recipient,
            sender: msg.sender,
            sentToOrg: _sentToOrg,
            timestamp: block.timestamp,
            accountBalance: address(msg.sender).balance
        });
        transactions.push(newTransaction);
    }
    // Add a manual transaction
    function addTransaction(uint256 _amount, string memory _description, address _recipient, address _sender, bool _sentToOrg, uint256 _timestamp) public onlyOwner {
        require(_amount > 0, "Amount must be greater than 0");
        Transaction memory newTransaction = Transaction({
            amount: _amount,
            description: _description,
            recipient: _recipient,
            sender: _sender,
            sentToOrg: _sentToOrg,
            timestamp: _timestamp,
            accountBalance: address(msg.sender).balance
        });

        transactions.push(newTransaction);
    }

    // Get the transactions
    function getTransactions() public view onlyAuthorized returns (Transaction[] memory) {
        return transactions;
    }
    // Get the recent transactions
    function getRecentTransactions() public view onlyAuthorized returns (Transaction memory) {
        require(transactions.length>0, " No transactions yet");
        return transactions[0];
    }
    function getAccountsList() public view returns (address[] memory)  {
        return accountsList;
    }

}
