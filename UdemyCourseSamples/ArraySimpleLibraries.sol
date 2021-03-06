pragma solidity ^0.6.3;

import "./SimpleLibrary.sol";
import "./Owned.sol";

contract ArraySimpleLibraries is Owned{
    
    using SimpleLibrary for uint[]; //declare that we will use the abobe library for all arrays
    uint[] public myArray;//behaves like a dynamic array - vector;
    
    function addElementToArray(uint val) public{//add a last element and incrase size by one
        myArray.push(val);
    }
    
    function removeElemenetFromArray() public onlyOwner{//remove last element added
        myArray.pop();
    }
    
    function getMyArraySize() public view returns (uint) {
        return myArray.length;
    }
    
    function getElementAt(uint index) public view returns (uint){
        bool validationPassed = false;
        if(myArray.length == 0){
            require(validationPassed, "Array Is Empty");
        }
        if(index == 0){
            validationPassed = true;
        }else{
            if(myArray.length - 1 >= index){
                validationPassed = true;
            }
            
        }
        require(validationPassed, "Invalid Index");
        return myArray[index];
    }
    
    function findIndexOfElement(uint val) public view returns (uint) {
        return myArray.searchIndexOfVal(val);
    }
    
    
    function replaceSpecificElementExternal(uint elemToReplace, uint newElem) external{
        uint indexOfElemToReplace = myArray.searchIndexOfVal(elemToReplace);
        if(indexOfElemToReplace == myArray.length){
            //return false;
            revert("The element does not exist");
        }
        myArray[indexOfElemToReplace] = newElem;
    }
}
