pragma solidity ^0.6.4;

contract ItemOwnable{
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function _isOnwer() public view returns (bool) {
        return owner == msg.sender;
    }
    
    modifier OnlyOwner() {
        require(_isOnwer(), "Only Owner is Allowed");
        _;
    }
}

