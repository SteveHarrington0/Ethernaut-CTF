pragma solidity 0.8.9;

contract reenter{
    mapping(uint => bool) public somethong;

    function setmap() public {
        somethong[10] = true;
    }

    function returnmapping() public{
        delete somethong[10];
    }
}