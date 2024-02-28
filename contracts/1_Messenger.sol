// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Messenger {

    address owner = msg.sender; 

    string public theMessage = "Hello World"; 

    uint public updateCount; 

    function updateTheMessage(string memory _newMessage) external {
        if(owner == msg.sender)     {
            theMessage = _newMessage; 
            updateCount++; 
        }       
    }

    function updateTheMessageWith1Ether(string memory _newMessage) external payable  {
        if(msg.value >= 1 ether) {
            theMessage = _newMessage; 
            updateCount++; 
        }
    }
    function balance() external payable  returns (uint) {
        return address(this).balance;
    }

    function transferAllToMe() external  payable  {        
        payable(msg.sender).transfer(address(this).balance);
    }

}