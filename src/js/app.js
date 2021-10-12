App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load pets.
    $.getJSON('../services.json', function(data) {
      var servicesRow = $('#servicesRow');
      var servicesTemplate = $('#servicesTemplate');

      for (i = 0; i < data.length; i ++) {
        servicesTemplate.find('.panel-title').text(data[i].name);
        servicesTemplate.find('img').attr('src', data[i].picture);
        servicesTemplate.find('.company').text(data[i].company);
        servicesTemplate.find('.price').text(data[i].pricing);
        servicesTemplate.find('.payto').text(data[i].eth_to_pay);
        servicesTemplate.find('.btn-pay').attr('data-id', data[i].id);

        servicesRow.append(servicesTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {
    // Modern dapp browsers...
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Adoption.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with @truffle/contract
      var AdoptionArtifact = data;
      App.contracts.Adoption = TruffleContract(AdoptionArtifact);
    
      // Set the provider for our contract
      App.contracts.Adoption.setProvider(App.web3Provider);
    
      // Use our contract to retrieve and mark the adopted pets
      return App.markAdopted();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function() {
    /*
     * Replace me...
     */
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    var adoptionInstance;

  web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    }

    var account = accounts[0];

    App.contracts.Adoption.deployed().then(function(instance) {
      adoptionInstance = instance;

      // Execute adopt as a transaction by sending account
      return adoptionInstance.adopt(petId, {from: account});
    }).then(function(result) {
      return App.markAdopted();
    }).catch(function(err) {
      console.log(err.message);
    });
  });

}
}
$(function() {
  $(window).load(function() {
    App.init();
  });
});
