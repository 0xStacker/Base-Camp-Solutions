// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    uint[] public timestamps;
    address[] public senders;
    uint[] private recentTimestamps;
    address[] private recentAddresses;

    // funtion to return numbers array
    function getNumbers() external view returns(uint[] memory){
        return numbers;
    }

    // Reset numbers array
    function resetNumbers() external {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    // Append the elements in a given array to numbers
    function appendToNumbers(uint[] calldata _toAppend) external {        
        for(uint i=0; i < _toAppend.length; i++){
            numbers.push(_toAppend[i]);
        }
    }

    /* save unix timestamp; If the time stamp is more recent than January 1, 2000, 12:00am, add it to an array and match it 
    with sender address on another array*/

    function saveTimestamp(uint _unixTimestamp) external {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
         if(_unixTimestamp > 946702800){
                recentTimestamps.push(_unixTimestamp);
                recentAddresses.push(msg.sender);
            }
    }


    // return timestamps more recent than January 1, 2000, 12:00am
    function afterY2K() external view returns(uint[] memory, address[] memory){
        return(recentTimestamps, recentAddresses);

    }
    
    // clear senders array
    function resetSenders() external{
        delete senders;
    }

    // clear timestamp array
    function resetTimestamps() external{
        delete timestamps;
    }
}
