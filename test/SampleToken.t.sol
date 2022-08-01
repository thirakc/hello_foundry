// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SampleToken.sol";

contract SampleTokenTest is Test {
    SampleToken sampleToken;
    address bob;
    address alice;

     function setUp() public {
        bob = address(0x1);
        alice = address(0x2);
        vm.prank(bob);
        sampleToken = new SampleToken(10 ether, "Gold", "GLD");
    }

    function testTotalSuppply() public {
        uint256 totalSupply = sampleToken.totalSupply();
        assertEq(10 ether, totalSupply);
    }

    function testBalanceOf() public {
        uint256 balanceOf = sampleToken.balanceOf(bob);
        assertEq(10 ether, balanceOf);
    }

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function testTransferEvent() public {
        vm.prank(bob);
        vm.expectEmit(true, true, false, true, address(sampleToken));
        emit SampleTokenTest.Transfer(address(bob), address(alice), 5 ether);
        sampleToken.transfer(alice, 5 ether);
    }

    function testTransferOverBalance() public {
        vm.prank(bob);
        vm.expectRevert(bytes("ERC20: transfer amount exceeds balance"));
        sampleToken.transfer(alice, 20 ether);
    }

    function testFuzz(uint256 amount) public {
        vm.prank(bob);
        vm.assume(amount < 10 ether);
        sampleToken.transfer(alice, amount);
    }
}
 