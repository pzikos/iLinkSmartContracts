pragma solidity ^0.5.17;
//series 1
contract WorkingWithVariables{
    
    uint256 public myVar;
    bool public myBool;
    uint8 public mySmallVal;
    string public myString = 'Hello Zikos';//avoid strings
    uint public balancedReceived;
    address public owner;
    address public myAddress;
    bool contractPaused;
    
    constructor(uint256 input, bool input2) public{
        myVar = input;
        myBool = input2;
        owner = msg.sender;
    }
    
    function setValue(uint256 _input) public {
        myVar = _input;
    }
    
    function setBool(bool _input) public{
        myBool = _input;
    }
    
    function getMyValr() public view returns (uint retVal){
        return myVar;
    }
    
    function getMyBool() public view returns (bool retval){
        return myBool;
    }
    
    function incrementSmallInt() public {
        mySmallVal++;
    }
    
    function decrementSmallInt() public {
        mySmallVal--;
    }
    
    function setMyAddress(address _input) public {
        myAddress = _input;
    }
    
    function getMyAddressBalance() public view returns (uint) {
        return myAddress.balance;
    }
    
    function setMyString(string memory _input) public {//memory keyword to indicate where to store it temporarily
        myString = _input;
    }
    
    function getNewBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function sendMoneyTo(address payable to) public {
        require(msg.sender == owner, "Ypu are not the onwer mother fucker");//if-else-throw
        require(!contractPaused);
        to.transfer(this.getNewBalance());
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