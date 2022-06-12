// SPDX-License_Identifier:MIT
 pragma solidity ^0.8.0;
 // Inheritance 
import "./SimpleStorage.sol";

 contract ExtraStorage is SimpleStorage {
     // add 5 to any number 
     // over-ride 
     // virtual override
     function store(uint256 _favoriteNumber) public override{
         favoriteNumber = _favoriteNumber + 5;
     }
 }