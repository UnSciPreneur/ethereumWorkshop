pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Game {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  mapping (bytes32 => uint8) public votesReceived;
  bytes32[] public candidateList;


  // Constructor
  function Game(bytes32[] candidateNames) {
    candidateList = candidateNames;
  }

// This is the syntax for a default function that will be executed if ether is sent to the smart contract.
// If the smart contract should be able to receive ether, this function is mandatory. If it does not exist
// transactions containing ether will be sent back.
  function() payable {}

  function playGame() returns (bool) {
    msg.sender.send(100);
  return true;
  }

// Interaction via truffle console:
// Game.deployed().then(function(contractInstance) {contractInstance.playGame.then(function(v) {console.log(v)})})
}