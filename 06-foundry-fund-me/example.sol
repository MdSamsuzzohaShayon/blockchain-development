function testWithdrawFromMultipleFunders() {
    uint160 numberOfFunders = 10;
    uint160 startingFunderIndex = 2;
    for (
        uint160 i = startingFunderIndex;
        i < numberOfFunders + startingFunderIndex;
        i++
    ) {
        // we get hoax from stdcheats
        // prank + deal
        hoax(address(i), SEND_VALUE);
        fundMe.fund{value: SEND_VALUE}();
    }

    uint256 startingFundMeBalance = address(fundMe).balance;
    uint256 startingOwnerBalance = fundMe.getOwner().balance;

    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();

    assert(address(fundMe).balance == 0);
    assert(
        startingFundMeBalance + startingOwnerBalance ==
            fundMe.getOwner().balance
    );
}
