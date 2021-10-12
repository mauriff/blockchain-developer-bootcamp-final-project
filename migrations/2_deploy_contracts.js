var Adoption = artifacts.require("Adoption");
var PayTheBills = artifacts.require("PayTheBills");

module.exports = function(deployer) {
  deployer.deploy(Adoption);
  deployer.deploy(PayTheBills);
};