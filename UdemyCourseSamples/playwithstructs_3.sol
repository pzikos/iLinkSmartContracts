pragma solidity ^0.6.6;
//series 3
contract playwithstructs{
    
    struct Payment{
        uint amount;
        uint timastamp;
    }
    
    struct Balance{
        uint totalBalance;
        uint numPayemts;
        mapping (uint => Payment) payments;
    }
    
    mapping(address => Balance) public balanceReceived;
  
    function getBalanceReceive() public view returns (uint){
        return balanceReceived[msg.sender].totalBalance;
    }
    
    function sendMondey() payable public {
        Payment memory payment = Payment(msg.value, now);
        assert(balanceReceived[msg.sender].totalBalance + msg.value >= balanceReceived[msg.sender].totalBalance);//avoid overfloating
        balanceReceived[msg.sender].totalBalance += msg.value;
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayemts] = payment;
        balanceReceived[msg.sender].numPayemts++;
    }
    
    function withdrawAllMoney(address payable _to) public {
        uint balancaceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balancaceToSend);
    }
    
    function withdrawAmountOfMoney(address payable to, uint amount) public {
        uint balanceTotal = balanceReceived[msg.sender].totalBalance;
        require(amount <= balanceTotal, "Not enough balance");
        assert(balanceReceived[msg.sender].totalBalance >= balanceReceived[msg.sender].totalBalance - amount);
        balanceReceived[msg.sender].totalBalance -= amount;
        to.transfer(amount);
    }
}