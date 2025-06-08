
pragma solidity 0.8.26;
contract Puzzle {

    uint256 public seqno;
    bool public completed;
    bool public submitted;
    uint32 public steps;
    uint32 public m;
    uint32 public n;
    uint32 public o;
    uint32 public p;
    uint32 public q;
    uint32 public r;
    uint32 public s;
    uint32 public t;
    address public admin;
    uint256 public withdrawForAdmin;

    mapping(address => uint256) public internalBalance;
    constructor (uint256 seqno_, address _admin) {
        seqno = seqno_;
        m = 19;
        n = 12;
        o = 41;
        p = 33;
        q = 10;
        r = 4;
        s = 23;
        t = 12;
        admin = _admin;
    }
 
    function alpha () external {
        decreaseBalance(msg.sender, 1 ether);
        m += 15;
        n -= 5;
        o = o << 1;
        steps += 1;
    }
 
    function beta() external {
        decreaseBalance(msg.sender, 2 ether);
        p += 10;
        q = q << 1;
        r -= 7;
        steps += 1;
    }
 
    function gamma () external {
        decreaseBalance(msg.sender, 3 ether);
        s = s >> 1;
        t += 20;
        m = m << 1;
        steps += 1;
    }
 
    function delta() external {
        decreaseBalance(msg.sender, 4 ether);
        n = n << 1;
        o += 12;
        p = p >> 1;
        steps += 1;
    }
 
    function epsilon() external {
        decreaseBalance(msg.sender, 5 ether);
        q -= 8;
        r = r << 1;
        s += 5;
        steps += 1;
    }
 
    function zeta() external {
        decreaseBalance(msg.sender, 6 ether);
        t = t << 1;
        m -= 9;
        n += 14;
        steps += 1;
    }
 
    function theta() external {
        decreaseBalance(msg.sender, 7 ether);
        o -= 6;
        p += 7;
        q = q << 1;
    }
 
    function verify() external {
        if (
            (((((((m + n) + o) + p) + q) + r) + s) + t) == 777 &&
            steps <= 15
        ) {
            completed = true;
        }
    }
 
    function sum() external view returns(uint256) {
        return ((((((m + n) + o) + p) + q) + r) + s) + t;
    }

    function makeDeposit() external payable {
        internalBalance[msg.sender] += msg.value;
    }

    function doWithdraw(uint256 amount) external {
        internalBalance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function decreaseBalance(address user, uint256 amount) internal {
        internalBalance[user] -= amount;
        withdrawForAdmin += amount;
    }

    function withdrawByAdmin() external {
        require(msg.sender == admin, "OnlyAdmin");
        payable(admin).transfer(withdrawForAdmin);
    }

}