// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
// Requirements
// Wallet has 1 owner. 
// Wallet should be able to receive funds. ( from EOA or  contracts) 
// spend funds to any EOA or Contract
// Give Allowance that certain address to spend upto certain amount; with provision to add new allowance addresses. 
// Update the owner to a new onwner by 3 out of 5 guardians voting for new owner

contract MultiSigWallet {

    address public owner;
    mapping(address => bool) public isGuardian;
    mapping(address => uint256) public allowances;
    mapping(address => uint256) public votesReceived;

    uint256 public voteThreshold;

    event FundsReceived(address indexed from, uint256 amount);
    event FundSent(address indexed to, uint256 amount);
    event AllowanceSet(address indexed spender, uint256 amount);
    event OwnerChanged(address indexed newOwner);
    event GuardianAdded(address indexed guardian);
    event GuardianRemoved(address indexed guardian);
    event Voted(address indexed guardian);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyGuardian() {
        require(isGuardian[msg.sender], "Only guardians can change the owner");
        _;
    }

    modifier hasAllowance(uint256 amount) {
        require(msg.sender == owner || allowances[msg.sender] >= amount, "Insufficient allowance");
        _;
    }

    modifier notVoted() {
        require(votesReceived[msg.sender] == 0, "Guardian has already voted");
        _;
    }

    constructor(uint256 _voteThreshold) {
        require(_voteThreshold > 0 && _voteThreshold <= 5, "Invalid vote threshold");

        owner = msg.sender;
        voteThreshold = _voteThreshold;
    }

    receive() external payable {
        emit FundsReceived(msg.sender, msg.value);
    }

    function sendFunds(address payable to, uint256 amount) external hasAllowance(amount) {
        require(address(this).balance >= amount, "Insufficient funds");
        to.transfer(amount);
        if (msg.sender != owner) {
            allowances[msg.sender] -= amount;
        }
        emit FundSent(to, amount);
    }

    function setAllowance(address spender, uint256 amount) external onlyOwner {
        allowances[spender] = amount;
        emit AllowanceSet(spender, amount);
    }

    function changeOwner(address newOwner) external onlyGuardian notVoted {
        votesReceived[newOwner]++;
        emit Voted(msg.sender);

        // Check if the new owner has reached the vote threshold
        if (votesReceived[newOwner] >= voteThreshold) {
            owner = newOwner;
            emit OwnerChanged(newOwner);
        }
    }

    function addGuardian(address newGuardian) external onlyOwner {
        require(!isGuardian[newGuardian], "Address is already a guardian");
        isGuardian[newGuardian] = true;
        emit GuardianAdded(newGuardian);
    }

    function removeGuardian(address guardianToRemove) external onlyOwner {
        require(isGuardian[guardianToRemove], "Address is not a guardian");
        require(msg.sender != guardianToRemove, "Cannot remove yourself as a guardian");
        isGuardian[guardianToRemove] = false;
        emit GuardianRemoved(guardianToRemove);
    }
}