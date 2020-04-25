pragma solidity ^0.6.6;

library MyMathLibrary{
    
    function add(uint  a, uint  b) public pure returns(uint){
        assert(a + b >= a);
        return a+b;
    }
    
    function sub(uint  a, uint  b) public pure returns(uint){
        assert(a - b <= a);
        return a-b;
    }
}