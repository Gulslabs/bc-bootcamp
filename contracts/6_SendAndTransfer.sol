// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Sender {

    receive() external payable {}

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public {
        // Send may fail so you should have a check.         
        // _to.send(10);
        bool sentSuccessful = _to.send(10);
        require(sentSuccessful, "Failed to send money");
    }
}

contract ReceiverNoAction {
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    receive() external payable {}
}


contract ReceiverAction {

    uint public balanceReceived;

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        balanceReceived += msg.value;
    }
}