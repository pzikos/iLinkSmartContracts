pragma solidity ^0.6.6;

//import "https://github.com/OpenZeppelin/openzeppelincontracts/contracts/access/Ownable.sol";
//import "https://github.com/OpenZeppelin/openzeppelincontracts/contracts/math/SafeMath.sol";

import "./MyOwnable.sol";
import "./MyMathLibrary.sol";

//contract Allowance is Ownable{
contract Allowance is MyOwner{    
    
    //using SafeMath for uint;
    using MyMathLibrary for uint;
    
    event AllowanceChanged(address indexed forWhom, address indexed byWhom, uint forNewAmount, uint forOldAmount, uint amountChanged);
    
    mapping(address => uint) allowances;
    
    modifier allowedPersonToSpend(uint amount){
        require(msg.sender == owner || allowances[msg.sender] >= amount, "Not Owner or Not Enough Money Left In User Acount To Soend");
        _;
    }
    
    function setAllowanceToUser(address toWhom, uint amount) public onlyOwner{
        emit AllowanceChanged(toWhom, msg.sender, allowances[toWhom], allowances[toWhom], amount);
        allowances[toWhom] = amount;
    }
    /*
    function addAllowanceToUser(address toWhom, uint amount) public onlyOwner{
        emit AllowanceChanged(toWhom, msg.sender, allowances[toWhom], allowances[toWhom].add(amount), amount);
        allowances[toWhom] = allowances[toWhom].add(amount);
    }
    */
    function reduceAllowanceFromUser(address toWhom, uint amount) internal allowedPersonToSpend(amount){
        emit AllowanceChanged(toWhom, msg.sender, allowances[toWhom], allowances[toWhom].sub(amount), amount);
        allowances[toWhom] = allowances[toWhom].sub(amount);
    }
    
}