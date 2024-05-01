// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract EmployeeStorage{
    uint16 private shares;
    uint32 private salary;
    uint public idNumber;
    string public name;

    error TooManyShares(uint _share);

    constructor(uint16 _shares, string memory _name, uint32 _salary, uint _idNumber){
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }


    function viewSalary() public view returns(uint32){
        return salary;
    }

    function viewShares() public view returns(uint16){
        return shares;
    }

    function grantShares(uint16 _newShare) public{
        if(_newShare > 5000){
            revert("Too many shares");
        }

        if(uint(shares) + _newShare > 5000){
            revert TooManyShares(shares + _newShare);
        }

        shares += _newShare;
    }

    /**
* Do not modify this function.  It is used to enable the unit test for this pin
* to check whether or not you have configured your storage variables to make
* use of packing.
*
* If you wish to cheat, simply modify this function to always return `0`
* I'm not your boss ¯\_(ツ)_/¯
*
* Fair warning though, if you do cheat, it will be on the blockchain having been
* deployed by your wallet....FOREVER!
*/
function checkForPacking(uint _slot) public view returns (uint r) {
    assembly {
        r := sload (_slot)
    }
}

/**
* Warning: Anyone can use this function at any time!
*/
function debugResetShares() public {
    shares = 1000;
}


}