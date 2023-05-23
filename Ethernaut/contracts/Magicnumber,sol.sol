// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MagicNum {

  address public solver;

  constructor() {}

  function setSolver(address _solver) public {
    solver = _solver;
  }

}

contract Factory{

    MagicNum instance = MagicNum(0xFF052C21B8fc518fE30047d2dEcf1103a24cEfB9);
    event logs (address solver);
    function createContract() public {
        address addr;
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3"; //19 bytes in hex 13
        assembly{
            addr := create(0,add(bytecode,0x20),0x13)
        }
        emit logs(addr);

    }
}

interface check{
    function getMeaningOfLife() external view returns(uint);
}