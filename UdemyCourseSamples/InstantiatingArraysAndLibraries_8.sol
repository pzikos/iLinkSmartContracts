pragma solidity ^0.6.6;

import "./ArraysAndLibraries_7.sol";

contract MyArray{
    
    event ElementReplaced(address from, uint elementReplaced, uint newElement) ;
    event ErrorInElementReplaced(string reason) ;
    event ElementAdded(address from, uint newElement) ;
    
    ArraysLibraries myExtArray = new ArraysLibraries();
    
    function add(uint val) public{//add a last element and incrase size by one
       myExtArray.addElementToArray(val);
       emit ElementAdded(msg.sender, val);
    }
    
    function remove() public{//remove last element added
        myExtArray.removeElemenetFromArray();
    }
    
    function size() public view returns (uint) {
        return myExtArray.getMyArraySize();
    }
    
    function get(uint index) public view returns (uint){
        return myExtArray.getElementAt(index);
    }
    
    function indexOf(uint val) public view returns (uint) {
        return myExtArray.findIndexOfElement(val);
    }
    
    function replace(uint elemToReplace, uint newElem) public{
        try myExtArray.replaceSpecificElementExternal(elemToReplace, newElem){
            emit ElementReplaced(msg.sender, elemToReplace, newElem);
        }catch Error(string memory reason){
            emit ErrorInElementReplaced(reason);
        }
    }
}