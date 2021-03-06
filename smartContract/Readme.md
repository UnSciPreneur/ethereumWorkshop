# Before the workshop

## Preparations

### Run a blockchain client

(A more detailed explanation on blockchain clients can be found in `./nodes/Readme.md`. If you just want to check the coding framework and the build system we recommend using *testrpc* here.)

Run either `geth` or `testrpc`. We recommend to start with testrpc, for testing purposes. Once you want to communicate with the private blockchain we hosted you should use the geth client.

#### testrpc
For testing purposes you can start up the testrpc with the appropriate script in the `./nodes` directory:
```bash
./testrpc.sh
```
This starts testrpc, which simulates a blockchain. It uses the same configuration, ports etc. like the geth client. The advantage is that it is a lot faster (no blocktime, mining, etc..). Additionally, every time you start testrpc, you get a new clean blockchain, so there is no confusion which smart contract to use.

#### geth
For every interaction with the blockchain, the geth client needs to be running. To create a transaction, an account must be unlocked and filled with some ether. This should be automatically given by running the command below.

Start the geth client by running the appropriate script in the `./nodes` directory:
```bash
./run_eth_node_0.sh
```
This opens a console which lets you interact directly with the client. A list of available commands can be found [here](https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console). Additionally all [Web3 Javascript APIs](https://github.com/ethereum/wiki/wiki/JavaScript-API) can be used.

See `./nodes/Readme.md` on how to connect your geth client to peers from the test network.

### Required software

To compile a smart contract and deploy it to the blockchain we need to install a few helper tools.

Install *Node.js* and *npm* (npm comes automatically with Node.js)
```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
```
We will need Node.js in version *6.9.x* or higher!

Install the npm package [web3](https://www.npmjs.com/package/web3) to interact with the Ethereum client from Node.js or a web browser. We choose the current stable version 0.20.0.
```bash
npm install -g web3@0.20.0
```

Install [truffle](https://www.npmjs.com/package/truffle)
```bash
npm install -g truffle
```

## Running a working smart contract example

This repository contains a working example of a smart contract for token based voting taken from [https://github.com/maheshmurthy/ethereum_voting_dapp/chapter3](https://github.com/maheshmurthy/ethereum_voting_dapp/chapter3).
 
To check that you have correctly installed all components required for the workshop you can run this example using the instructions from `./smartContract/votingExample/Readme.md`.

If the code builds and you can start the app in the browser: **Congratulations! You are good to go for the workshop!**
Preparatory steps end here. All further steps will be part of the on-site workshop.

# During the workshop

## Deploy your own contract

### Setup a truffle project

We need to set up a truffle project, which helps us to deploy the smart contract and interact with it. Inside the ethereumWorkshop directory execute: 
```bash
mkdir gameDapp
cd gameDapp
npm install -g webpack
truffle unbox tutorialtoken
```
Truffle creates a sample dapp (distributed app aka app on the Ethereum blockchain). The corresponding smart contracts are stored in the directory contracts and the part for the web interaction in app. You can safely delete the ConvertLib.sol and MetaCoin.sol files in the contracts directory and 2_deploy_contracts.js in the migrations directory for this project. The files in the migration directory are used to deploy the contracts to the blockchain.

### Fill the truffle project with your content

Copy and/or replace the files from the folder *gameExample* to their appropriate locations: 

Copy `./contracts/Game.sol` to `./contracts/`
Copy `./migrations/2_deploy_game.js` to `./migrations/`
Replace `./app/javascripts/app.js` with `./app/javascripts/app.js`
Replace `./app/stylesheets/app.css` with `./app/stylesheets/app.css` 
Replace `./app/index.html` with `./app/index.html`.

A short explanation regarding the use of those files: *Game.sol* is the smart contract you will deploy, it offers some roulette gambling functions. *2_deploy_game.js* tells the truffle framework, how it should deploy the smart contract from your computer to the blockchain. The files in the app/ directory create a website that lets you interact with the smart contract on a graphic interface in your browser.

### Deploy the contract to the blockchain

In the directory of the dapp gameDapp/ use truffle to deploy the contract
```bash
truffle migrate
```
This compiles the contract and writes it to the Ethereum blockchain. It might take a minute to finish if you're on the private blockchain. If you are using testrpc it should only take a few seconds (that's the advantage!). If it does not work, check that your geth client or testrpc is running and account account[0] is unlocked and has enough ether to interact with the blockchain.

## Interacting with the contract on the blockchain via the truffle console

In the directory of the dapp gameDapp/ open a truffle console
```bash
truffle console
```
You can interact through this console with your contract. For example place a bet on even numbers (we are playing roulette, in case you did not bother to read the smart contract): 

```truffle
truffle(default)> Game.deployed().then(function(contractInstance) {contractInstance.betEven({gas: 140000, value: 100, from: web3.eth.accounts[0]}).then(function (v) {console.log(v)})})
```
**Note:** Don't write `truffle(default)>`, start with `Game.deployed()` The start is just intended to tell you to use the truffle console.

You should get the information back from the blockchain transaction, something similar to this
```truffle
truffle(development)> { tx: '0x15e40e3a78737f8a97c7af3445554812a0997743dc4f2307ea7a18187bd6b9fa',
  receipt: 
   { transactionHash: '0x15e40e3a78737f8a97c7af3445554812a0997743dc4f2307ea7a18187bd6b9fa',
     transactionIndex: 0,
     blockHash: '0x36e0dc2c8c897a3af97c835e817df6ebee40e00e4d15513a621c35e47b757890',
     blockNumber: 98,
     cumulativeGasUsed: 49425,
     gasUsed: 49425,
     contractAddress: null,
     logs: [] },
  logs: [] }

```
If that worked, congrats! Your smart contract is live on the blockchain.

## Interacting with the contract on the blockchain via the browser

Now you can start the server to interact with the dapp via your webbrowser. This will use the files in your gameDapp/app/ directory to create the site.
```bash
npm run dev
```
You can access the website through your browser at localhost:8080. You can place bets on even and odd numbers or on zero.

If you have not already, you can take a look at the smart contract, its functions, add a new one and try to make it accessible via the webpage. If you succeed with that, you can also create a completely new smart contract, with a fun game and post it on our github, so that the other people can play it too!

# After the workshop

You now have a good impression on how smart contracts work and how to get them deployed. Have fun exploring the blockchain universe of smart contracts!

## Creating an additional smart contract

You need to create a new file myNewContract.sol in the contracts directory and a new migration file in the migrations directory, i.e. create 4_deploy_myNewContract.js. **NOTE:** This new deploy file needs to start with an integer increased comparing to the last one! I.e. 4_deploy_myNewContract.js and then 5_deploy_myNextNewContract.js.

If you need to redeploy all contracts you can use
```bash
truffle migrate --reset
```
If you just want to deploy new contracts, you can discard the flag `--reset`.

## Smart contract development

If you just want to quickly test a smart contract, you can do that online at 
[https://remix.ethereum.org/](https://remix.ethereum.org/). It lets you create a smart contract and test the individual functions in your browser.

The official online documentation for solidity (the language of smart contracts) is [here](https://solidity.readthedocs.io/en/develop/).
And the truffle documentation [here](http://truffleframework.com/docs/).
