// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {CommonBase} from "lib/forge-std/src/Base.sol";
import {StdCheats} from "lib/forge-std/src/StdCheats.sol";
import {StdUtils} from "lib/forge-std/src/StdUtils.sol";
import {Puzzle} from "../../src/Puzzle.sol";
import {LibAddressSet} from "./LibAddressSet.sol";

contract HandlerUser is CommonBase, StdCheats, StdUtils {
    Puzzle public puzzle;
    uint256 public deposited;
    address internal currentActor;

    using LibAddressSet for LibAddressSet.AddressSet;

    LibAddressSet.AddressSet internal _actors;

    constructor(address _puzzle) {
        puzzle = Puzzle(_puzzle);
    }

    modifier createActor() {
        currentActor = msg.sender;

        _actors.add(msg.sender);
        _;
    }

    modifier useExistActor(uint256 actorIndexSeed) {
        currentActor = _actors.rand(actorIndexSeed);
        if (currentActor == address(0xaabbcc)) {
            makeDeposit(123);
        }
        _;
    }

    function makeDeposit(uint256 amount) public createActor {
        amount = bound(amount, 20 ether, 100 ether > address(this).balance ? address(this).balance : 100 ether);
        deposited += amount;
        fund(currentActor, amount);
        vm.prank(currentActor);
        puzzle.makeDeposit{value: amount}();
    }

    function doWithdraw(uint256 amount, uint256 actorSeed) public useExistActor(actorSeed) {
        amount = bound(amount, 0, puzzle.internalBalance(address(this)));
        deposited -= amount;
        vm.startPrank(currentActor);
        puzzle.doWithdraw(amount);
        fund(address(this), amount);
        vm.stopPrank();
    }

    function beta(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.prank(currentActor);
        puzzle.beta();
        vm.stopPrank();
    }

    function gamme(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.prank(currentActor);
        puzzle.gamma();
        vm.stopPrank();
    }

    function delta(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.prank(currentActor);
        puzzle.delta();
        vm.stopPrank();
    }

    function epsilon(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.startPrank(currentActor);
        puzzle.epsilon();
        vm.stopPrank();
    }

    function zeta(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.startPrank(currentActor);
        puzzle.zeta();
        vm.stopPrank();
    }

    function theta(uint256 actorSeed) public useExistActor(actorSeed) {
        vm.startPrank(currentActor);
        puzzle.theta();
        vm.stopPrank();
    }

    function verify() public {
        if (puzzle.sum() == 777 && puzzle.steps() <= 15) {
            vm.startPrank(currentActor);
            puzzle.verify();
            vm.stopPrank();
        }
    }

    function fund(address user, uint256 amount) internal {
        payable(user).transfer(amount);
    }

    receive() external payable {}
}
