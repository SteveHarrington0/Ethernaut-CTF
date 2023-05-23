pragma solidity 0.8.9;

contract FalloutInterface{
    function callmethids(address _contract) public payable {
        (bool success,) = _contract.call{value : msg.value}(abi.encodeWithSignature("Fal1out()"));
        require(success);
    }
}