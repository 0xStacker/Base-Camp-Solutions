//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Employee{
    uint public idNumber;
    uint public managerId;

    function getAnnualCost() virtual external returns(uint);
}

contract Salaried is Employee {
    uint public annualSalary;
    function getAnnualCost() override (Employee) external view returns(uint){
        return annualSalary;
    }
}


contract Hourly is Employee{
    uint public hourlyRate;
    function  getAnnualCost() override  external view returns(uint){
     return hourlyRate * 2080;   
    }
    
}



contract Manager {
    uint[] employeeIds;
    function addReport(uint _id) external{
        employeeIds.push(_id);
    }

    function resetReports() external{
        delete employeeIds;
    }

}


contract Salesperson is Hourly{
    constructor(uint _hourlyRate, uint _idNumber, uint _managerId){
        hourlyRate = _hourlyRate;
        idNumber = _idNumber;
        managerId = _managerId;
    }
}

contract EngineeringManager is Salaried, Manager{
    constructor(uint _idNumber, uint _managerId, uint _annualSalary){
    idNumber = _idNumber;
    managerId = _managerId;
    annualSalary = _annualSalary;
    }
    
}



contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
