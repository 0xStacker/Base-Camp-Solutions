// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GarageManager{

    error BadCarIndex(uint _index);
    mapping(address => Car[]) public garage;  

    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }


    function addCar(string calldata _make, string calldata _model, string calldata _color, uint _numberOfDoors) external{
        Car memory newCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(newCar);
    }

    function getMyCars() external view returns(Car[] memory){
        return garage[msg.sender];
    }

    function getUserCars(address _user) external view returns(Car[] memory){
        return garage[_user];
    }


    function updateCar(uint _index, string calldata _make, string calldata _model,
     string calldata _color, uint _numberOfDoors) external {
        if(garage[msg.sender].length - 1 >= _index){
            Car memory update = Car(_make, _model, _color, _numberOfDoors);
            garage[msg.sender][_index] = update;
        }
        else{
            revert BadCarIndex(_index);
        } 

     }


    function resetMyGarage() external{
        delete garage[msg.sender];
    }

}