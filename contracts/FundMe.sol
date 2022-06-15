// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";


contract FundMe {

// Get funds from user 
// Withdraw funds
// Set a minimum funding value in USD 

using PriceConverter for uint256;

uint256 public minimumUsd =  50*1e18;


    address[] public funders;
    mapping(address => uint256)public addressToAmountFunded;
   

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // msg.value.getConversionRate();
         require( msg.value.getConversionRate() >= minimumUsd, "Didn't send enough");  
         funders.push(msg.sender);
         addressToAmountFunded[msg.sender] = msg.value;
         // 18 Decimal places 

    }



    // // https://docs.chain.link/docs/get-the-latest-price/
    // function getPrice () public view returns(uint256) {
    //      // Interacting the contarct outside our B
    //      // ABI  + Address  help is to interact 
    //      //  ABI is get from https://github.com/smartcontractkit/chainlink using interface
    //      //  Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419

    //      AggregatorV3Interface priceFeed  =  AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    //       (, int256 price,,,)  =   priceFeed.latestRoundData();
    //       return uint256( price * 1e10);

    //       // Price of ETH in USD 

    // }

    // function getVersion() public view returns (uint256){
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    //     return priceFeed.version();
    // }

    // function getConversionRate (uint256 ethAmount )  public view returns (uint256) {
    //         uint256 ethPrice =  getPrice();
    //         uint256 ethAmountInUsd =  (ethPrice *ethAmount) / 1e18;
    //     return ethAmountInUsd;
    // }

    function withdraw() public {
        for ( uint256  funderIndex = 0; funderIndex < funders.length; funderIndex++){
                address funder  = funders[funderIndex];
                addressToAmountFunded[funder] =  0;
        }
        // Reset the array 
        funders = new address[](0);

        // Actual withdraw of funds 

        // 1 Transfer Simpleest 
        // msg.sender = address
        // payable(msg.address); =  payable address


        // payable(msg.sender.Transfer(address(this).balance));


        //  2 Send 
        bool sendSuccess =   payable(msg.sender.send(address(this).balance)); 
        require(sendSuccess, "Send Failed");


        // 3 Call 
        //    (bool callSuccess, bytes memory dataReturned) =  payable(msg.sender.call{value:address(this).balance}(""));
          (bool callSuccess,) =  payable(msg.sender.call{value:address(this).balance}("")); 
          require(callSuccess, "Call Failed");




    }
}