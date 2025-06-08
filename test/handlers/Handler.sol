// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import { CommonBase } from "lib/forge-std/src/Base.sol";
import { StdCheats } from "lib/forge-std/src/StdCheats.sol";
import { StdUtils } from "lib/forge-std/src/StdUtils.sol";
import { Puzzle } from "../../src/Puzzle.sol";

contract Handler is CommonBase, StdCheats, StdUtils {

    Puzzle public puzzle;
    uint256 public deposited;
    constructor(address _puzzle) {
        puzzle = Puzzle(_puzzle);
    }

    function makeDeposit(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        deposited += amount;
        puzzle.makeDeposit{value: amount}();
    }

    function doWithdraw(uint256 amount) public {
        amount = bound(amount, 0, puzzle.internalBalance(address(this)));
        deposited -= amount;
        puzzle.doWithdraw(amount);
    }

    function beta() public {
        puzzle.beta();
    }

    function gamme() public {
        puzzle.gamma();
    }

    function delta() public {
        puzzle.delta();
    }

    function epsilon() public {
        puzzle.epsilon();
    }

    function zeta() public {
        puzzle.zeta();
    }

    function theta() public {
        puzzle.theta();
    }

    function verify() public {
        if(puzzle.sum() == 777 && puzzle.steps() <= 15) {
            puzzle.verify();
        }
    }
    receive() external payable {}
}