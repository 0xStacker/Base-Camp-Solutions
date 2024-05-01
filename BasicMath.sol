// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract BasicMath{
    function adder(uint _a, uint _b) public pure returns(uint, bool){
        uint result;
        unchecked{
           result = _a + _b;
        }

        if(result > _a && result > _b){
            return(result, false);
        }

        else{
            return(0, true);
        }
    }
    
    function subtractor (uint _a, uint _b) public pure returns(uint, bool){
        uint result;
        if(_b > _a){
            result = 0;
            return(result, true);
        }
        else{
            result = _a - _b;
            return(result, false);
        }
}
}