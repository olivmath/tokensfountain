// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {TokensFountain} from "../src/TokensFountain.sol";
import {BaseSetup} from "./BaseSetup.sol";
import {ERC20} from "../src/ERC20.sol";

contract TokensFountainTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
    }

    function testCreateNewToken() public {
        vm.startPrank(user);
        string memory name = "MyToken";
        string memory symbol = "MTK";
        uint256 supply = 10 * 1e6;
        address token = tf.makeToken{value: 1.4 ether}(name, symbol, 6, supply);

        ERC20 t = ERC20(token);
        assertEq(t.totalSupply(), supply);
    }
}
