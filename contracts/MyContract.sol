pragma solidity >=0.4.22 <0.8.0;
pragma experimental ABIEncoderV2;

contract MyContract {
    uint8 private clientCount;
    mapping(address => uint256) private balances;
    address public owner;
    uint256 thresold;
    string regulator;
    string waring;
    // Log the event about a deposit being made by an address and its amount
    event LogDepositMade(address indexed accountAddress, uint256 amount);

    // Constructor is "payable" so it can receive the initial funding of 30,
    // required to reward the first 3 clients
    constructor() public payable {
        /* Set the owner to the creator of this contract */

        owner = msg.sender;
        thresold = 10;
        clientCount = 0;
        waring = "alert alert!!!";
    }

    function enroll() public returns (uint256) {
        if (clientCount < 3) {
            clientCount++;
            balances[msg.sender] = 10 ether;
        }
        return balances[msg.sender];
    }

    /// @notice Deposit ether into bank, requires method is "payable"
    /// @return The balance of the user after the deposit is made
    function deposit1() public payable returns (uint256) {
        // require(withdrawAmount < 10, "thresold value crossed !!!!");
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function deposit(uint256 withdrawAmount)
        public
        returns (string memory msg1)
    {
        // Check enough balance available, otherwise just return balance
        require(
            withdrawAmount < 1000,
            "Thresold limit of 50 crossed not possible to proceed !!!!"
        );
        if (withdrawAmount <= balances[msg.sender]) {
            balances[msg.sender] -= withdrawAmount;
            msg.sender.transfer(withdrawAmount);
        }
        return waring;
    }

    function balance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function depositsBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
