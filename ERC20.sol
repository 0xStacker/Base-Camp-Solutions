// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol";

/*
See problem at https://docs.base.org/base-camp/docs/erc-20-token/erc-20-exercise/
*/

contract WeightedVoting is ERC20{
    uint public maxSupply = 1000000 * 10**18;
    uint internal totalClaimed;
    mapping(address => bool) public claimed;
    uint index = 0;

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint _quoromProposed);
    error AlreadyVoted();
    error VotingClosed();
    using EnumerableSet for EnumerableSet.AddressSet;

    struct Issue{
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }


    struct _ReturnableIssue{
        address[] voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }


    Issue[] internal issues;
    _ReturnableIssue[] internal returnableIssues;
    enum Vote {
        AGAINST, FOR, ABSTAIN}

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol){
        // delete issues[0];
    }

// Allow users to claim 100 tokens only once

     function claim() external{
        if(totalClaimed < maxSupply){
            if(claimed[msg.sender] == false){
                _mint(msg.sender, 100);
                totalClaimed += 100;
                claimed[msg.sender] = true;
            }

            else{
                revert TokensClaimed();
            }            
        }

        else{
            revert AllTokensClaimed();
        }
    }

// Allow token holders to create an issue
    function createIssue(string memory _issueDesc, uint _quorum) external returns(uint){
        if (balanceOf(msg.sender) == 0){
            revert NoTokensHeld();
        }
        issues.push();
        issues[index].issueDesc = _issueDesc;
        returnableIssues.push();
        returnableIssues[index].issueDesc = _issueDesc;

        if(_quorum > totalClaimed){
            revert QuorumTooHigh(_quorum);
        }
        issues[index].quorum = _quorum;
        returnableIssues[index].quorum = _quorum;
        uint _index = index;
        index += 1;
        return _index;

    }


    function getIssue(uint _id) external view returns(_ReturnableIssue memory){
         return returnableIssues[_id];
    }

// Allow token holders to vote on open issues
    function vote(uint _issueId, Vote _vote) external{
        if (balanceOf(msg.sender) == 0){
            revert NoTokensHeld();
        }
        if(issues[_issueId].closed){
            revert VotingClosed();
        }
        else if(issues[_issueId].voters.contains(msg.sender)){
            revert AlreadyVoted();
        }
        if(_vote == Vote.AGAINST){
            issues[_issueId].votesAgainst += 100;
            returnableIssues[_issueId].votesAgainst += 100;
        }
        else if(_vote == Vote.FOR){
            issues[_issueId].votesFor += 100;
            returnableIssues[_issueId].votesFor += 100;
        }
        else{
            issues[_issueId].votesAbstain += 100;
            returnableIssues[_issueId].votesAbstain += 100;
        }

        issues[_issueId].totalVotes += 100;
        issues[_issueId].voters.add(msg.sender);
        returnableIssues[_issueId].voters.push(msg.sender);
        returnableIssues[_issueId].totalVotes += 100;

        if (issues[_issueId].totalVotes >= issues[_issueId].quorum){
            issues[_issueId].closed = true;
            returnableIssues[_issueId].closed = true;

            if (issues[_issueId].votesFor > issues[_issueId].votesAgainst){
                issues[_issueId].passed = true;
                returnableIssues[_issueId].passed = true;

            }
        } 

        }


    }

