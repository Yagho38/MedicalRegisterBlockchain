// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract System{
    struct User{
        string name;
        uint age;
        string Address;
        uint phoneNumber;
        string diagnostics;
    }
    User user;
    mapping (address => bytes) UserHashes;

    event Create(string name, uint age, string _address, uint phonenumber, string diagnostics);
    event Update(string name, uint age, string _address, uint phonenumber, string diagnostics); 

    function EnterDetails(string memory _name, uint _age, string memory _address,uint _phonenumber, string memory _diagnostics) public {
        /*bytes memory diagnosticsHash = abi.encode(_diagnostics);*/
        /*user.diagnostics[diagnosticsName] = diagnosticsHash;*/
        bytes memory hashDetails = abi.encode(_name, _age, _address, _phonenumber, _diagnostics);
        UserHashes[msg.sender] = hashDetails;
        emit Create(_name, _age, _address, _phonenumber, _diagnostics); 
    }

    function updateDetails(address _user, string memory _name, uint _age, string memory _address,uint _phonenumber, string memory _diagnostics) public {
        bytes memory hash = UserHashes[_user];
        (string memory _1, uint _2, string memory _3, uint _4, string memory diagnostics2) = abi.decode(hash, (string, uint, string, uint, string));
        _diagnostics = string.concat(diagnostics2, _diagnostics);
        bytes memory hashDetails = abi.encode(_name, _age, _address, _phonenumber, _diagnostics);
        UserHashes[msg.sender] = hashDetails;
        emit Update(_name, _age, _address, _phonenumber, _diagnostics);
    }

    function checkHash(address _user) public view returns (string memory _name, uint _age, string memory _address,uint _phonenumber, string memory _diagnostics){
        bytes memory hash = UserHashes[_user];
        (_name, _age, _address, _phonenumber, _diagnostics) = abi.decode(hash, (string, uint, string, uint, string));
        return (_name, _age, _address, _phonenumber, _diagnostics);
    }
}