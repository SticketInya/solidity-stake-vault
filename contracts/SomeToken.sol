pragma solidity >=0.7.0 <0.9.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract SomeToken is IERC20{
    string public name;
    string public symbol;
    uint public decimals = 18;
    uint private _totalSupply;
    address public owner;

    mapping(address=>uint) private _balances;

    mapping(address => mapping(address => uint)) private _allowances;

    // event Transfer(address indexed from, address indexed to, uint value);
    // event Approval(address indexed owner, address indexed spender, uint value);

    constructor(uint initalSupply, string memory name_, string memory symbol_){
        _totalSupply = initalSupply * 10**decimals;
        _balances[msg.sender] = _totalSupply;
        name = name_;
        symbol = symbol_;
        owner = msg.sender;
    }
    
    function mint(address to, uint amount) external{
        require(owner==msg.sender,"Unauthorized");
        _totalSupply += amount;
        _balances[to] += amount;
    }

    function totalSupply() external virtual override view returns(uint){
        return _totalSupply;
    }

    function balanceOf(address account) external virtual override view returns(uint){
        return _balances[account];
    }

    function transfer(address to, uint amount) external virtual override returns(bool){
        _transfer(msg.sender,to,amount);
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) external virtual override view returns(uint){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint amount) external virtual override returns (bool){
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    function transferFrom( address from, address to, uint amount) external virtual override returns (bool){
        require(_allowances[from][msg.sender]>=amount,"Insufficient allowance");
        _allowances[from][msg.sender] -= amount;
        _transfer(from,to,amount);
        emit Transfer(from, to, amount);
        return true;
    }

    function _transfer(address from, address to, uint amount) internal virtual{
        require(_balances[from]>=amount,"Insufficient funds");
        _balances[from] -= amount;
        _balances[to] += amount;
    }

   
}