pragma solidity ^0.6.3;

contract Owned {
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender, "You are not allowed, only the Owner can!");
        _;
    }
}

contract ArraySimpleLibraries is Owned{
    
    uint[] public myInternalArray;//behaves like a dynamic array - vector;
    
    function addElementToArray(uint val) public{//add a last element and incrase size by one
        myInternalArray.push(val);
    }
    
    function removeElemenetFromArray() public onlyOwner{//remove last element added
        myInternalArray.pop();
    }
    
    function getMyArraySize() public view returns (uint) {
        return myInternalArray.length;
    }
    
    function getElementAt(uint index) public view returns (uint){
        require(myInternalArray.length > 0, "Array Is Empty");
        require(myInternalArray.length > index, "Invalid Index");
        return myInternalArray[index];
    }           
        
    function findIndexOfElement_(uint val) public view returns (uint) {
        for(uint i=0; i<myInternalArray.length; i++){
            if(myInternalArray[i] == val){
                return i;
            }
        }
        return myInternalArray.length;
    }
    
    
    function replaceSpecificElementExternal(uint elemToReplace, uint newElem) external{        
        uint indexOfElemToReplace = findIndexOfElement_(elemToReplace);
        if(indexOfElemToReplace == myInternalArray.length){            
            revert("The element does not exist");
        }
        myInternalArray[indexOfElemToReplace] = newElem;
    }
}

contract MyArray{
    
    event ElementReplaced(address from, uint elementReplaced, uint newElement) ;
    event ErrorInElementReplaced(string reason) ;
    event ElementAdded(address from, uint newElement) ;
    
    ArraySimpleLibraries myExtArray = new ArraySimpleLibraries();
    
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
        return myExtArray.findIndexOfElement_(val);
    }
    
    function replace(uint elemToReplace, uint newElem) public{
        try myExtArray.replaceSpecificElementExternal(elemToReplace, newElem){
            emit ElementReplaced(msg.sender, elemToReplace, newElem);
        }catch Error(string memory reason){
            emit ErrorInElementReplaced(reason);
        }
    }
}
