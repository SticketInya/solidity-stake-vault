pragma solidity >=0.7.0 <0.9.0;


contract DemoWallet{
    address public owner;
    event Log(string message, uint256 amount);
    event LogSend(string message, address _to, uint amount);
    constructor(){
         owner = msg.sender;
    }

    receive() external payable{}

    function withDraw(uint256 amount) external{
        require(msg.sender == owner,"Unauthorized!");
        payable(msg.sender).transfer(amount);
        emit Log("Withdrawn", amount);
    }

    function sendTo(address payable _to, uint amount) external{
        _to.transfer(amount);
        emit LogSend("Sent coin!",_to,amount);
    }

    function logBalance() external{
        emit Log("Current balance",address(this).balance);
    }
}