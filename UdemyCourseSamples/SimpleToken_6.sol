pragma solidity ^0.6.6;

import "./Owned_5.sol";  //import file

contract SimpleToken is Owned{//is inherits
    
    uint tokenValue = 1 ether;
    mapping(address => uint) public balances;
    
    
    event TokenTransfered(address from, address to, uint amount);
    //events can be used as returv values of a transaction to the outside world
    //as triggers to the external world, imagine you need two approvals for a withdrawal of money
    //as data storage because storing data in the bc is very expensive
    
    constructor() public {
        balances[owner] = 100;
    }
    
    function createToken() public onlyOwner {//the modifier does the control
        balances[owner]++;
    }
    
    function burnToken() public onlyOwner {//the modifier does the control
        balances[owner]--;
    }
    
    function purchaseToken() public payable{
        require((balances[owner] * tokenValue) / msg.value > 0, "Not Enough Tokens To Buy");
        uint tokensToBuy =  msg.value / tokenValue;
        balances[owner] -=  tokensToBuy;
        balances[msg.sender] +=  tokensToBuy;
    }
    
    function transferToken(address to, uint amount) public{
        require(balances[msg.sender] - amount > 0, "Not enough tokens");
        assert(balances[msg.sender] - amount <= balances[msg.sender]);
        assert(balances[to] + amount >= balances[to]);
        balances[to] += amount;
        balances[msg.sender] -= amount;
        
        emit TokenTransfered(msg.sender, to, amount);//emit an event to notofy the outside world that a transaction was done for a transfer. the data is in the payload.
        //usually external dApps register for events as a way to initate a transaction towards to the blockchain
        //or in order to receive value from a contract function (there is no return value you need to send data from an event)
        //you can have up to 3 indexed parameters and these are hashed on the blockchain and you can search for them in the past
        //events is a good way of sending strings to the out workd because it is too expensive to store them in the chain
    }
    
}