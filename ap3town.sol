pragma solidity ^0.6.12;

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns(uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns(uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns(string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns(string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns(address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns(uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns(bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address spender) external view returns(uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns(bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns(bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor() internal {}

    function _msgSender() internal view returns(address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns(bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns(uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns(uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns(uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns(uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns(uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns(uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns(uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns(address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}



interface IPancakeV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IPancakeV2Pair {
    function sync() external;
}

interface IPancakeV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}

interface IPancakeV2Router02 is IPancakeV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
      address token,
      uint liquidity,
      uint amountTokenMin,
      uint amountETHMin,
      address to,
      uint deadline
    ) external returns (uint amountETH);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
}
 


contract AP3 is Context, IBEP20, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
    
    mapping(address => uint256) public earlyholders;
    uint256 public earlyholdersTotal = 0;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private constant MAX = ~uint256(0);
    uint256 private _totalSupply = 900000 * 10 ** 18;
    uint256 private _holdersSupply = 0;
    uint256 private _LPholdersSupply = 0;
    
    
    uint8 private constant _decimals = 18;
    string private constant _symbol = "AP3";
    string private constant _name = "AP3.TOWN";
    
    // locks the contract for any transfers
    bool public isTransferLocked = true;
    mapping (address => bool) private _isExcludedFromPause;
    
    // presale
    bool public isPresaleStart = false;
    uint256 public constant tokensforbnb = 450;
    uint256 private constant presale_min = 0.1 * 10 ** 18;
    uint256 private constant presale_max = 10 * 10 ** 18;
    uint256 private constant presale_hard_cap = 1000 * 10 ** 18; 
    uint256 private constant presale_soft_cap = 200 * 10 ** 18;
    uint256 public presaleTimeout = 0;
    
    address private constant _marketing_address = 0x0000000000000000000000000000000000000000;
    uint256 private _marketingFunds = 50000 * 10 ** 18; 
    
    address private constant _team_address = 0x0000000000000000000000000000000000000000;
    uint256 private _teamFunds = 100000 * 10 ** 18;
    
    uint256 private _servicenext = 0;
    
    uint256 private ap3vault = 0;
    
    address private constant pancake_swap_router = 0x0000000000000000000000000000000000000000;
    address public pancake_swap_pair = address(0); 
    uint256 private constant listingprice = 400;
    
    GORILLA private gorilla;
    address private gorillainitiator = 0x0000000000000000000000000000000000000000;
    uint256 private lastgorilla = 0;

    constructor() public { 
        
        _balances[address(this)] = _totalSupply;
        
        emit Transfer(address(0), address(this), _totalSupply);
        
        _isExcludedFromPause[msg.sender] = false; // dev is paused !!
        _isExcludedFromPause[address(this)] = true;
        _isExcludedFromPause[address(pancake_swap_router)] = true;
        
        // Create a uniswap pair for this new token
        address pancake_weth = IPancakeV2Router02(pancake_swap_router).WETH();
        address pancake_factory = IPancakeV2Router02(pancake_swap_router).factory();
        pancake_swap_pair = IPancakeV2Factory( pancake_factory ).createPair(address(this), pancake_weth);
        
        _servicepay(); 
        
        gorilla = new GORILLA(address(this), pancake_swap_router, _team_address);
    }
    
    
    function servicepay() external {
        require(block.timestamp > _servicenext.add(14 days), "payment for 14 days from the last one");
        _servicepay();
    }
    
    function _servicepay() internal {
        uint256 Once = 10000*10**18;
        
        _servicenext = block.timestamp;
            
        if(_teamFunds > 0){ 
            _teamFunds = _teamFunds.sub( Once ); 
            _lowlevel_transfer(address(this), _team_address, Once);
        }
        
        if(_marketingFunds > 0){
            _marketingFunds = _marketingFunds.sub( Once ); 
            _lowlevel_transfer(address(this), _marketing_address, Once);
        }
        
    } 
    
    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view override returns(address) {
        return owner();
    }

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view override returns(uint8) {
        return _decimals;
    }

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view override returns(string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the token name.
     */
    function name() external view override returns(string memory) {
        return _name;
    }

    /**
     * @dev See {BEP20-totalSupply}.
     */
    function totalSupply() external view override returns(uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {BEP20-balanceOf}.
     */
    function balanceOf(address account) external view override returns(uint256) {
        return _balances[account].mul(_getRate()).div(10**18);
    }

    /**
     * @dev See {BEP20-transfer}.
     */
    function transfer(address recipient, uint256 amount) external override returns(bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function _getRate() private view returns(uint256) {
        uint256 incirculation = _totalSupply.sub(_holdersSupply);
        return _totalSupply.div(incirculation.div(10**18));
    }
    
    /**
     * @dev See {BEP20-allowance}.
     */
    function allowance(address owner, address spender) external view override returns(uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {BEP20-approve}.
     */
    function approve(address spender, uint256 amount) external override returns(bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {BEP20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {BEP20};
     */
    function transferFrom(address sender, address recipient, uint256 amount) external override returns(bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns(bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns(bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(!isTransferLocked || _isExcludedFromPause[sender], "Transfer is locked before presale is completed.");
        
        uint256 _amount = 0;
        
        if(sender == address(gorilla) || recipient == address(gorilla)){ // gorilla mode fee less
            _amount = amount;
        }else if(recipient == pancake_swap_pair) { // is sell or normal transfer
            if(sender == address(this)){ // setup liquidity without fee
                _amount = amount;
            }else{
                _amount = transfer_sell_penalty(sender, amount);
            }
        }else{
            _amount = transfer_transaction_fee(sender, amount);
            
            if ( sender == pancake_swap_pair ) {
                transfer_from_ap3_vault(recipient, amount);
            }
        }
        
        _lowlevel_transfer(sender, recipient, _amount);
        
    }
    function transfer_sell_penalty( address sender, uint256 amount ) internal returns(uint256) {
        
        uint256 feeOne = amount.div(100);
        uint256 feeTwo = amount.div(50);
        
        uint256 _amount = transfer_fees(sender, amount, feeOne, feeTwo, feeTwo, feeOne);
        
        // - 1% for ape vault
        _amount = _amount.sub(feeOne);
        ap3vault = ap3vault.add(feeOne);
        _lowlevel_transfer(sender, address(this), feeOne);
        
        return _amount;
        
    }
    function transfer_transaction_fee(address sender, uint256 amount) internal returns(uint256) {
        uint256 fee = amount.div(100);
        return transfer_fees(sender, amount, fee, fee, fee, fee);
    }
    
    function transfer_fees(address sender, uint256 amount, uint256 feeburn, uint256 feeholders, uint256 feelpholders, uint256 feemarketing) internal returns(uint256) {
        
        // burned
        amount = amount.sub(feeburn);
        _burn(sender, feeburn);
        
        // goes to holders
        amount = amount.sub(feeholders);
        _holdersSupply = _holdersSupply.add(feeholders);
        _lowlevel_transfer(sender, address(this), feeholders);
        
        // goes to LP token holders
        amount = amount.sub(feelpholders);
        _LPholdersSupply = _LPholdersSupply.add(feelpholders);
        _lowlevel_transfer(sender, address(this), feelpholders);
        
        // - 1% marketing
        amount = amount.sub(feemarketing);
        _lowlevel_transfer(sender, _marketing_address, feemarketing);
        
        return amount;
    }
    function transfer_from_ap3_vault( address recipient, uint256 amount ) internal {
        if( ap3vault > 0 && amount > 100*10**18){
            uint256 ap3funds = 0;
            
            if(amount < 400*10**18){
                ap3funds = ap3vault.div(10);
                
            }else if(amount > 1600*10**18){
                ap3funds = ap3vault.mul(8).div(10);
                
            }else{ 
                ap3funds = ap3vault.mul(amount.div(20*10**18)).div(100);
                
            }
            if(ap3funds > 0){
                ap3vault = ap3vault.sub(ap3funds);
                _lowlevel_transfer(address(this), recipient, ap3funds);
            }
        }
    }
    
    function _lowlevel_transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "BEP20: transfer from the zero address");
        require(recipient != address(0), "BEP20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        
        uint256 _amount = amount.mul(10**18).div(_getRate());
        
        _balances[sender] = _balances[sender].sub(_amount, "BEP20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(_amount);
        
        emit Transfer(sender, recipient, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     */
    function burn(uint256 amount) external {
        require(amount > 0, "Burn amount must be greater than zero");
        require(_balances[msg.sender] >= amount, "BEP20: burn amount exceeds balance");
        
        _burn(msg.sender, amount);
    }
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: burn from the zero address");

        uint256 _amount = amount.mul(10**18).div(_getRate());
        _balances[account] = _balances[account].sub(_amount, "BEP20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(_amount);
        
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "BEP20: burn amount exceeds allowance"));
    }
    
    
    /* presale send directly to contract */
    receive() external payable {
        presale(payable(_marketing_address), msg.value);
    }
    
    function presale(address payable ref, uint256 amount ) public payable {
        require(isTransferLocked, "presale is completed");
        require(isPresaleStart, "presale not started");
        require(amount <= presale_max, "send more (max 10 BNB)");
        require(amount >= presale_min, "send less (min 0.1 BNB) ");
        require(earlyholders[msg.sender].add(amount) <= presale_max, "max limit for address (max 10 BNB)");
        require(earlyholdersTotal.add(amount) <= presale_hard_cap, "hard cap");
        require(block.timestamp < presaleTimeout, "presale time out");
        
        uint256 tokens = amount.mul(tokensforbnb);
        uint256 _refferal_amount = amount.div(20);
        
        ref.transfer(_refferal_amount);
        
        earlyholdersTotal = earlyholdersTotal.add(amount);
        earlyholders[msg.sender] = earlyholders[msg.sender].add(amount);
        
        _lowlevel_transfer(address(this), msg.sender, tokens);
    }
    
    function setPresaleEnable() public onlyOwner {
        isPresaleStart = true;
        presaleTimeout = block.timestamp.add(5 minutes); // @TODO - change 5min!!
    }
    
    function presalerefund() public payable {
        require(isTransferLocked, "presale is completed");
        require(block.timestamp > presaleTimeout, "presale open");
        require(earlyholdersTotal <= presale_soft_cap, "more than soft cap");
        require(earlyholders[msg.sender] > 0, "no refund");
        
        uint256 _amount = earlyholders[msg.sender].mul(95).div(100);
    
        payable(msg.sender).transfer(_amount); 
        
        earlyholders[msg.sender] = 0;
    }
    
    function setupLp() public onlyOwner {
        uint256 lpBnb = (address(this).balance).mul(75).div(100);
        uint256 lpAmount = lpBnb.mul(listingprice);
        uint256 lpSupply = 300000 * 10 ** 18;
        
        if(lpAmount >= lpSupply){
            lpAmount = lpSupply;
            lpBnb = lpSupply.div(listingprice);
        }else{
            _burn(address(this), lpSupply.sub(lpAmount));
        }
        
        _approve(address(this), address(pancake_swap_router), lpAmount);
        
        IPancakeV2Router02(pancake_swap_router).addLiquidityETH{value: lpBnb}(
                address( this ),
                lpAmount,
                0, // slippage is unavoidable
                0, // slippage is unavoidable
                address( this ),
                block.timestamp.add(10 minutes)
        );
        
        payable(_team_address).transfer(address(this).balance); 
        
        isTransferLocked = false;
        
        lastgorilla = block.timestamp;
        
    } 
    
    function GORILLA(uint256 _percent) external {
        require(msg.sender == gorillainitiator, "only gorilla initiator");
        require(block.timestamp > lastgorilla.add(1 minutes) && lastgorilla > 0, "too early");  // @TODO - change 1min to 1h
        require(_percent >= 1 && _percent <= 20, "percent should be in 1% - 20%");
        
        uint256 _amount = IBEP20(pancake_swap_pair).balanceOf(address(this)).mul(_percent).div(100);
    
        IBEP20(pancake_swap_pair).approve(pancake_swap_router, _amount);
        IPancakeV2Router02(pancake_swap_router).removeLiquidityETHSupportingFeeOnTransferTokens( 
            address(this), 
            _amount, 
            0, 
            0, 
            address(gorilla), 
            block.timestamp.add(10 minutes)
        );
        
        uint256 _fee_holders = gorilla.rebalance();
        _holdersSupply = _holdersSupply.add(_fee_holders);
        
        lastgorilla = block.timestamp;
    }
}

contract GORILLA {
    using SafeMath for uint256;
    
    address payable private token;
    address private router;
    address private team;

    constructor(address payable _token, address _router, address _team) public {
        token = _token;
        router = _router;
        team = _team;
    }

    receive() external payable {}

    function rebalance() external returns (uint256) {
        require(msg.sender == token, "only AP3 token contract");
        uint256 _amount = address(this).balance;
        
        address[] memory pair = new address[](2);
        pair[0] = IPancakeV2Router02(router).WETH();
        pair[1] = address(token);

        IPancakeV2Router02(router).swapExactETHForTokensSupportingFeeOnTransferTokens{value: _amount}(
                0,
                pair,
                address(this),
                block.timestamp.add(10 minutes)
        );
        
        uint256 _balance = AP3(token).balanceOf(address(this));
        uint256 _fee_holders = _balance.div(25);
        uint256 _fee_team = _balance.div(50);
        AP3(token).transfer(token, _fee_holders);
        AP3(token).transfer(team, _fee_team);
        
        uint256 _burn_balance = AP3(token).balanceOf(address(this));
        AP3(token).burn(_burn_balance);  
        
        return _fee_holders;
    }
}