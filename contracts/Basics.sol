// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Basics {

    address public myAddress; 

    uint public myStorageVariable; 

    // called only once; cannot be overloaded. 
    constructor(address _myAddress) {
        myAddress = _myAddress;
    }
    // Write functions should generally have no returns; if so they are purely meant to be for internal contracts only. 
    function updateMyAddress(address _myAddress) public {
        myAddress = _myAddress;        
    }

    function updateMyAddressToSender() public {
        myAddress= msg.sender; 
    }

    function myBalance() public view returns(uint){
        return myAddress.balance;
    }

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable; 
    }

    function add(uint a, uint b) public pure returns(uint) {
        return a+b; 
    }        
}