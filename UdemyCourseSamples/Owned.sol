pragma solidity ^0.6.3;

contract Owned {
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner {//as a global variable to reuse it and not copy paste code
        require(owner == msg.sender, "You are not allowed, only the Owner can!");
        _;
    }
}
