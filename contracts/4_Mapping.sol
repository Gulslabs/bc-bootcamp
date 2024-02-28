// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ExampleMapping {

   mapping(address=>uint) public addressToBalances; 

    function sendMoney() external payable {
        addressToBalances[msg.sender] += msg.value; 
    }

    function getBalance() external view returns(uint) {
        return addressToBalances[msg.sender];
    }

    function withdrawMoneyTo(address payable  _to) external  {
        // Checks Effect Interaction Pattern. Reentrance Attack.         
        _to.transfer(addressToBalances[msg.sender]);
        addressToBalances[msg.sender]=0; 
    }

}