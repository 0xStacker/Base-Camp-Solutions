//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract HaikuNft is ERC721{
    struct Haiku{
        address author;
        string line1;
        string line2;
        string line3;
    }

    mapping(uint => Haiku) haikus;
    uint public _counter = 1;
    mapping(address => Haiku[]) public sharedHaikus;
    mapping(string => bool) isPresent;
    error HaikuNotUnique();
    
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){
    }

    function counter() external view returns (uint){
        return _counter;
    }
    
    function mintHaiku(string memory _line1, string memory _line2, string memory _line3) external{
        if(isPresent[_line1] == true || isPresent[_line2] == true || isPresent[_line3] == true){
         revert HaikuNotUnique();
        }
        else{
            haikus[_counter] = Haiku(msg.sender,_line1, _line2, _line3);
            isPresent[_line1] = true;
            isPresent[_line2] = true;
            isPresent[_line3] = true;
            _safeMint(msg.sender, _counter);
            _counter ++;
           
        }

    }

    error NotYourHaiku(uint _id);

    function shareHaiku(uint _id, address _to) external{
        if(ownerOf(_id) == msg.sender){
            sharedHaikus[_to].push(haikus[_id]);
        }
        else{
            revert NotYourHaiku(_id);
        }
    }

    error NoHaikusShared();

    function getMySharedHaikus() external view returns(Haiku[] memory){
        if(sharedHaikus[msg.sender].length == 0){
            revert NoHaikusShared();
        }
        return sharedHaikus[msg.sender];
    }


}