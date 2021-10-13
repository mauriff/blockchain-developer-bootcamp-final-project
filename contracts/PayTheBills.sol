// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/// @title Pays the bills Smart Contract
/// @author Mauricio Ferreyra
/// @notice I'm using this contract to learn solidity as part as Consensys Bootcamp
/// @dev All function calls are written by a beginner, not good idea implement it as it is
contract PayTheBills {

  address public owner = msg.sender;
  uint public itemCount;
  mapping (uint => Item)public items;
  enum State {ToPay, Paid}

  struct Item{
    string name;
    uint price;
    State state;
    address payable paymaster;
    address payable payTo;
  }

  modifier onlyOwner() {
      require(msg.sender == owner, "Not authorized.");
      _;
  }

  event LogToPay(string indexed _name);
  event LogPaid(string indexed _name);

  constructor() public  {
    owner = msg.sender;
    itemCount = 0;
  }

  /// @notice Add an item to pay the bills
  /// @param _name the name of the service to pay
  /// @param _price the price of the service to pay
  /// @param _payTo the address of the seller to pay the service
  /// @return boolean, that means that the item was added succesfully
  function addItemToTheBill(string memory _name, uint _price,address payable _payTo) public returns (bool) {
    //_name is not null
    //require(_name >= 0);

    // _price is major than -1
    //require(_price >= 0);

    //Add items to pay
    // 1. Create a new item and put in array
    items[itemCount] = Item ({
      name: _name, 
      price: _price, 
      state: State.ToPay, 
      paymaster: msg.sender, 
      payTo: _payTo

    });

    itemCount++;
    emit LogToPay(items[itemCount].name);
    return true;

  }


  /// @return boolean, the payment was succesful
  function payTheBills() onlyOwner public returns (bool) {

    
      for(uint8 i=0; i<= itemCount; i++){
        items[i].payTo.transfer(items[i].price);
        items[i].state = State.Paid;
        emit LogPaid(items[i].name);

      }

    
    return true;
  }



}
