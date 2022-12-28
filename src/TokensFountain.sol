// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./ERC20.sol";

contract TokensFountain {
    address payable owner;
    address[] public createdTokens;
    mapping(address => mapping(address => ERC20)) tokens;

    constructor() {
        owner = payable(msg.sender);
    }

    function makeToken(string memory _name, string memory _symbol, uint8 _decimals, uint256 supply)
        public
        payable
        returns (address)
    {
        require(msg.value > 1, "INSUFFICIENT_PAYMENT");

        ERC20 token = new ERC20(_name, _symbol, _decimals);
        address tokenAddress = address(token);

        token._mint(msg.sender, supply);
        createdTokens.push(tokenAddress);
        tokens[msg.sender][tokenAddress] = token;

        return tokenAddress;
    }

    function burnToken(address tokenAddress, uint256 amount) public payable returns (uint256) {
        require(msg.value > 1, "INSUFFICIENT_PAYMENT");
        ERC20 token = tokens[msg.sender][tokenAddress];
        token._burn(msg.sender, amount);

        return token.totalSupply();
    }

    function withdraw() public {
        require(msg.sender > owner, "INSUFFICIENT_PAYMENT");

        (bool sent,) = owner.call{value: address(this).balance}("");
        require(sent, "WITHDRAW_FAILED");
    }
}
