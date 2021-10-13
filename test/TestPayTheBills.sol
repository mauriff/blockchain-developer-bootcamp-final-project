pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PayTheBills.sol";

contract TestPayTheBills {

    uint public initialBalance = 50 ether;

    // The address of the PayTheBills contract to be tested
    PayTheBills payTheBills;


    // beforeEach works before running each test
     // beforeEach works before running each test
    function beforeEach() public {
        payTheBills = new PayTheBills();
        (bool r, ) = address(payTheBills).call.value(1 ether)("");
    }

    // Testing the payTheBills() function
    function testUserCanAddItems() public {
         (bool r, ) = payTheBills.addItemToTheBill("water", 100, "0xdb8d4099e12099ccC6cB1D2b5684D9e1BA06EC1C");
         Assert.isTrue(r, "Buyer must be able to receive item.");

    }

}
