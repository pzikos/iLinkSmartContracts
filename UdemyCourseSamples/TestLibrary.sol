pragma solidity ^0.6.3;

library TestLibrary { //just like a contract but with no state variables, many openzeppelin libs out there
    
    function searchIndexOfVal(uint[] storage theArray, uint whatToFind) public view returns (uint){//no state, so only view
        for(uint i=0; i<theArray.length; i++){
            if(theArray[i] == whatToFind){
                return i;
            }
        }
        return theArray.length;
    }
}
