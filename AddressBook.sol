//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract AddressBook is Ownable{
    constructor(address _owner) Ownable(_owner){
    }
    struct Contact{
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    Contact[] public contacts;
    bytes empty = bytes("");
    Contact[] nonDeleted;

    function addContact(uint _id, string calldata _firstName,
    string calldata _lastName, uint[] memory _phoneNumbers) external onlyOwner{
        contacts.push(Contact(_id, _firstName, _lastName, _phoneNumbers));
        delete nonDeleted;
        updateContacts();

    } 

    error ContactNotFound(uint _id);

    function deleteContact(uint _id)external onlyOwner{
        for(uint i=0; i <= contacts.length - 1; i++){
            if(contacts[i].id == _id){
                delete contacts[i];
                break;
            }
            if(i == contacts.length - 1){
                revert ContactNotFound(_id);
            }

        }
        delete nonDeleted;
        updateContacts();
    } 


    function getContact(uint _id) external view returns(Contact memory contact){
         for(uint i=0; i <= contacts.length - 1; i++){
            if(contacts[i].id == _id){
                contact = contacts[i];
                break;
            }
            if(i == contacts.length - 1){
                revert ContactNotFound(_id);
            }
    }
}

    function updateContacts() internal{
        for(uint i=0; i <= contacts.length - 1; i++){
        if(contacts[i].id != 0 && keccak256(bytes(contacts[i].firstName)) != keccak256(empty)
             && keccak256(bytes(contacts[i].lastName)) != keccak256(empty) && contacts[i].phoneNumbers.length != 0){
            nonDeleted.push(contacts[i]);
             }
    }
}


    function getAllContacts() external view returns(Contact[] memory){
        return nonDeleted;
        
    }

}

contract AddressBookFactory {
    function deploy() external returns(address){
        AddressBook newAddressBook = new AddressBook(msg.sender);
        return address(newAddressBook);
    }
}