pragma solidity ^0.6.6;

contract MyOwner{
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner, "You Are Not the Owner");
        _;
    }
    
    function isOwner() internal view returns (bool){
        return msg.sender == owner;
    }
}