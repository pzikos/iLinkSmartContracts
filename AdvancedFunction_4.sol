//series 4 
pragma solidity ^0.6.6;

contract AdvancedFunction{
    mapping(address=> uint) public balances;
    
    function receiveMoney() public payable {
        assert(balances[msg.sender] + msg.value >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
    }
    
    function withDrawMoney(address payable to, uint val) public {
        uint valInEther = convertWeiToEther(val);
        require(balances[msg.sender] >= valInEther, "not enough ethers");
        assert(balances[msg.sender] - valInEther <= balances[msg.sender]);
        balances[msg.sender] -= valInEther;
        to.transfer(val);
    }
    
    receive () external payable {//default function for allowing this contract recieve ether witouht the need to call a function. NOT used as a fallback function anymore
        receiveMoney();
    }
    
    function getBalanceOfAddress(address adr) public view returns (uint) {//only view the state, no interaction with the state, cannopt call other writing functions but only view functions
        return balances[adr];
    }
    
    function convertWeiToEther(uint weiAmount) public pure returns (uint) {//not accessing the state variables at all, something like util functions. 
        return weiAmount / 1 ether;
    }
    
    //writing functions call every functions
    //view call only view and pure
    //pure call only pure
    //external functions can only be called by ohter contracts. Publi, Private are normal, Interal are like protected.
    //fallback function  automatically execute without the need to call contract function or when the called function does not exist (misspelling), like a default function. Cannot take ether!
}