pragma solidity ^0.6.4;

library SimpleMath {

    function add(uint val1, uint val2) public pure returns (uint){
        return val1 + val2;
    }

    function compare(uint val1, uint val2) public pure returns (bool){
        return val1 == val2;
    }
}