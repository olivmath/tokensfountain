// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Utils} from "./Utils.sol";
import {TokensFountain} from "../src/TokensFountain.sol";

contract BaseSetup is Utils {
    TokensFountain tf;

    address payable owner;
    address payable user;
    address[] users;

    function setUp() public virtual {
        Utils utils = new Utils();
        users = utils.createUsers(2);

        owner = payable(users[0]);
        user = payable(users[1]);

        tf = new TokensFountain();
    }
}
