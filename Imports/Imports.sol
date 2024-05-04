// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./SillyStringUtils.sol";

contract ImportsExercise{
    using SillyStringUtils for SillyStringUtils.Haiku;
    SillyStringUtils.Haiku public haiku;

    function saveHaiku (string memory _line1, string memory _line2, string memory _line3) external{
        haiku.line1 = _line1;
        haiku.line2 = _line2;
        haiku.line3 = _line3;
    }

    function getHaiku() external view returns(SillyStringUtils.Haiku memory){
        return haiku;
    }

    function shruggieHaiku() external view returns(SillyStringUtils.Haiku memory){
        string memory line1 = haiku.line1;
        string memory line2 = haiku.line2;
        string memory line3 = SillyStringUtils.shruggie(haiku.line3);
        SillyStringUtils.Haiku memory modHaiku = SillyStringUtils.Haiku(line1, line2, line3);
        return modHaiku;
    }


}
