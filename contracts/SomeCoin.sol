// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SomeCoin is ERC20{
    address public owner;
    constructor() ERC20("SomeCoin","SCN"){
        owner = msg.sender;
        _mint(msg.sender,10*10**decimals());
    }

    function mint(address account, uint amount) external{
        // require(account==owner,"Unauthorized");
        _mint(account,amount);
    }
}