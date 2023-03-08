//uint
//int
//strings
//arrays
//bytes
//bytes32
//struct
//mapping
//bool
//address

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    //Definition
    struct Wallet {
        address holder;
        uint balance;
        uint id;
        string[3] friends;
    }
    Wallet wallet;

    uint walletId = 1;

    // const obj = {
    //     name = "joe",
    //     age = 20,
    //     cars = ["toyota", "Lambo"] 
    // }

    // obj.name;
    //key -> value
    mapping(string => address) addressMap;
    mapping(string => Wallet) walletMap;
    mapping(string => mapping(uint => bool)) spentMap;

    address[] addresses;

    //Decl
    //Type -> name -> value
    
    int256 time = 20;
    string car = "Lambo";
    
    uint256 age;
    bool verified; 
    address admin;

    //public : can be called from anywhere by anyone
    //external: can be called from anywhere by anyone
    //internal: can be called by the contract or contracts inheriting it
    //private: 

    function internalStore(string calldata name) internal returns(string[3] memory) {
        string[3] memory names = ["bill", "chris", "joe"];
        
        Wallet memory _wallet;
        _wallet.holder = msg.sender;
        _wallet.balance = address(msg.sender).balance;
        _wallet.id = walletId;
        
        walletId++;
        verified = true;
        //age = 20*2;
        age = mul(20, 2);
        walletMap[name] = _wallet;
        addressMap[name] = msg.sender;
        spentMap[name][0] = true;
        addresses.push(msg.sender);
        _wallet.friends = ["bill", "chris", "joe"];
       return names;
    }

    function store(string calldata name) private returns(string[3] memory) {
        return internalStore(name);
    }

    function privateStore(string calldata name) external returns(string[3] memory) {
        return store(name);
    }

    function check(string calldata name) external view returns(bool, uint, address, Wallet memory, bool, string[3] memory) {
        return (verified, age, addressMap[name], walletMap[name], spentMap[name][20],walletMap[name].friends);
    }

    function mul(uint a, uint b) public pure returns (uint) {
        return a*b;
    }
}

contract Storage is SimpleStorage {
    function store2(string calldata name) external {
        internalStore(name);
    }
}