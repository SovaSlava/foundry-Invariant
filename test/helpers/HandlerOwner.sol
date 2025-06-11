// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {CommonBase} from "lib/forge-std/src/Base.sol";
import {StdCheats} from "lib/forge-std/src/StdCheats.sol";
import {StdUtils} from "lib/forge-std/src/StdUtils.sol";
import {Puzzle} from "../../src/Puzzle.sol";

contract HandlerOwner is CommonBase, StdCheats, StdUtils {
    Puzzle public puzzle;
    uint256 public deposited;

    modifier prankOwner() {
        vm.startPrank(puzzle.owner());
        _;
        vm.stopPrank();
    }

    constructor(address _puzzle) {
        puzzle = Puzzle(_puzzle);
    }

    function allow() public prankOwner {
        puzzle.allow();
    }

    function emergencyWithdraw() public prankOwner {
        puzzle.emergencyWithdraw();
    }

    receive() external payable {}
}
