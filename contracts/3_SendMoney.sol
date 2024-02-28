// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SendWithdrawalMoney {

    uint public balanceReceived; 

    function deposit() external payable  {
        balanceReceived +=msg.value; 
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAll() external payable  {        
        // Option 1:
        (bool success, ) =  msg.sender.call{value: getBalance()}("");
        require(success, "Transfer failed");
        // Option 2: 
       // payable(msg.sender).transfer(getBalance());
    }

    function withdrawalToAddress(address payable  to) external  {
        to.transfer(getBalance());
    }

}