// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {Test, console} from "forge-std/Test.sol";
import { Puzzle } from "../src/PUzzle.sol";
import { Handler } from "./handlers/Handler.sol";

contract TaskTest is Test {
    Puzzle public puzzle;
    Handler public handler;
    address public admin = makeAddr("admin");

    function setUp() public {
        puzzle = new Puzzle(5, admin);
        handler = new Handler(address(puzzle));
        // fund
       deal(address(handler), 1000 ether);
       targetContract(address(handler));
      // targetSelector();
    }

   // function invariant_checkBalance() public {
    //    assertEq(address(puzzle).balance, handler.deposited());
    //}

    function invariant_sumIs777() public {
        assertEq(puzzle.completed(), false);
    }

}
