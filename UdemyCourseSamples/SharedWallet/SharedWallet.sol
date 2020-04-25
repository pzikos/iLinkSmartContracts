pragma solidity ^0.6.6;

//import "https://github.com/OpenZeppelin/openzeppelincontracts/contracts/access/Ownable.sol";
//import "https://github.com/OpenZeppelin/openzeppelincontracts/contracts/math/SafeMath.sol";

import "./Allowance.sol";
import "./MyMathLibrary.sol";
import "./MyOwnable.sol";

//contract SharedWallet is Ownable, Allowance{
contract SharedWallet is MyOwner, Allowance{ 
    
    uint public totalAmountSpent;
    uint public totalAmountReceived;
    
    struct moneyIn{
        uint inAmount;
        uint timestamp;
    }
    
    struct moneyOut{
        uint outAmount;
        uint timestamp;
    }
    
    struct deposit{
        uint totalAmountReceived;
        uint numOfDeposits;
        mapping(uint => moneyIn) _in;
    }
    
    struct payment{
        uint totalAmountPaid;
        uint numOfPayments;
        mapping(uint => moneyOut) _out;
    }
    
    mapping(address => deposit) deposits;
    mapping(address => payment) payments;
    
    event depositEvent(address indexed fromWhom, uint amount);
    event paymentEvent(address indexed toWhom, uint amount);
    
    function withdrawMoney(address payable to, uint amount) public allowedPersonToSpend(amount){
        require(amount <= address(this).balance, "Not Enough Money To Spend");
        if(!isOwner()){
            emit paymentEvent(to, amount);
        }
        reduceAllowanceFromUser(msg.sender, amount);
        spendMoney(msg.sender, amount);
        to.transfer(amount);
    }
    
    function spendMoney(address who, uint amount) internal allowedPersonToSpend(amount){
        totalAmountSpent = totalAmountSpent.add(amount);
        deposits[who].totalAmountReceived -= amount;
        deposits[who]._in[deposits[who].numOfDeposits].inAmount = amount;
        deposits[who].numOfDeposits ++;
    }
    
    function receiveMoney(address who, uint amount) internal {
        totalAmountReceived = totalAmountReceived.add(amount);
        payments[who].totalAmountPaid -= amount;
        payments[who]._out[payments[who].numOfPayments].outAmount = amount;
        payments[who].numOfPayments ++;
    }
    
    function receiveMoneyFromDad() public payable {
        emit depositEvent(msg.sender, msg.value);
        receiveMoney(msg.sender, msg.value);
    }
    
    receive() external payable{
        emit depositEvent(msg.sender, msg.value);
        receiveMoney(msg.sender, msg.value);
    }
    
    function destoryTheContract() public onlyOwner(){
        selfdestruct(msg.sender);
    }
}