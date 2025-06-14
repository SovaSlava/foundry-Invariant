pragma solidity 0.8.26;

import {Ownable2Step, Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable2Step.sol";

contract Puzzle is Ownable2Step {
    uint256 public seqno;
    uint256 public transfersCount;
    bool public completed;
    bool public ownerAllowed;
    uint32 public steps;
    uint32 public m;
    uint32 public n;
    uint32 public o;
    uint32 public p;
    uint32 public q;
    uint32 public r;
    uint32 public s;
    uint32 public t;
    uint256 public withdrawForAdmin;

    mapping(address => uint256) public internalBalance;

    constructor(uint256 seqno_, address _admin) Ownable(_admin) {
        seqno = seqno_;
        m = 19;
        n = 12;
        o = 41;
        p = 33;
        q = 10;
        r = 4;
        s = 23;
        t = 12;
    }

    function alpha() external {
        decreaseBalance(1 ether);
        m += 15;
        n -= 5;
        o = o << 1;
        steps += 1;
    }

    function beta() external {
        decreaseBalance(2 ether);
        p += 10;
        q = q << 1;
        r -= 7;
        steps += 1;
    }

    function gamma() external {
        decreaseBalance(3 ether);
        s = s >> 1;
        t += 20;
        m = m << 1;
        steps += 1;
    }

    function delta() external {
        decreaseBalance(4 ether);
        n = n << 1;
        o += 12;
        p = p >> 1;
        steps += 1;
    }

    function epsilon() external {
        decreaseBalance(5 ether);
        q -= 8;
        r = r << 1;
        s += 5;
        steps += 1;
    }

    function zeta() external {
        decreaseBalance(6 ether);
        t = t << 1;
        m -= 9;
        n += 14;
        steps += 1;
    }

    function theta() external {
        decreaseBalance(7 ether);
        o -= 6;
        p += 7;
        q = q << 1;
    }

    function transfer(address to, uint256 amount) external {
        internalBalance[msg.sender] -= amount;
        internalBalance[to] += amount;
        transfersCount++;
    }

    function verify() external {
        if ((((((((m + n) + o) + p) + q) + r) + s) + t) == 777 && steps <= 15 && ownerAllowed == true) {
            completed = true;
        }
    }

    function sum() external view returns (uint256) {
        return ((((((m + n) + o) + p) + q) + r) + s) + t;
    }

    function makeDeposit() external payable {
        internalBalance[msg.sender] += msg.value;
    }

    function doWithdraw(uint256 amount) external {
        internalBalance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function decreaseBalance(uint256 amount) internal {
        internalBalance[msg.sender] -= amount;
        withdrawForAdmin += amount;
    }

    function emergencyWithdraw() external onlyOwner {
        payable(owner()).transfer(withdrawForAdmin);
    }

    function allow() external onlyOwner {
        ownerAllowed = true;
    }
}
