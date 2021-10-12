pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/PayTheBills.sol";

contract TestPayTheBills {
    // The address of the PayTheBills contract to be tested
    PayTheBills payTheBills = PayTheBills(DeployedAddresses.PayTheBills());

    // Testing the payTheBills() function
    function testUserCanPayTheBills() public {

    }

}