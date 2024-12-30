# Finance Tracker
A DApp to track and log all the transactions made by your accounts.
Contract Deployed to address on flow EVM testnet : 0x5ad40C3a3FD63267Ca07Bd300C5381080E9e5645
### Demo video
https://vimeo.com/1042895489?share=copy#t=0


## Technologies Used
- **Frontend:** Vite ( React )
- **Blockchain:** Foundry ( Contract deployed on Flow EVM testnet )
- **Smart contract Connection:** Ethers.js


## Installation and Running

1. Clone the repository using ```git clone``` and move into the folder using ```cd```;

2. Split terminal into 2 ( For frontend and blockchain backend(if deploying locally) )
3. Terminal frontend: Install dependencies
   ```bash
   npm install
   ```
4. You can use .env to mention on which localhost port to serve the frontend

5. Terminal backend: Configure folder for foundry to run and deploy contracts

6. Run localchain using ```anvil``` and deploy contracts using ```forge script script/Deploy.s.sol --fork-url http://localhost:8545 --private-key <PRIVATE_KEY> --broadcast```

7. Open the app in browser.
