// SPDX-License-Identifier: MIT
// The above mentioned Line is the Licenese 
// Defining the solidity version that we are using in the project
pragma solidity 0.8.8; // 0.8.12
// pragma solidity ^0.8.7; // This or above then this will work 
// pragma solidity >=0.8.7 <0.9.0; // Version in the range 

contract SimpleStorage {
    // boolean, uint, int, address, bytes
    bool  hasFavoriteNumber = true;
    string favoriteNumberInText =  "Five";
    int256  favoriteInt = -5;
    address myaddress =  0x895Bf621E6B6189d9Bc1912F9571bbB870FD8B3e;
    bytes32   favoriteBytes =  "cat";
    // uint256 favoriteNumber = 123; Max
    // uint8 favoriteNumber = 123; Min
    // This is initialized to zero
    uint256  favoriteNumber;

    // virtual keyword makes the functoion override-able

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber =  _favoriteNumber;
        uint256 testVar =  5;

    }

    // function Something() public{
    //     testVar  = 6;
    // }// 0xd9145CCE52D386f254917e481eB44e9943F39138
        function  retrieve() public view  returns(uint256){
            return favoriteNumber;
        }
        function add() public pure returns(uint256){
            return (1+1);
        }

        // Mapping the people 
        mapping(string => uint256) public nameToFavoriteNumber;
        
        struct People {
            uint256 favoriteNumber;
            string name;
        }

        People[] public people;

        // People public person = People({favoriteNumber:2,name:"Jack"});
        // calldata, memory, storage
        function addPerson(string memory _name, uint256 _favoriteNumber) public {
            people.push(People(_favoriteNumber,_name));
            nameToFavoriteNumber[_name] =_favoriteNumber;
        }


        // All the code compiles to EVM 
        // EVM => Ethereum virtual Machinne 
        // EVM compatible Block chain => {Avlanche, Polygon, Fantom}
}
