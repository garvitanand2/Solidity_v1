// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";



error NotOwner();

contract FundMe {

// Get funds from user 
// Withdraw funds
// Set a minimum funding value in USD 


// Constant and Immutable Keyword 


using PriceConverter for uint256;
uint256 public constant MINIMUM_USD =  50*1e18;
address[] public  funders;
address public  immutable i_owner;
mapping(address => uint256) public addressToAmountFunded;

 
   

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // msg.value.getConversionRate();
         require( msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");  
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
  
    constructor () {
        i_owner = msg.sender;

    }
    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Sender is not owner!") ;

        // Modifier 

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
        // bool sendSuccess =   payable(msg.sender.send(address(this).balance)); 
        // require(sendSuccess, "Send Failed");


        // 3 Call 
        //    (bool callSuccess, bytes memory dataReturned) =  payable(msg.sender.call{value:address(this).balance}(""));
         (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;

  
    }


    // recive()

    receive() external payable{
        fund();
    }

    fallback() external payable{
        fund();
    }
    // fallback()


// Pending to explore 
// 1. Enums 
// 2. Try / catch
// 3. Function Selectors
// 4. abi.encode / decode 
// 5. Hashing
// 6. Events 
// 7. Yul / Assembly

}