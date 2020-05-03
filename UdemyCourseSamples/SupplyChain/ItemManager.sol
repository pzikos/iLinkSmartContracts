pragma solidity ^0.5.17;

import "./Item.sol";
import "./ItemOwnable.sol";
import "./SimpleMath.sol";

contract ItemManager is ItemOwnable{

    using SimpleMath for uint;
    
    enum ItemStatus{Created, Paid, Transported}
    uint serialNo = 1;
    
    event ItemStatusChanged(uint itemSerialNo, uint itemStatus, address itemAddress);
    
    struct ItemStruct{
        Item item;
        ItemManager.ItemStatus status;
        string identifier;
    }
    
    mapping(uint => ItemStruct) public items; 
    
    function createItem(string memory _identifier, uint price) public OnlyOwner {
        Item item = new Item(this, price, serialNo, _identifier);
        items[serialNo].item = item;
        items[serialNo].status = ItemStatus.Created;
        items[serialNo].identifier = _identifier;
        emit ItemStatusChanged(serialNo, uint(items[serialNo].status), address(item));
        serialNo++;
    }
    
    function buyItem(uint itemSerialNo) public payable returns (bool) {
        Item item = getItem(itemSerialNo);
        require(address(item) == msg.sender, "Only Item Can Invoke buyItem");
        ItemStruct storage itemStruct = items[item.getSerialNo()];
        require(itemStruct.status == ItemStatus.Created, "Item Not For Sale");
        itemStruct.status = ItemStatus.Paid;
        emit ItemStatusChanged(item.getSerialNo(), uint(itemStruct.status), address(item));
        return true;
    }

	/*
    function buyItemDirectly(uint itemSerialNo) public payable returns (bool) {
        Item item = getItem(itemSerialNo);
        require(!item.getIteBought() && item.getAmountReceived().compare(0), "Item Already Bought");
        require(item.getPrice().compare(msg.value), "Not Enough Money to Buy This Item");
        ItemStruct storage itemStruct = items[item.getSerialNo()];
        require(itemStruct.status == ItemStatus.Created, "Item Not For Sale");
        itemStruct.status = ItemStatus.Paid;
        item.setIteBought(true);
        emit ItemStatusChanged(item.getSerialNo(), uint(itemStruct.status), address(item));
        item.setAmountReceived(item.getAmountReceived().add(msg.value));
        return true;
    }
	*/
    
    function transportItem(uint itemSerialNo) public OnlyOwner {
        Item item = getItem(itemSerialNo);
        require(items[itemSerialNo].status == ItemStatus.Paid, "Item Not For Transport");
        ItemStruct storage itemStruct = items[item.getSerialNo()];
        itemStruct.status = ItemStatus.Transported;
        emit ItemStatusChanged(item.getSerialNo(), uint(itemStruct.status), address(item));
    }
    
    function getItem(uint _serialNo) public view returns (Item){
        return items[_serialNo].item;
    }
    
    function getItemName(uint _serialNo) public view returns (string memory){
        return items[_serialNo].item.getDescription();
    }

}