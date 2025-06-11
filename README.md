## Foundry invariant tests

This is a solution to one CTF task.

Using invariant tests, I found the answer to 2 questions:
1. In what sequence should the functions be called by the user and the owner of the contract so that the variable completed becomes true?

2. To call the functions, the user deposits ether into the contract and it is credited to the internal balance - can the owner steal these funds?

To answer the questions, I created 2 invariant tests.

### Feautures

- 2 contract handlers (user and contract owner functions) 
- Library for managing the actor
- For reduce reverts, when new user call functions, which decrease internal balance, before this call, user call makeDeposit function automaticaly
- Ownable contract from OZ has been excluded from tests


## Test results

### 1. Sequence: 
```solidity
    [Sequence]
sender=0x000000...00000477 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=zeta(uint256) args=[3943]
sender=0x000000...0018df addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=theta(uint256) args=[5314]
sender=0x15268E...FE5D00 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=epsilon(uint256) args=[111207891223878957610743914019090467537753351409 [1.112e47]]
sender=0x000000...6c6343 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=theta(uint256) args=[12999999999999999999 [1.299e19]]
sender=0x5ce28b46C1F4a45A67da5c3A65c7255409C4238F addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=gamme(uint256) args=[4522023107713435312158473115853722633881496099981986151998854287044279 [4.522e69]]
sender=0x000000...0003C8 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=zeta(uint256) args=[1484]
sender=0x000000...001938 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=gamme(uint256) args=[1405310203571408291950365054053061012934685786635 [1.405e48]]
sender=0x000000...00043D addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=delta(uint256) args=[8115]
sender=0x000000...0015c7 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=zeta(uint256) args=[263071605917264072152 [2.63e20]]
sender=0x6EEdf1...4363eD addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=zeta(uint256) args=[1233285293859761504469223 [1.233e24]]
sender=0x1552e6...DDF24D addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=beta(uint256) args=[7022]
sender=0x3A6bbf...e13069 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=delta(uint256) args=[103079215128 [1.03e11]]
sender=0x000000...0001c6e addr=[test/helpers/HandlerOwner.sol:HandlerOwner]0xF62849...1A820a calldata=allow() args=[]
sender=0x8b6E29...03BfC8 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=verify() args=[]
 invariant_completedAlwaysFalse() (runs: 8, calls: 4000, reverts: 1310)
 ```

###  2. Owner could steal user's funds
```solidity
[FAIL: assertion failed: 107000000000000000001 != 53000000000000000001]
        [Sequence]
sender=0x000000...001955 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234D...58470b calldata=delta(uint256) args=[622420563864771244190117980428 [6.224e29]]
sender=0x000000...00036c addr=[test/helpers/HandlerOwner.sol:HandlerOwner]0xF62849...1A820a calldata=emergencyWithdraw() args=[]
```