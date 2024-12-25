// SPDX-License-Identifier: GPL-3.0 AND MIT
pragma solidity >=0.7.0 <0.9.0;

contract DIMS {
    struct User{
        string name;
        string passportInfo;
        string healthInfo;
        bool exists;
    }

    address public owner;

    // for mapping etherium public key to user struct  
    mapping(address => User) private users;

    // Role mapping
    mapping(address => bool) public hospitals;
    mapping(address => bool) public passportAuthorities;


    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action!");
        _;
    } 

    modifier onlyHospital() {
        require(hospitals[msg.sender], "Access restricted to hospitals.");
        _;
    }


    modifier onlyPassportAuthority() {
        require(passportAuthorities[msg.sender], "Access restricted to passport authorities.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    //Admin assign roles

    function assignHospitalRole(address _hospital) public onlyOwner {
        hospitals[_hospital] = true;
    }

    function assignPassportAuthorityRole(address _passportAuthority) public onlyOwner {
        passportAuthorities[_passportAuthority] = true;
    }

    // for creating log on blockchain 
    event UserRegistered(address indexed userAddress, string name);
    event UserUpdated(address indexed userAddress, string name);



    // user regisrtration
    function registerUser (
        string memory _name,
        string memory _passportInfo,
        string memory _healthInfo
    ) public {
        require(!users[msg.sender].exists,"User already exists!");
        users[msg.sender] = User(_name, _passportInfo, _healthInfo, true);
    }

    // Update user information
    function updateUser(
        string memory _passportInfo,
        string memory _healthInfo
    ) public {
        require(users[msg.sender].exists, "User not registered.");
        users[msg.sender].passportInfo = _passportInfo;
        users[msg.sender].healthInfo = _healthInfo;
    }

    // function to give access to hospital only
    function getHealthInfo(address _user) public view onlyHospital returns (string memory) {
        require(users[_user].exists,"User not registered");
        return users[_user].healthInfo;
    }

    // for passport info. retreival
    function getPassportInfo(address _user) public view onlyPassportAuthority returns (string memory) {
        require(users[_user].exists,"User not registered");
        return users[_user].passportInfo;
    }

    // Check if a user exists
    function userExists(address _user) public view returns (bool) {
        return users[_user].exists;
    }

}

