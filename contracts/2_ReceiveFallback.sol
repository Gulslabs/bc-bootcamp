// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ReceiveFallBack {
    uint public lastValueSent; 
    string public lastFunctionCalled; 

    receive() external payable { 
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }


    fallback() external payable { 
        lastValueSent = msg.value;
        lastFunctionCalled = "fallBack";
    }
}