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

    // Add a new car to the garage of transacting user
    function addCar(string calldata _make, string calldata _model, string calldata _color, uint _numberOfDoors) external{
        Car memory newCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(newCar);
    }

    // return cars owned by transacting user
    function getMyCars() external view returns(Car[] memory){
        return garage[msg.sender];
    }

    // Take address of any user and return the cars in their garage
    function getUserCars(address _user) external view returns(Car[] memory){
        return garage[_user];
    }

    // Update a car in the garage
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

    // Reset user garage
    function resetMyGarage() external{
        delete garage[msg.sender];
    }

}
