See this thread here for discussion https://ethereum-magicians.org/t/discussion-around-2fa-implementation-within-smart-contracts/924/9


Terms/Definitions

RegisteredAgents = An ethereum account, that is loaded with eth, and unlocked in a parity/geth node running 24/7 on a server's backend (probably via aws). This is the trusted entity that will pass your newly generated 2FA code from the website to the ethereum blockchain. This backend does NOT have any private keys, other than its own, basically think of it as a trusted hot wallet. 

User = Person who has logged into the third party website, and generated a 2FA code, prior to making an ethereum transaction. 

Flow = User wants to make eth transaction. User knows that this token contract they want to interact with, has 2fa set up, so they log into the exampletokenswebsite.com/2fa where they log in with a username and password. Once logged in, they generated a code and submit it. The registeredAgent address passes that code to the smart contract when the user hits submit. User now makes a transaction to their token contract, but  also adds the code within the transaction details, and the smart contract will authenicate the user based on the code. If the code is expired or wrong, the transaction will revert. If the code is being used by a malicious actor, the transaction will revert since it needs to come from the private key/address of the person who generated the code on the website. 
