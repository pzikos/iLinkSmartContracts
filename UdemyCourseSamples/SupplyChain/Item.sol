pragma solidity ^0.5.17;

import "./ItemManager.sol";

contract Item {
    ItemManager parent;
    uint public price;
    uint public amountReceived;
    uint  serialNo;
    string  description;
    
    constructor(ItemManager _parent, uint _price, uint _serialNo, string memory _description) public {
        parent = _parent;
        price = _price;   
        serialNo = _serialNo;
        description = _description;
    }
    
    /*
    receive() external payable {
        require(amountReceived == 0, "Item Has Already Benn Paid");
        require(price == msg.value, "Partial Payment Not Supported");
        bool itemPaid = parent.buyItem(serialNo);
        //(bool result, ) = address(parent).call.value(msg.value)(abi.encodeWithSignature("transportItem(uint256)", serialNo));
        require(itemPaid, "Item Not Properly Paid");
        //require(result, "Item Not Properly Paid");
        amountReceived += msg.value;
    }
    */
    
    function buyItem() public payable {
        require(amountReceived == 0, "Item Has Already Benn Paid");
        require(price == msg.value, "Partial Payment Not Supported");
        bool itemPaid = parent.buyItem(serialNo);
        require(itemPaid, "Item Not Properly Paid");
        amountReceived += msg.value;
    }
    
    function getSerialNo() public view returns (uint){
        return serialNo;
    }
    
    function getDescription() public view returns (string memory){
        return description;
    }
    
}