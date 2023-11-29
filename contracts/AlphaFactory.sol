// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.6.12;

import "./AlphaPair.sol";

contract AlphaFactory {
    address public alpha;
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );

    constructor(address _alpha) public {
        require(_alpha != address(0), "Alpha: ZERO_ADDRESS");
        alpha = _alpha;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenAddress) external returns (address pair) {
        require(alpha != tokenAddress, "Alpha: IDENTICAL_ADDRESSES");
        (address token0, address token1) = alpha < tokenAddress
            ? (alpha, tokenAddress)
            : (tokenAddress, alpha);
        require(token0 != address(0), "Alpha: ZERO_ADDRESS");
        require(getPair[token0][token1] == address(0), "Alpha: PAIR_EXISTS"); // single check is sufficient
        bytes memory bytecode = type(AlphaPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IAlphaPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }
}
