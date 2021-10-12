// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/// @title Pays the bills Smart Contract
/// @author Mauricio Ferreyra
/// @notice I'm using this contract to learn solidity as part as Consensys Bootcamp
/// @dev All function calls are written by a beginner, not good idea implement it as it is
contract PayTheBills {

  address public owner = msg.sender;

  struct Item{
    string name;
    uint price;
    address payable paymaster;
    address payable seller;
  }

  modifier onlyOwner() {
      require(msg.sender == owner, "Not authorized.");
      _;
  }

  constructor() public {
    owner = msg.sender;
  }

  /// @notice Add an item to pay the bills
  /// @param _name the name of the service to pay
  /// @param _price the price of the service to pay
  /// @param _seller the address of the seller to pay the service
  /// @return boolean, that means that the item was added succesfully
  function addItemToTheBill(string memory _name, uint _price,address payable _seller) public returns (bool) {
    //_name is not null
    //require(_name >= 0);

    // _price is major than -1
    //require(_price >= 0);

    //Add items to pay
    
  }

  /// @notice Pay the bills that are in the items array
  /// @param _name the name of the service to pay
  /// @return boolean, the payment was succesful
  function payTheBills(string memory _name) onlyOwner public returns (bool) {
    return true;
  }



}
