// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./SomeCoin.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract StakingVault{

    SomeCoin public parentCoin;

    struct Stake {
        uint amount;
        uint timestamp;        
    }

    mapping(address=>Stake) public stakes;
    
    constructor(){
        parentCoin = SomeCoin(0xaE036c65C649172b43ef7156b009c6221B596B8b);
    }


    function deposit(uint amount) external{
        stakes[msg.sender] = Stake(amount,block.timestamp);
        parentCoin.transferFrom(msg.sender,address(this), amount);
    }

    function withdraw() external{
        uint minutesStaked = (block.timestamp - stakes[msg.sender].timestamp)/60;
        parentCoin.mint(address(this),minutesStaked);
        uint reward = (minutesStaked * 90)/100;
        parentCoin.transfer(msg.sender,(stakes[msg.sender].amount + reward));
        delete stakes[msg.sender];
    }
}