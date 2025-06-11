// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {Puzzle} from "../src/PUzzle.sol";
import {HandlerUser} from "./helpers/HandlerUser.sol";
import {HandlerOwner} from "./helpers/HandlerOwner.sol";

contract TaskTest is Test {
    Puzzle public puzzle;
    HandlerUser public handlerUser;
    HandlerOwner public handlerOwner;

    address public admin = makeAddr("admin");

    function setUp() public {
        puzzle = new Puzzle(5, admin);
        excludeContract(address(puzzle));

        handlerUser = new HandlerUser(address(puzzle));
        handlerOwner = new HandlerOwner(address(puzzle));
        // fund
        deal(address(handlerUser), 10000 ether);
    }

    function invariant_completedAlwaysFalse() public view {
        assertEq(puzzle.completed(), false);
    }

    function invariant_ownerCouldNotStealUsersFunds() public view {
        assertEq(handlerUser.deposited(), address(puzzle).balance);
    }
}
