pragma solidity ^0.5.17;
//series 2
contract WorkingWithMappings{
    
    bool public contractPaused;
    address public owner;
    
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAdrressMapping;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function getNewBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function sendMoneyTo(address payable to) public {//payable to indicate it can receive money
        require(msg.sender == owner, "Ypu are not the onwer mother fucker");
        require(!contractPaused);
        to.transfer(this.getNewBalance());
    }
    
    function setmappingValue(uint index, bool value) public {
        myMapping[index] = value;
    }
    
    function setMyAddressMapping(address adr, bool input) public {
        require(msg.sender == owner, "Get Lost re!");
        require(!contractPaused);
        myAdrressMapping[adr] = input;
    }
    
     function pauseOrResumeContract(bool input) public {
        require(msg.sender == owner, "Only Owner Can pause/Result the Contract");
        contractPaused = input;
    }
    
    function destoryTheContract(address payable to) public {
        require(msg.sender == owner, "Get Lost");
        selfdestruct(to);
    }
}