// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
       function getPrice () internal view returns(uint256) {
         // Interacting the contarct outside our B
         // ABI  + Address  help is to interact 
         //  ABI is get from https://github.com/smartcontractkit/chainlink using interface
         //  Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419

         AggregatorV3Interface priceFeed  =  AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
          (, int256 price,,,)  =   priceFeed.latestRoundData();
          return uint256( price * 1e10);

          // Price of ETH in USD 

    }

    function getVersion() internal view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate (uint256 ethAmount )  internal view returns (uint256) {
            uint256 ethPrice =  getPrice();
            uint256 ethAmountInUsd =  (ethPrice *ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}