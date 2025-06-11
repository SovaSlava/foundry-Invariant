## Foundry invariant tests

This is a solution to one CTF task.

Using invariant tests, I found the answer to 2 questions:
1. In what sequence should the functions be called by the user and the owner of the contract so that the variable completed becomes true?

2. To call the functions, the user deposits ether into the contract and it is credited to the internal balance - can the owner steal these funds?

To answer the questions, I created 2 invariant tests.

I  ued 2 contract handlers (user and contract owner functions) and a library for managing the actor. For reduce reverts, when new user call functions, which decrease internal balance, before this call, user call makeDeposit function automaticaly.


## Test results

### 1. Sequence: 
```solidity
    [Sequence]
                sender=0x0000000000000000000000000000000000000477 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=zeta(uint256) args=[3943]
                sender=0x00000000000000000000000000000000000018df addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=theta(uint256) args=[5314]
                sender=0x15268E3aae00EF0b14EF23d4a7A63204b6FE5D00 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=epsilon(uint256) args=[111207891223878957610743914019090467537753351409 [1.112e47]]
                sender=0x000000000000000000000000000000736f6c6343 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=theta(uint256) args=[12999999999999999999 [1.299e19]]
                sender=0x5ce28b46C1F4a45A67da5c3A65c7255409C4238F addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=gamme(uint256) args=[4522023107713435312158473115853722633881496099981986151998854287044279 [4.522e69]]
                sender=0x00000000000000000000000000000000000003C8 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=zeta(uint256) args=[1484]
                sender=0x0000000000000000000000000000000000001938 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=gamme(uint256) args=[1405310203571408291950365054053061012934685786635 [1.405e48]]
                sender=0x000000000000000000000000000000000000043D addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=delta(uint256) args=[8115]
                sender=0x00000000000000000000000000000000000015c7 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=zeta(uint256) args=[263071605917264072152 [2.63e20]]
                sender=0x6EEdf1401eE962A4ED62a1D6eCB182D0BB4363eD addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=zeta(uint256) args=[1233285293859761504469223 [1.233e24]]
                sender=0x1552e6B1C6bda824Fdec24BaBaC48dE049DDF24D addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=beta(uint256) args=[7022]
                sender=0x3A6bbf498841aD01F6Ab9A119a978288Abe13069 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=delta(uint256) args=[103079215128 [1.03e11]]
                sender=0x0000000000000000000000000000000000001c6e addr=[test/helpers/HandlerOwner.sol:HandlerOwner]0xF62849F9A0B5Bf2913b396098F7c7019b51A820a calldata=allow() args=[]
                sender=0x8b6E2995b1d2e5A13E605B0426A88E4f5903BfC8 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=verify() args=[]
 invariant_completedAlwaysFalse() (runs: 8, calls: 4000, reverts: 1310)
 ```

###  2. Owner could steal user's funds
```solidity
[FAIL: assertion failed: 107000000000000000001 != 53000000000000000001]
        [Sequence]
                sender=0x0000000000000000000000000000000000001955 addr=[test/helpers/HandlerUser.sol:HandlerUser]0x2e234DAe75C793f67A35089C9d99245E1C58470b calldata=delta(uint256) args=[622420563864771244190117980428 [6.224e29]]
                sender=0x000000000000000000000000000000000000036c addr=[test/helpers/HandlerOwner.sol:HandlerOwner]0xF62849F9A0B5Bf2913b396098F7c7019b51A820a calldata=emergencyWithdraw() args=[]
```