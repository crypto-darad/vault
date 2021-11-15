# crypto-wealth vault

to minimize the impact of transaction fees, to maximize security - and to make the most out of opportunities, we propose a novel multisig wallet, that exists onchain, and can act autonomous - as the DAO - votes

following ERC 1155

using merkle proofs to reduce storage costs

## register identities 
possible ways to do this: 
* https://w3c.github.io/did-core/
* auth - token - nft

## vault-wallet
* create vault smart contract - deposited tokens can be swapped against "flexible liquidity"
* register multisig-identities as pears (key-loss, emergency revalidation)
* split actual vault logic from depositing and recalculation of the users stake, so that depositing and withdrawing from the vault will have minimal fee-costs

## flexible liquidity
all into the contract submited tokens are held inside the contract, for each token that the contract emits - there is an equal amount of tokens that are owned by the contract. 
the contract interfaces with different DEXs in a way, where you can allways exchange all the emited tokens back to the original commited once. We achive this by emiting "flexible liquidity"-tokens that are pegged against the vault contract

the flexible liquidity tokens keep there "liquid state" as long as they are managed by a smart-contract. As soon as the get transfered to an actual wallet, the flexible liquidity contract drains the contract of the tokens - at the current rate 

### mechanics: 

imageine a tokenpair A/B traded on pancake-swap, our contract then can emit flA and flB Tokens in the corresponding amount. As we want to get those tokens out for trading - the smart-contract can generate pancake-swap pools for all possible combinations that cound be traded - for all in the commited vaults tokens. 
So lets imagine we have 100A and 10B tokens - and 1B token is worth 5A tokens 
at the time where the later token was commited (B)

so we generate pancake-swap pairs: flA/flB - and add 50A and 10B tokens 
we now can trade those tokens - without loosing control over there pegged counterpart 
and as soon as a trade happens - the contract of the flTokens - unwraps the original tokens and transferes them. 

### benefits: 

* security
* every flToken can be stoped for transfer, it can change its value - based on market-conditions. 

