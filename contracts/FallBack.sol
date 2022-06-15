// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;


contract FallBack{

    uint256 public result;
    recieve() external payable {
        result = 1;
    }

    fallback() external payable{
    result = 2;
    }
}

