// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;   // declare range , so it will compile the smart contracts smoothly without any errors
//pragma is a directive that specifies the compiler version to be  
                                    //used for current Solidity file.
contract Bank{
    address public owner;
    mapping(address => uint256) private userbalance;


    constructor()  {    // A constructor is basically a function that runs only once, 
                            //which is at the time of deploying the smart contract. 
                            //What it means is that, whatever code is written in the constructor 
                            //will be executed only once while deploying the smart contract 
        owner = msg.sender;  //Msg.sender that is contract deployer as owner of smart contract . 
    }

    modifier onlyOwner() {         //Modifiers specify access control rules to verify and manage who 
                                    //has control of data and functions to establish trust and privacy
        require(msg.sender == owner, 'you are not the owner of this contract');
       _; 
    }

    function deposite() public payable returns(bool) {    // allows user to deposit their etherum in our 
                                                        //banking smart contracts
        require(msg.value > 10 wei , 'please deposite atleast 10 wei');
        userbalance[msg.sender] += msg.value;
        return true;
    }

    function withdraw(uint256 _amount) public payable returns(bool) {
        require( _amount <=userbalance[msg.sender], 'you dont have sufficient funds');
        userbalance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        return true;
    }

    function getbalance() public view returns(uint256) {
        return userbalance[msg.sender];
    }

    function getcontractbalance() public view onlyOwner returns(uint256) {
        return address(this).balance;
    }

    function withdrawfunds(uint256 _amount) public payable onlyOwner returns(bool) {
        payable(owner).transfer(_amount);
        return true;
    }

}