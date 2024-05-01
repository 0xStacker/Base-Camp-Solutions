// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    mapping(string => bool) approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;
    string[] approvedKeys = ["Thriller", "Back in Black", "The Bodyguard", "The Dark Side of the Moon",
     "Their Greatest Hits (1971-1975)", "Hotel California", "Come On Over", "Rumours", "Saturday Night Fever"];
    mapping(address => string[]) _userFavorites;
    // load approvedRecords
    constructor(){
        for(uint i=0; i < approvedKeys.length; i++){
            approvedRecords[approvedKeys[i]] = true;
        }    
    }

    error NotApproved(string albumName);

    // return approved records
    
    function getApprovedRecords() external view returns(string[] memory records){
        records = approvedKeys;
    }

    // add approved record to user favorite

    function addRecord(string memory _albumName) external{
        if(approvedRecords[_albumName]){
            userFavorites[msg.sender][_albumName] = true;
            _userFavorites[msg.sender].push(_albumName);
        }
        else{
            revert NotApproved(_albumName);
        }

    }

    function getUserFavorites(address _address) external view returns(string[] memory){
        
        // for(uint i=0; i < approvedKeys.length; i++){
        //     string memory item = approvedKeys[i];
        //     if(userFavorites[_address][item] == true){
        //         _userFavorites.push(item);
        //     }
        // }
        return _userFavorites[_address]; 
         
    }

    function resetUserFavorites() external{
       string[] memory favs = _userFavorites[msg.sender];
        for(uint i=0; i < favs.length; i++){
            delete userFavorites[msg.sender][favs[i]];
        }      
}

}