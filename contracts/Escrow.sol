pragma solidity >=0.6.12 <0.9.0;

contract Escrow {

    // person with perms to contract
    address agent;

    constructor () {
        agent = msg.sender;
    }

    modifier onlyAgent(){
        require(msg.sender == agent);
        _;
    }

    // mapping where we store deposits in escrow
    mapping(address => uint256) public deposits;

    // deposit funds into the account
    function deposit(address payee) public onlyAgent payable {
        // keep track of funds sent in
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
    }

    // withdraw funds to the payee
    function withdraw(address payable payee) public onlyAgent {
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }

}