//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UnburnableToken{
    mapping(address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;

    constructor(){
        totalSupply = 100000000;
    }

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    function claim() public{
        if(totalClaimed < totalSupply){
            if(balances[msg.sender]  == 0){
                balances[msg.sender] += 1000;
                totalClaimed += 1000;
            }

            else{
                revert TokensClaimed();
            }            
        }

        else{
            revert AllTokensClaimed();
        }
    }
    

    function safeTransfer(address _to, uint _amount) public{
        if(_to == address(0) || _to.balance == 0){
            revert UnsafeTransfer(_to);
        }
        else{
            require(balances[msg.sender] > _amount, "Insufficient Balance");
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
        }

    }
}